# Phân tích toàn bộ dự án Billing-app

> Ngày khảo sát: 2026-09-13  
> Phạm vi: đọc và đối chiếu source code, cấu hình, ADR, kiểm thử frontend/backend.  
> Mục đích: tạo nền tảng nội dung cho báo cáo bài tập lớn đại học.  
> Nguyên tắc: chỉ khẳng định những gì có bằng chứng trong repository; ADR được xem là quyết định thiết kế, không tự động xem là chức năng đã hoàn thiện.

## 1. Tóm tắt kết quả

Billing-app là ứng dụng quản lý bán hàng/POS dạng monorepo gồm hai phần:

- `Front-end`: giao diện React và Vite, điều hướng theo vai trò, quản lý server state bằng TanStack React Query và gọi API qua Axios.
- `billingsoftware`: REST API Java Spring Boot, Spring Data JPA, MySQL, Spring Security/JWT, AWS S3 và PayOS.

Các năng lực nghiệp vụ chính đã được thể hiện trong mã nguồn gồm đăng nhập và phân quyền, quản lý danh mục/mặt hàng/biến thể, modifier, khách hàng, khuyến mãi, tạo và tra cứu đơn hàng, thanh toán PayOS hoặc tiền mặt, quản lý tồn kho theo giao dịch, dashboard và activity log.

Điểm đáng chú ý về thiết kế là hệ thống dùng `InventoryTransaction` làm sổ cái biến động kho, lưu `cachedStockQuantity` trên biến thể để đọc nhanh, đánh giá khuyến mãi ở phía server, có quy trình bù trừ khi hủy/xóa đơn PENDING và dùng access token JWT kết hợp refresh token xoay vòng qua cookie HttpOnly.

Kết quả kiểm chứng cục bộ trong lần khảo sát:

| Hạng mục | Kết quả | Diễn giải |
|---|---:|---|
| Frontend production build | Đạt | `npm run build` hoàn thành thành công với Vite |
| Frontend unit tests | 11/12 đạt | 1 test thất bại vì session thực tế có thêm trường `name: null` |
| Backend Maven tests | Chưa chạy được | `mvnw.cmd` báo `Cannot start maven from wrapper`; môi trường chỉ phát hiện Java, không phát hiện Maven CLI |
| Kiểm chứng toàn bộ backend runtime | Chưa thực hiện | Cần môi trường MySQL và biến môi trường cấu hình |

Do đó, không nên viết trong báo cáo rằng “toàn bộ kiểm thử đều passed”. Có thể viết chính xác rằng repository có bộ test tích hợp backend và test frontend, trong lần chạy này frontend build đạt, frontend còn một lỗi kiểm thử, còn backend chưa có kết quả chạy do vấn đề công cụ/môi trường.

## 2. Phạm vi và phương pháp nghiên cứu

Nguồn được ưu tiên theo thứ tự:

1. Source code triển khai trong `Front-end/src` và `billingsoftware/src/main`.
2. Test trong `Front-end/test` và `billingsoftware/src/test`.
3. Cấu hình build/package và `application.properties`.
4. `CONTEXT.md`, README và các ADR trong `docs/adr`.

Các số lượng cấu trúc quan sát được tại thời điểm khảo sát: 12 file trực tiếp trong `Front-end/src/pages`, 69 file trong `Front-end/src/features`, 11 service frontend, 13 controller backend, 17 entity backend, 19 file test backend và 5 file test frontend. Đây là số lượng file, không phải số lượng chức năng đã hoàn thiện.

## 3. Kiến trúc tổng thể

### 3.1. Mô hình triển khai logic

```text
Người dùng
   |
   v
React/Vite Front-end
   | Axios + JSON + Bearer access token
   v
Spring Boot REST API (/api/v1.0)
   | Spring Security/JWT
   | Service layer + Spring Data JPA
   v
MySQL

Các tích hợp ngoài: AWS S3 (file/hình ảnh), PayOS (payment link và webhook)
```

