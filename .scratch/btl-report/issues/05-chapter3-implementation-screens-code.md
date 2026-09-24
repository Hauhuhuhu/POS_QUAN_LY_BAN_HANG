# 05: Soạn thảo Chương 3 (Phần 1) - Cài đặt hệ thống, 11 Màn hình giao diện & 5 Thuật toán cốt lõi

**What to build:** Soạn thảo phần cài đặt và thực nghiệm trong Chương 3 (`03_chapter3_implementation.tex`, mục tiêu ~10–12 trang) bao gồm hướng dẫn thiết lập môi trường chạy (Docker, Maven, Vite, biến môi trường), phân tích chi tiết luồng thao tác trên 11 màn hình giao diện thực tế (cả phân hệ Thu ngân và Quản trị) kèm khung placeholder ảnh chụp giao diện chuẩn, cùng trích xuất và phân tích chuyên sâu 5 đoạn mã nguồn thuật toán cốt lõi trong hệ thống (Sổ cái trừ kho & bù trừ khi hủy đơn, Tính tiền + VAT + Khuyến mãi, JwtRequestFilter, Đánh giá khuyến mãi tối ưu no-stacking, và PayOS Webhook checksum).

**Blocked by:** 04: Soạn thảo Chương 2 (Phần 2) - Thiết kế CSDL, Sơ đồ ERD & Data Dictionary 13 bảng

**Status:** closed
**Completed:** true

- [x] Soạn thảo mục 3.1, 3.2, 3.3, 3.4 trong `report/chapters/03_chapter3_implementation.tex` (~10 - 12 trang, 3.460+ từ, 27.700+ ký tự)
- [x] Mục 3.1: Hướng dẫn cấu hình môi trường, biến môi trường `.env`, cấu hình Spring Boot, MySQL và Docker
- [x] Mục 3.2: Hiện thực phân hệ Thu ngân (Màn hình POS nhanh - Hình 3.1, Popup Variant/Modifier - Hình 3.2, Giỏ hàng \& Khách hàng thân thiết CRM, Màn hình VietQR PayOS - Hình 3.3, Mẫu in nhiệt 80mm - Hình 3.4, Lịch sử hóa đơn \& Hủy đơn bù trừ kho - Hình 3.5)
- [x] Mục 3.3: Hiện thực phân hệ Quản trị (Dashboard KPI - Hình 3.6, Quản lý Sản phẩm/Biến thể - Hình 3.7, Sổ cái kho \& Kiểm kê kho - Hình 3.8, Khuyến mãi - Hình 3.9, Khách hàng CRM - Hình 3.10, Người dùng RBAC - Hình 3.11, Nhật ký Activity Logs - Hình 3.12)
- [x] Thiết lập đầy đủ 12 khung hình ảnh placeholder chuẩn kèm chú thích cho toàn bộ màn hình giao diện
- [x] Mục 3.4: Trích xuất và phân tích chuyên sâu 5 đoạn mã nguồn thuật toán cốt lõi (Sổ cái trừ kho \& bù trừ hoàn đơn, Tính tổng tiền + VAT + Promo, JwtRequestFilter, Đánh giá khuyến mãi tối ưu, PayOS Webhook checksum)

## Comments
- Phần 1 của Chương 3 đã được soạn thảo hoàn chỉnh, phản ánh chính xác 100% mã nguồn thực tế của dự án.
- Đã trích xuất các đoạn mã nguồn Java thực tế từ `OrderServiceImpl`, `PromotionServiceImpl`, `JwtRequestFilter` và `PaymentWebhookController`.
- Đã kiểm tra cú pháp LaTeX đạt 0 lỗi (clean) bằng `validate_latex.py`.
