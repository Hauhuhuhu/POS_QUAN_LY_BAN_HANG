# Phần mềm Quản lý Hóa đơn (Billing Software)

Dự án này là một ứng dụng quản lý hóa đơn (Billing App) với kiến trúc Client-Server, tích hợp cổng thanh toán và quản lý cơ sở dữ liệu tự động.

## 🛠 Phần công nghệ sử dụng

Dự án áp dụng các công nghệ hiện đại và phổ biến nhất hiện nay cho cả Backend và Frontend:

### 1. Backend (Java / Spring Boot)
Nằm trong thư mục `billingsoftware`, backend được xây dựng để cung cấp các RESTful API với tính bảo mật và hiệu suất cao:
- **Ngôn ngữ:** Java 25
- **Framework chính:** Spring Boot 4.1.0
  - **Spring Web MVC:** Xây dựng API.
  - **Spring Data JPA:** Quản lý và giao tiếp với cơ sở dữ liệu (ORM).
  - **Spring Security:** Xử lý xác thực (Authentication) và phân quyền (Authorization).
- **Cơ sở dữ liệu:** MySQL (sử dụng `mysql-connector-j`).
- **Database Migration:** Flyway (`flyway-core`, `flyway-mysql`) giúp theo dõi và cập nhật cấu trúc schema CSDL tự động.
- **Bảo mật & Xác thực:** JSON Web Token (JWT) qua thư viện `jjwt`.
- **Lưu trữ Cloud:** Amazon S3 SDK (`software.amazon.awssdk:s3`) dùng để lưu trữ file/hình ảnh.
- **Cổng thanh toán:** PayOS (`vn.payos:payos-java`) để tạo và xử lý thanh toán, mã QR chuyển khoản.
- **Công cụ hỗ trợ:** Lombok (tối ưu hóa code Java, tự động tạo Getter/Setter/Constructor).

### 2. Frontend (ReactJS)
Nằm trong thư mục `Front-end`, giao diện người dùng được tối ưu hóa tốc độ và trải nghiệm:
- **Thư viện lõi:** React 19
- **Build Tool:** Vite 8 (môi trường phát triển cực nhanh).
- **Styling:** Tailwind CSS 4 (Utility-first CSS framework).
- **Data Fetching & Caching:** TanStack React Query v5.
- **Routing:** React Router DOM v7 (Quản lý các trang và điều hướng).
- **Quản lý Form:** React Hook Form (Xử lý form hiệu quả, ít re-render).
- **HTTP Client:** Axios (Gọi API đến backend).
- **Các thư viện UI/UX bổ trợ:**
  - `lucide-react`: Bộ icon hiện đại.
  - `qrcode.react`: Render mã QR động (phục vụ thanh toán PayOS).
  - `react-hot-toast`: Hiển thị thông báo (toast notifications) đẹp mắt cho người dùng.

### 3. Triển khai & Khác
- Dự án có sẵn các file `Dockerfile` cho cả Frontend và Backend để hỗ trợ container hóa (Docker).
- Cấu hình Nginx (`nginx.conf`) ở frontend cho môi trường production.