`CONTEXT.md` mô tả monorepo gồm `Front-end` và `billingsoftware`, frontend giao tiếp REST/JSON và backend dùng Spring Data JPA/MySQL. Các dependency tương ứng cũng xuất hiện trong `Front-end/package.json` và `billingsoftware/pom.xml` [CONTEXT.md](../../CONTEXT.md#L3-L23), [package.json](../../Front-end/package.json#L6-L37), [pom.xml](../../billingsoftware/pom.xml#L5-L31).

### 3.2. Backend

Backend có các lớp chính:

- Controller: nhận HTTP request và chuyển cho service.
- Service/service implementation: xử lý nghiệp vụ, giao dịch và phối hợp repository.
- Entity: ánh xạ bảng dữ liệu bằng JPA.
- IO/DTO: request/response cho API.
- Repository: truy vấn dữ liệu.
- Config/filter: bảo mật, PayOS, AWS và JWT.

`application.properties` đặt context path backend là `/api/v1.0`, kết nối MySQL qua biến môi trường và dùng `spring.jpa.hibernate.ddl-auto=update` [application.properties](../../billingsoftware/src/main/resources/application.properties#L1-L25).

### 3.3. Frontend

Frontend tổ chức theo pages, features, hooks, services và UI components. `App.jsx` dùng `QueryClientProvider`, `BrowserRouter`, route guard, lazy loading cho các trang quản trị và fallback loading [App.jsx](../../Front-end/src/App.jsx#L1-L59).

API logic được tách vào `src/services`. Server state được quản lý bằng React Query; query mặc định có `staleTime` một giờ và retry tối đa ba lần cho lỗi không phải 401/403 [queryClient.js](../../Front-end/src/utils/queryClient.js#L1-L19).

## 4. Chức năng nghiệp vụ

### 4.1. Xác thực và phân quyền

Backend cung cấp login, refresh, logout và mã hóa mật khẩu. `SecurityConfig` đặt session stateless, tắt CSRF cho API, cho phép một số endpoint công khai và yêu cầu `ROLE_USER` hoặc `ROLE_ADMIN` cho các nhóm nghiệp vụ; các endpoint `/admin/**` yêu cầu admin [SecurityConfig.java](../../billingsoftware/src/main/java/learn/java/billingsoftware/config/SecurityConfig.java#L22-L65).

Frontend bảo vệ route bằng `ProtectedRoute` và giới hạn nhóm trang quản trị bằng `AdminRoute`. Axios interceptor gắn access token vào header; khi gặp lỗi đủ điều kiện, frontend dùng một refresh promise dùng chung, cập nhật session và thử lại request một lần; nếu refresh thất bại thì xóa session, xóa query cache và chuyển về `/login` [axiosConfig.js](../../Front-end/src/utils/axiosConfig.js#L7-L65).

Backend refresh token được cấp/rotate/revoke trong service riêng và lưu hash trong database theo code `RefreshTokenService`. Cookie được cấu hình HttpOnly, Secure, SameSite, path và thời hạn tại `AuthController` và `application.properties` [AuthController.java](../../billingsoftware/src/main/java/learn/java/billingsoftware/controller/AuthController.java#L30-L120), [RefreshTokenService.java](../../billingsoftware/src/main/java/learn/java/billingsoftware/service/RefreshTokenService.java#L33-L96).

### 4.2. Danh mục, mặt hàng, biến thể và modifier

Backend có controller/service cho category, item, variant và modifier group. Mặt hàng có thể gắn nhiều biến thể; biến thể có SKU, giá cơ sở, thuộc tính động và tồn kho cache. `VariantEntity` dùng converter JSON cho `attributes`, còn `Modifier` là lựa chọn bổ sung được lưu riêng với item/variant [VariantEntity.java](../../billingsoftware/src/main/java/learn/java/billingsoftware/entity/VariantEntity.java#L16-L50).

Frontend có trang quản lý items, categories và modifiers cùng các hook CRUD tương ứng. Hình ảnh được hỗ trợ qua service upload AWS S3 theo dependency và cấu hình backend.

### 4.3. Đơn hàng, POS và thanh toán

`OrderController` cung cấp phân trang/lọc đơn, tạo đơn, xem đơn, xóa đơn, hủy đơn và chuyển từ PayOS sang tiền mặt [OrderController.java](../../billingsoftware/src/main/java/learn/java/billingsoftware/controller/OrderController.java#L13-L58).

Trong `OrderServiceImpl`, server đánh giá lại promotion và tổng tiền trước khi lưu order; cập nhật CRM khách hàng; tăng quota promotion; tạo order item; ghi giao dịch tồn kho OUT; sau đó tạo payment link PayOS nếu phương thức là PAYOS [OrderServiceImpl.java](../../billingsoftware/src/main/java/learn/java/billingsoftware/service/impl/OrderServiceImpl.java#L55-L87), [OrderServiceImpl.java](../../billingsoftware/src/main/java/learn/java/billingsoftware/service/impl/OrderServiceImpl.java#L90-L177), [OrderServiceImpl.java](../../billingsoftware/src/main/java/learn/java/billingsoftware/service/impl/OrderServiceImpl.java#L179-L217).

Webhook PayOS xác thực webhook bằng SDK, tìm order theo order code và chuyển payment status sang COMPLETED khi mã giao dịch là `00` [PaymentWebhookController.java](../../billingsoftware/src/main/java/learn/java/billingsoftware/controller/PaymentWebhookController.java#L22-L63).

### 4.4. Hủy, xóa và chuyển phương thức thanh toán

Mã nguồn triển khai các bất biến quan trọng:

- Không xóa order COMPLETED.
- Chỉ cho xóa order PENDING hoặc CANCELLED.
- Xóa order PENDING sẽ tạo giao dịch IN bù trừ trước khi xóa.
- Hủy order PENDING chuyển payment status thành CANCELLED và bù trừ kho, promotion, CRM, PayOS.
- Chuyển sang CASH chỉ áp dụng cho order PENDING và không xuất kho lần hai.

Các điều kiện này nằm trực tiếp trong `deleteOrder`, `cancelOrder`, `switchToCash` và `compensatePendingOrder` [OrderServiceImpl.java](../../billingsoftware/src/main/java/learn/java/billingsoftware/service/impl/OrderServiceImpl.java#L298-L321), [OrderServiceImpl.java](../../billingsoftware/src/main/java/learn/java/billingsoftware/service/impl/OrderServiceImpl.java#L385-L432), [OrderServiceImpl.java](../../billingsoftware/src/main/java/learn/java/billingsoftware/service/impl/OrderServiceImpl.java#L434-L497).

### 4.5. Tồn kho theo ledger

`InventoryTransactionEntity` lưu loại giao dịch, số lượng, variant, reference và ghi chú. `VariantEntity` lưu thêm `cachedStockQuantity` để truy xuất nhanh [InventoryTransactionEntity.java](../../billingsoftware/src/main/java/learn/java/billingsoftware/entity/InventoryTransactionEntity.java#L11-L45), [VariantEntity.java](../../billingsoftware/src/main/java/learn/java/billingsoftware/entity/VariantEntity.java#L38-L45).

Inventory controller có endpoint ghi giao dịch, stock check và tra cứu lịch sử. Khi checkout, order service ghi OUT với số lượng âm, tính lại tồn kho từ repository rồi cập nhật giá trị cache. Khi bù trừ, service ghi IN và tính lại cache. Đây là mô hình append-style ledger kết hợp read model cache, không phải chỉ cập nhật một con số tồn kho đơn lẻ.

### 4.6. Khuyến mãi

Backend tách admin promotion endpoints và public endpoints cho danh sách promotion active/evaluation. Promotion được đánh giá server-side trong checkout; code có kiểm tra usage limit và tăng `timesUsed`. ADR 0003 xác định không cho phép stacking, còn test `PromotionEvaluationIntegrationTest` và `PromotionIntegrationTest` là bằng chứng kiểm thử theo hướng này [0003-prevent-promotion-stacking.md](../../docs/adr/0003-prevent-promotion-stacking.md#L1-L11).

### 4.7. Khách hàng và dashboard

Customer controller/service hỗ trợ tạo, đọc, tìm theo số điện thoại, cập nhật và xóa. Trong checkout, customer được liên kết theo customer id hoặc phone number; `orderCount` và `totalSpent` được cập nhật, sau đó được hoàn lại trong quy trình bù trừ.

Dashboard controller/service cung cấp dữ liệu tổng hợp; test `DashboardMetricIntegrationTest` kiểm thử các metric theo ngày và order.

### 4.8. Activity log

`ActivityLogEntity` ánh xạ bảng `tbl_activity_logs` với email người dùng, action, entity type/id, mô tả và thời gian [ActivityLogEntity.java](../../billingsoftware/src/main/java/learn/java/billingsoftware/entity/ActivityLogEntity.java#L12-L52).

`ActivityLogServiceImpl` tự lấy email từ `SecurityContextHolder` khi caller không truyền email, ghi log và hỗ trợ lọc/phân trang. Staff bị giới hạn xem log của chính mình; admin có thể lọc theo user [ActivityLogServiceImpl.java](../../billingsoftware/src/main/java/learn/java/billingsoftware/service/impl/ActivityLogServiceImpl.java#L32-L77).

## 5. Mô hình dữ liệu khái quát

```text
Category 1 --- N Item 1 --- N Variant
                         |
                         +--- N InventoryTransaction
                         +--- N ModifierGroup --- N Modifier

Customer 1 --- N Order 1 --- N OrderItem N --- 1 Variant/Item
Promotion 1 --- N Order (tham chiếu promotionId)
User 1 --- N ActivityLog
Order --- PaymentDetails (embedded) --- PayOS
```

Các quan hệ order/order item thể hiện trong `OrderEntity` bằng `@OneToMany(cascade = ALL, orphanRemoval = true)`. Variant liên kết về Item bằng `@ManyToOne`; inventory transaction liên kết về Variant bằng `@ManyToOne` [OrderEntity.java](../../billingsoftware/src/main/java/learn/java/billingsoftware/entity/OrderEntity.java#L15-L52), [VariantEntity.java](../../billingsoftware/src/main/java/learn/java/billingsoftware/entity/VariantEntity.java#L47-L50), [InventoryTransactionEntity.java](../../billingsoftware/src/main/java/learn/java/billingsoftware/entity/InventoryTransactionEntity.java#L27-L30).

## 6. Đối chiếu ADR với triển khai

| ADR | Nội dung | Đánh giá từ source |
|---|---|---|
| 0001 | Tách variant và modifier | Có bằng chứng entity, controller và service tương ứng |
| 0002 | Negative stock/offline sync | Có logic cho tồn kho âm trong test/ledger; chưa thấy service worker, IndexedDB hoặc API sync offline trong source frontend |
| 0003 | Không stacking promotion | Có service evaluation và test promotion; phù hợp với ADR |
| 0004 | Inventory ledger | Có entity ledger, transaction service và bù trừ |
| 0005 | JSON variant attributes | Có `JsonAttributesConverter` và field map trong entity |
| 0006 | QR lifecycle/cancellation | Có cancel, switch-to-cash, bù trừ và webhook PayOS |
| 0007 | Refresh token xoay vòng HttpOnly | Có controller/service/entity/cấu hình cookie |
| 0008 | Bù trừ xóa order và audit invariants | Có logic bù trừ và activity log ở các luồng chính |
| 0009 | Client performance/state colocation | Có lazy route loading, React Query và cấu trúc hooks; cần đánh giá sâu hơn từng component để kết luận đầy đủ |

Kết luận quan trọng: ADR 0002 mô tả frontend đang tiến hóa thành Offline-First PWA bằng IndexedDB, nhưng lần khảo sát không tìm thấy `serviceWorker`, `IndexedDB`, Dexie hoặc API đồng bộ offline trong source frontend. Vì vậy báo cáo chỉ nên mô tả “có quyết định thiết kế/cho phép negative stock”, không khẳng định “PWA offline sync đã hoàn thiện”.

## 7. Kiểm thử và chất lượng hiện tại

Backend có 19 file test, phần lớn dùng `@SpringBootTest`, `@AutoConfigureMockMvc` và `@Transactional`. Các nhóm test bao phủ auth/menubar, CRUD category/item/user/customer/modifier/promotion, order checkout, order deletion compensation, pagination, inventory ledger, stock check, dashboard, activity log và refresh token.

Frontend có 5 file test Node.js tập trung vào thông báo lỗi auth, retry/refresh policy, session memory, promotion error mapping và variant defaults.

Kết quả chạy thực tế:

- `npm run build`: đạt.
- `npm test`: 11 test đạt, 1 test thất bại tại `Front-end/test/auth-session.test.js`. Test kỳ vọng object session không có `name`, trong khi implementation trả thêm `name: null`.
- `mvnw.cmd test`: không khởi chạy được Maven wrapper trong môi trường hiện tại với lỗi `Cannot start maven from wrapper`; đây không phải bằng chứng backend test fail về nghiệp vụ.

## 8. Rủi ro và technical debt

1. `ddl-auto=update` phù hợp phát triển nhưng thiếu kiểm soát migration cho production; nên xem xét Flyway hoặc Liquibase.
2. Cấu hình CORS hiện chứa origin IP cụ thể và localhost; cần quản lý theo môi trường triển khai.
3. `server.error.include-message=always` và `include-binding-errors=always` cần được xem xét khi chạy production vì có thể làm lộ thông tin lỗi.
4. PayOS return/cancel URL trong `OrderServiceImpl` đang là localhost, cần cấu hình theo môi trường thật.
5. Một số lỗi PayOS được in qua `System.err` thay vì cơ chế logging có cấu trúc.
6. API trả DTO/list trực tiếp, chưa có wrapper chung; điều này đơn giản nhưng làm việc bổ sung metadata/pagination không đồng nhất giữa endpoint.
7. Test frontend hiện có bất nhất giữa contract session và implementation ở trường `name`.
8. ADR offline-first chưa được chứng minh đầy đủ bằng implementation frontend.
9. Chưa có kết quả backend test trong lần khảo sát do thiếu khả năng khởi chạy Maven wrapper và chưa xác nhận database test runtime.

## 9. Đề cương báo cáo bài tập lớn đề xuất

### Chương 1. Tổng quan đề tài

- Bối cảnh và nhu cầu quản lý bán hàng.
- Mục tiêu xây dựng hệ thống POS.
- Phạm vi: sản phẩm, biến thể, tồn kho, đơn hàng, thanh toán, khuyến mãi, khách hàng, người dùng và audit log.
- Công nghệ sử dụng.

### Chương 2. Phân tích và thiết kế hệ thống

- Kiến trúc frontend/backend.
- Actor và phân quyền admin/staff.
- Use case nghiệp vụ.
- Mô hình dữ liệu và quan hệ entity.
- Thiết kế inventory ledger.
- Thiết kế vòng đời order/payment.
- Thiết kế xác thực JWT và refresh token.
- Thiết kế promotion evaluation và audit trail.

### Chương 3. Cài đặt và kiểm thử

- Cấu trúc source code.
- Các màn hình frontend.
- REST API và service nghiệp vụ.
- Luồng checkout PayOS/CASH.
- Luồng hủy/xóa order và bù trừ.
- Kiểm thử frontend/backend.
- Kết quả build/test và các giới hạn môi trường.

### Kết luận và hướng phát triển

- Kết quả đạt được.
- Hạn chế: migration, cấu hình production, offline sync chưa đầy đủ, test runtime backend chưa xác minh trong môi trường khảo sát.
- Hướng phát triển: migration có version, CI chạy test, hoàn thiện offline queue/sync, chuẩn hóa API response, quan sát/logging và triển khai cấu hình theo môi trường.

## 10. Kết luận nghiên cứu

Billing-app đã hình thành một nền tảng POS có nhiều quy tắc nghiệp vụ đáng kể, đặc biệt ở checkout server-side, inventory ledger, bù trừ order và audit trail. Mã nguồn đủ cơ sở để xây dựng báo cáo bài tập lớn theo hướng phân tích hệ thống thực tế.

Tuy nhiên, báo cáo cần phân biệt rõ ba loại thông tin: chức năng đã thấy trong code, quyết định thiết kế ghi trong ADR, và phần chưa kiểm chứng do môi trường hoặc thiếu implementation. Việc giữ phân biệt này giúp báo cáo có tính học thuật và tránh thổi phồng mức độ hoàn thiện của dự án.

## Tài liệu nội bộ đã sử dụng

- [CONTEXT.md](../../CONTEXT.md)
- [README.md](../../README.md)
- [Front-end/package.json](../../Front-end/package.json)
- [billingsoftware/pom.xml](../../billingsoftware/pom.xml)
- [billingsoftware/application.properties](../../billingsoftware/src/main/resources/application.properties)
- [Các ADR](../../docs/adr/)
- Source code trong `Front-end/src` và `billingsoftware/src/main`
- Test trong `Front-end/test` và `billingsoftware/src/test`
