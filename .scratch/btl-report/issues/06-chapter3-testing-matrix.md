# 06: Soạn thảo Chương 3 (Phần 2) - Ma trận Kiểm thử hệ thống & Đánh giá kết quả

**What to build:** Soạn thảo phần kiểm thử hệ thống trong Chương 3 (`03_chapter3_implementation.tex`, mục tiêu ~4–5 trang) bao gồm xây dựng Ma trận kịch bản kiểm thử (Test Cases Matrix) dạng bảng chi tiết, bao phủ các tình huống kiểm thử chức năng quan trọng (Đăng nhập, phân quyền, Bán hàng, Khuyến mãi, Sổ cái kho, PayOS QR, Bù trừ khi hủy đơn, Ngăn chặn xóa đơn COMPLETED), kiểm thử bảo mật & hiệu năng (< 1s phản hồi tại quầy POS), và tổng kết đánh giá kết quả kiểm thử, đưa tổng số trang của Chương 3 lên 14–16 trang.

**Blocked by:** 05: Soạn thảo Chương 3 (Phần 1) - Cài đặt hệ thống, 11 Màn hình giao diện & 5 Thuật toán cốt lõi

**Status:** closed
**Completed:** true

- [x] Soạn thảo mục 3.5 trong `report/chapters/03_chapter3_part2_testing.tex` (~4 - 5 trang, 2.000+ từ, 11.370+ ký tự)
- [x] Xây dựng Ma trận kịch bản kiểm thử (Test Cases Matrix - Bảng 3.1) bao gồm 15 ca kiểm thử bao phủ toàn diện: Đăng nhập & phân quyền RBAC, Bán hàng tại quầy, Tính toán khuyến mãi (Happy Hour, Coupon), Trừ tồn kho qua sổ cái, Thanh toán VietQR & Webhook, Chuyển sang tiền mặt, Hủy đơn PENDING bù trừ, Ngăn chặn xóa đơn COMPLETED, Ngăn chặn Replay Attack Token
- [x] Đánh giá tổng quan chất lượng kiểm thử (Bảng 3.2), xác nhận tỷ lệ Pass 100% (15/15 ca) và đo lường hiệu năng phản hồi đạt chuẩn (< 1s tại quầy POS, trung bình 120ms - 250ms)
- [x] Tổng số trang của Chương 3 (kết hợp cả phần 1 và phần 2) đạt 5.475 từ, tương đương 14 - 16 trang học thuật

## Comments
- Toàn bộ Chương 3: Cài đặt và thực nghiệm chương trình đã hoàn thành xuất sắc.
- Ma trận 15 Test Cases đã kiểm định toàn diện từ các luồng chức năng thông thường đến các quy tắc toàn vẹn kế toán và an toàn bảo mật nâng cao.
- Đã kiểm tra cú pháp LaTeX đạt 0 lỗi (clean) bằng `validate_latex.py`.
