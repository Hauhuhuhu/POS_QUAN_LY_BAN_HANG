# BÁO CÁO BÀI TẬP LỚN
**Đề tài:** Xây dựng website POS quản lý bán hàng  
**Yêu cầu đầu ra:** Báo cáo kỹ thuật (Tối thiểu 40 trang) + Mã nguồn chương trình hoàn chỉnh  
**Mục đích file:** Bản đặc tả cấu trúc và checklist tiến độ dành cho tác giả và AI Agent hỗ trợ viết bài

---

## 📌 BẢNG THEO DÕI TIẾN ĐỘ TỔNG QUAN

| Phần mục | Số trang dự kiến | Trạng thái | Ghi chú kỹ thuật |
| :--- | :---: | :---: | :--- |
| **Phần đầu & Danh mục** | 3 - 5 trang | ⏳ Đang chờ | Bìa, Lời cảm ơn, Mục lục, Bảng từ viết tắt, Bảng phân công |
| **Chương 1: Công nghệ sử dụng** | 7 - 10 trang | ⏳ Đang chờ | Lý thuyết, đặc tả phiên bản, so sánh ưu nhược điểm |
| **Chương 2: Phân tích & Thiết kế** | 15 - 20 trang | ⏳ Đang chờ | Biểu đồ UML, mô hình ERD, thiết kế chi tiết bảng CSDL |
| **Chương 3: Cài đặt chương trình** | 12 - 16 trang | ⏳ Đang chờ | Ảnh chụp màn hình, luồng nghiệp vụ POS, test case |
| **Kết luận & Tài liệu tham khảo** | 2 - 3 trang | ⏳ Đang chờ | Đánh giá, hạn chế, hướng mở rộng, nguồn trích dẫn |

---

## PHẦN MỞ ĐẦU & DANH MỤC QUY CHUẨN

- [ ] **Trang bìa chính & bìa phụ** (Theo mẫu quy định của trường/khoa)
- [ ] **Lời cảm ơn / Lời cam đoan**
- [ ] **Mục lục tự động**
- [ ] **Danh mục chữ viết tắt** (POS, CSDL/DBMS, API, MVC, UI/UX,...)
- [ ] **Danh mục hình ảnh** (Hình 1.1, Hình 2.1,...)
- [ ] **Danh mục bảng biểu** (Bảng 1.1, Bảng 2.1,...)
- [ ] **Bảng phân công nhiệm vụ thành viên:**
  - Họ tên, MSSV, Nhiệm vụ chi tiết, Tỉ lệ hoàn thành (%)

---

## CHƯƠNG 1: TỔNG QUAN VÀ TÌM HIỂU CÁC CÔNG NGHỆ SỬ DỤNG
*Mục tiêu trang: ~8 - 10 trang*

### 1.1. Tổng quan về đề tài
- [ ] Khái niệm hệ thống POS (Point of Sale) và vai trò trong bán lẻ hiện đại.
- [ ] Sự cần thiết của việc xây dựng hệ thống POS trên nền tảng Web.

### 1.2. Công nghệ giao diện người dùng (Front-end)
- [ ] **HTML5 & CSS3:** Cấu trúc ngữ nghĩa, bố cục Responsive layout.
- [ ] **JavaScript & Thư viện bổ trợ:** (Chọn công nghệ thực tế: ReactJS / VueJS / Vanilla JS, Bootstrap 5 / Tailwind CSS).
- [ ] Đánh giá lý do lựa chọn công nghệ Front-end cho giao diện bán hàng tại quầy (tốc độ, độ trễ thấp).

