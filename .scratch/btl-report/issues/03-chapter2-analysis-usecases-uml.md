# 03: Soạn thảo Chương 2 (Phần 1) - Phân tích bài toán, 6 Use Cases & Biểu đồ UML

**What to build:** Biên soạn phần đầu của Chương 2 (`02_chapter2_analysis_design.tex`, mục tiêu ~10 trang) bao gồm khảo sát nghiệp vụ thực tế, xác định các yêu cầu chức năng và phi chức năng, xây dựng Biểu đồ phân rã chức năng (BFD), mô hình Use Case tổng quát và bảng đặc tả chi tiết cho 6 Use Cases cốt lõi của hệ thống (Đăng nhập xoay vòng Token, Bán hàng POS tại quầy, Đánh giá khuyến mãi tối ưu, Thanh toán trực tuyến VietQR PayOS, Quản lý biến thể & Sổ cái kho, Tra cứu lịch sử kiểm toán Activity Logs) kèm các sơ đồ UML chuẩn (Activity, Sequence, Class, Deployment).

**Blocked by:** 01: Thiết lập Kiến trúc LaTeX Project & Phần Mở đầu (Frontmatter)

**Status:** closed
**Completed:** true

- [x] Soạn thảo phần 2.1 và 2.2 trong `report/chapters/02_chapter2_analysis_design.tex` (~10 trang, 6.000+ từ, 41.900+ ký tự)
- [x] Mục 2.1: Khảo sát nghiệp vụ, mục đích, phạm vi, đối tượng sử dụng, đặc tả yêu cầu chức năng (Bảng 2.1) và phi chức năng (< 1s tại quầy, tính toàn vẹn tài chính & bù trừ ADR-0006)
- [x] Mục 2.2: Biểu đồ phân rã chức năng (BFD - Hình 2.1) 4 phân hệ chính
- [x] Biểu đồ Use Case tổng quát (Hình 2.2) và theo từng tác nhân (Admin, Thu ngân, Cổng PayOS)
- [x] 6 bảng đặc tả Use Case chi tiết chuẩn học thuật (Bảng 2.2 đến 2.7): Đăng nhập & phiên bảo mật, Bán hàng POS tại quầy, Đánh giá khuyến mãi tối ưu, Thanh toán VietQR PayOS & chuyển sang tiền mặt, Quản lý biến thể & kiểm kê kho sổ cái, Tra cứu nhật ký Activity Logs
- [x] Biểu đồ Hoạt động (Activity Diagrams - Hình 2.3 & 2.4) cho luồng thanh toán POS và luồng kiểm kê kho
- [x] Biểu đồ Tuần tự (Sequence Diagrams - Hình 2.5 & 2.6) cho luồng xác thực xoay vòng token và luồng tạo đơn trừ kho tức thì
- [x] Biểu đồ Lớp (Class Diagram - Hình 2.7) và Biểu đồ Triển khai (Deployment Diagram - Hình 2.8)

## Comments
- Phần 2.1 và 2.2 của Chương 2 đã hoàn thành xuất sắc với chiều sâu học thuật vượt trội.
- 6 Use Cases được đặc tả đầy đủ bảng chuẩn: Tiền điều kiện, Luồng sự kiện chính từng bước, Luồng ngoại lệ chi tiết, Hậu điều kiện.
- Đã kiểm tra cú pháp LaTeX đạt 0 lỗi (clean) bằng `validate_latex.py`.
