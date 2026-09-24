# 04: Soạn thảo Chương 2 (Phần 2) - Thiết kế CSDL, Sơ đồ ERD & Data Dictionary 13 bảng

**What to build:** Hoàn thiện nửa sau của Chương 2 (`02_chapter2_analysis_design.tex`, mục tiêu ~8–10 trang) bao gồm xây dựng Sơ đồ Thực thể Liên kết (ERD) mức quan niệm và mức logic, cùng bộ Từ điển dữ liệu (Data Dictionary) chuẩn hóa, chi tiết 100% thuộc tính, kiểu dữ liệu MySQL, khóa chính, khóa ngoại, ràng buộc và diễn giải nghiệp vụ của toàn bộ 13 bảng thực tế trong cơ sở dữ liệu (`tbl_users`, `refresh_tokens`, `tbl_category`, `tbl_items`, `tbl_variants`, `tbl_modifier_groups`, `tbl_modifiers`, `tbl_item_modifier_groups`, `tbl_inventory_transactions`, `tbl_customers`, `tbl_promotions`, `tbl_orders`, `tbl_order_items`, `tbl_activity_logs`), đưa tổng dung lượng Chương 2 lên 18–20 trang.

**Blocked by:** 03: Soạn thảo Chương 2 (Phần 1) - Phân tích bài toán, 6 Use Cases & Biểu đồ UML

**Status:** closed
**Completed:** true

- [x] Soạn thảo mục 2.3 trong `report/chapters/02_chapter2_part2_database.tex` (~8 - 10 trang, 4.280+ từ, 31.300+ ký tự)
- [x] Sơ đồ Thực thể Liên kết (ERD - Hình 2.9) mức quan niệm và mức logic thể hiện đầy đủ quan hệ 1-1, 1-N, N-N giữa 13 thực thể
- [x] Từ điển dữ liệu (Data Dictionary - Bảng 2.8 đến 2.21) chi tiết 100% thuộc tính của toàn bộ 13 bảng thực tế: `tbl_users`, `refresh_tokens`, `tbl_category`, `tbl_items`, `tbl_variants`, `tbl_modifier_groups`, `tbl_modifiers`, `tbl_item_modifier_groups`, `tbl_inventory_transactions`, `tbl_customers`, `tbl_promotions`, `tbl_orders`, `tbl_order_items`, `tbl_activity_logs`
- [x] Mỗi bảng định nghĩa rõ ràng 6 cột: Tên trường, Kiểu dữ liệu MySQL, Khóa (PK/FK/Index), Not Null, Giá trị mặc định, Diễn giải ý nghĩa nghiệp vụ
- [x] Tổng số trang của Chương 2 (kết hợp cả phần 1 và phần 2) đạt 10.360+ từ, tương đương 18 - 20 trang học thuật

## Comments
- Đã hoàn tất toàn bộ Chương 2: Phân tích & Thiết kế hệ thống với độ phủ chi tiết tuyệt đối.
- Toàn bộ 13 bảng trong MySQL của dự án thực tế đã được chuẩn hóa và lập bảng từ điển dữ liệu chuẩn quy thức học thuật.
- Đã kiểm tra cú pháp LaTeX đạt 0 lỗi (clean) bằng `validate_latex.py`.