### 1.3. Công nghệ xử lý nghiệp vụ máy chủ (Back-end)
- [ ] **Ngôn ngữ & Framework:** (Chọn: PHP Laravel / C# ASP.NET Core / Java Spring Boot / Node.js Express).
- [ ] Kiến trúc MVC (Model - View - Controller) hoặc RESTful API áp dụng trong hệ thống.
- [ ] Cơ chế xử lý phiên làm việc, xác thực và phân quyền (Session, JWT).

### 1.4. Hệ quản trị cơ sở dữ liệu
- [ ] Giới thiệu Hệ quản trị CSDL được chọn (MySQL / Microsoft SQL Server / PostgreSQL).
- [ ] Tính năng hỗ trợ toàn vẹn dữ liệu, giao dịch (ACID) khi trừ tồn kho và thanh toán hóa đơn.

### 1.5. Các công cụ và phần mềm hỗ trợ phát triển
- [ ] Môi trường lập trình (Visual Studio Code / PhpStorm / Visual Studio).
- [ ] Công cụ thiết kế CSDL & quản lý mã nguồn (Git, GitHub, MySQL Workbench/DBeaver, Draw.io/StarUML).

---

## CHƯƠNG 2: TÌM HIỂU BÀI TOÁN VÀ PHÂN TÍCH THIẾT KẾ HỆ THỐNG
*Mục tiêu trang: ~15 - 20 trang (Trọng tâm học thuật)*

### 2.1. Khảo sát nghiệp vụ và xác định yêu cầu
- [ ] **Mục đích của hệ thống:** Tối ưu tốc độ bán hàng tại quầy, quản lý kho, theo dõi doanh thu.
- [ ] **Phạm vi của hệ thống:** 
  - Phạm vi nghiệp vụ (Bán lẻ tại quầy, in bill, nhập hàng, quản trị danh mục).
  - Đối tượng sử dụng (Thu ngân, Thủ kho, Quản lý/Chủ cửa hàng).
- [ ] **Yêu cầu chức năng:**
  - Nhóm Thu ngân (Tạo đơn, quét mã vạch, tính tiền, áp mã giảm giá, in hóa đơn).
  - Nhóm Quản lý (Quản lý hàng hóa, tồn kho, quản lý nhân viên, báo cáo doanh số).
- [ ] **Yêu cầu phi chức năng:** Tốc độ phản hồi ($< 1$ giây cho thao tác bán lẻ), tính toàn vẹn dữ liệu, tính bảo mật, tính khả dụng.

### 2.2. Phân tích và thiết kế chức năng
- [ ] **Biểu đồ phân rã chức năng (BFD - Business Function Diagram):**
  - Cây phân cấp: Quản lý hệ thống $\rightarrow$ Bán hàng POS $\rightarrow$ Quản lý kho $\rightarrow$ Thống kê báo cáo.
- [ ] **Mô hình Use Case:**
  - Biểu đồ Use Case tổng quát toàn hệ thống.
  - Phân rã Use Case theo từng Actor (Admin, Thu ngân, Thủ kho).
  - Đặc tả chi tiết các Use Case chính (Mẫu chuẩn: Tên Use Case, Actor, Tiền điều kiện, Luồng sự kiện chính, Luồng ngoại lệ, Hậu điều kiện):
    - *Use Case: Đăng nhập hệ thống*
    - *Use Case: Thực hiện bán hàng tại quầy (Tạo hóa đơn & Thanh toán)*
    - *Use Case: Quản lý/Cập nhật sản phẩm & Tồn kho*
    - *Use Case: Xem báo cáo thống kê doanh thu*
- [ ] **Biểu đồ hoạt động (Activity Diagram):**
  - Quy trình thanh toán đơn hàng tại quầy.
  - Quy trình nhập kho hàng hóa.
- [ ] **Biểu đồ tuần tự (Sequence Diagram):**
  - Luồng xác thực đăng nhập.
  - Luồng giao dịch thanh toán và cập nhật trừ số lượng kho tức thời.
- [ ] **Biểu đồ lớp (Class Diagram):**
  - Chi tiết các thuộc tính, phương thức và quan hệ giữa các lớp đối tượng (`User`, `Product`, `Category`, `Order`, `OrderDetail`, `Customer`,...).
- [ ] **Biểu đồ thành phần và Biểu đồ triển khai (Component & Deployment Diagram):**
  - Mô hình kiến trúc triển khai thực tế (Web Server, Database Server, Client POS).

### 2.3. Phân tích và thiết kế cơ sở dữ liệu
- [ ] **Mô hình thực thể liên kết (ERD - Entity Relationship Diagram):**
  - Mô hình ERD mức quan niệm và mức logic.
  - Xác định các mối quan hệ ($1-1$, $1-n$, $n-n$).
- [ ] **Thiết kế chi tiết các bảng dữ liệu (Data Dictionary):**
  - Bảng `users` (Tài khoản, phân quyền)
  - Bảng `roles` (Vai trò quyền hạn)
  - Bảng `categories` (Danh mục sản phẩm)
  - Bảng `products` (Sản phẩm, mã vạch SKU, đơn giá, tồn kho)
  - Bảng `customers` (Khách hàng thân thiết, điểm tích lũy)
  - Bảng `orders` / `invoices` (Hóa đơn bán hàng, ngày tạo, tổng tiền, phương thức thanh toán)
  - Bảng `order_details` (Chi tiết hóa đơn, số lượng, đơn giá thời điểm bán)
  - Bảng `inventory_transactions` / `suppliers` (Phiếu nhập xuất kho, nhà cung cấp)

---

## CHƯƠNG 3: CÀI ĐẶT VÀ THỰC NGHIỆM CHƯƠNG TRÌNH
*Mục tiêu trang: ~12 - 16 trang*

### 3.1. Cài đặt môi trường và Cơ sở dữ liệu
- [ ] Cấu hình môi trường chạy (Web server, Node/PHP version, Database).
- [ ] Kịch bản khởi tạo CSDL (Migration / file SQL script mẫu).

### 3.2. Hiện thực giao diện và chức năng POS (Dành cho Thu ngân)
- [ ] **Màn hình bán hàng nhanh (POS Checkout View):**
  - Giao diện danh mục sản phẩm trực quan, tìm kiếm nhanh theo tên/mã vạch.
  - Giỏ hàng tạm thời, thay đổi số lượng, chiết khấu, thuế VAT.
  - Tính tiền thừa, lựa chọn phương thức thanh toán (Tiền mặt, Chuyển khoản QR).
  - Thiết kế mẫu in hóa đơn bán lẻ (Bill layout 80mm/58mm).

### 3.3. Hiện thực phân hệ Quản trị (Dành cho Admin/Quản lý)
- [ ] **Trang tổng quan (Dashboard):** Biểu đồ doanh thu ngày/tuần/tháng, số đơn hàng mới, cảnh báo hàng sắp hết.
- [ ] **Trang quản lý sản phẩm:** Thêm mới, sửa, xóa, tìm kiếm, lọc theo danh mục, quản lý mã vạch.
- [ ] **Trang quản lý đơn hàng / hóa đơn:** Tra cứu lịch sử hóa đơn, in lại hóa đơn, hủy hóa đơn sai.
- [ ] **Trang quản lý người dùng và phân quyền:** Cấp tài khoản nhân viên, gán vai trò.
- [ ] **Trang thống kê & báo cáo:** Báo cáo doanh thu, sản phẩm bán chạy, tồn kho.

### 3.4. Kiểm thử hệ thống (Testing)
- [ ] Bảng kịch bản kiểm thử chức năng (Test Cases chính: Đăng nhập, Tạo đơn hàng, Kiểm tra trừ tồn kho, Xác nhận tiền thừa).
- [ ] Đánh giá kết quả kiểm thử.

---

## KẾT LUẬN VÀ HƯỚNG PHÁT TRIỂN
*Mục tiêu trang: ~2 - 3 trang*

### 1. Những kết quả đạt được
- [ ] Mức độ hoàn thành so với mục tiêu ban đầu đặt ra.
- [ ] Điểm mạnh của hệ thống (Giao diện thân thiện, quy trình bán lẻ nhanh chóng, chuẩn hóa CSDL).

### 2. Hạn chế của hệ thống
- [ ] Những tính năng chưa kịp hoàn thiện (Ví dụ: Chưa tích hợp cổng thanh toán trực tiếp qua API ngân hàng, chưa hỗ trợ chế độ Offline khi mất Internet).

### 3. Hướng phát triển trong tương lai
- [ ] Tích hợp máy in bill chuyên dụng và máy quét mã vạch không dây.
- [ ] Mở rộng ứng dụng di động cho nhân viên kiểm kê kho.
- [ ] Ứng dụng AI phân tích hành vi mua sắm và dự báo lượng hàng cần nhập.

---

## TÀI LIỆU THAM KHẢO
- [ ] [1] Giáo trình Phân tích và Thiết kế hệ thống thông tin.
- [ ] [2] Tài liệu chính thức của Framework / Ngôn ngữ lập trình được sử dụng.
- [ ] [3] Các tài liệu quy chuẩn kỹ thuật và bài báo trực tuyến liên quan.

---

## 🤖 HƯỚNG DẪN DÀNH CHO AI AGENT KHI SINH NỘI DUNG (SYSTEM PROMPT HELPER)

Khi nhận lệnh sinh nội dung cho từng mục từ người dùng, hãy áp dụng nguyên tắc sau:
1. **Định dạng chuẩn:** Luôn bám sát tiêu chuẩn báo cáo học thuật: ngôn ngữ trung tính, cấu trúc đề mục rõ ràng, có phân tích giải thích thay vì chỉ liệt kê.
2. **Đảm bảo dung lượng (Target 40+ trang):**
   - Với các Use Case: Viết bảng đặc tả đầy đủ luồng sự kiện.
   - Với CSDL: Trình bày chi tiết từng trường dữ liệu, kiểu dữ liệu, khóa chính, khóa ngoại, ràng buộc.
   - Với Công nghệ: Có phân tích so sánh ưu/nhược điểm và lý do thực tế chọn công nghệ đó cho bài toán POS.
3. **Mã nguồn:** Không nhúng toàn bộ mã nguồn dài dòng vào văn bản; chỉ trích xuất các đoạn xử lý cốt lõi (Core algorithms: trừ kho transaction, tính tổng tiền hóa đơn, xác thực middleware).