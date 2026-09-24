# 01: Thiết lập Kiến trúc LaTeX Project & Phần Mở đầu (Frontmatter)

**What to build:** Xây dựng khung kiến trúc cho toàn bộ dự án tài liệu báo cáo bằng LaTeX chuẩn XeLaTeX, cấu hình lề và font chữ Times New Roman 13pt, khoảng cách dòng 1.5, tạo script biên dịch tự động `compile.bat`, và hoàn thiện toàn bộ Phần Mở đầu (`00_frontmatter.tex`) gồm Trang bìa chính, Bìa phụ, Lời cam đoan, Lời cảm ơn, Bảng phân công nhiệm vụ 2 thành viên, cùng các danh mục tự động (Mục lục, Hình ảnh, Bảng biểu, Thuật ngữ viết tắt).

**Blocked by:** None (can start immediately)

**Status:** closed
**Completed:** true

- [x] Khởi tạo cấu trúc thư mục `report/`, `report/chapters/`, `report/images/`
- [x] File `report/main.tex` thiết lập đầy đủ cấu hình XeLaTeX: font Times New Roman 13pt, khoảng cách dòng 1.5, lề 3-2-2-2 cm, hỗ trợ Tiếng Việt
- [x] File `report/chapters/00_frontmatter.tex` bao gồm: Trang bìa chính & bìa phụ chuẩn ĐH GTVT (để trống Họ tên, MSSV), Lời cam đoan, Lời cảm ơn, Bảng phân công nhiệm vụ, Mục lục tự động, Danh mục hình ảnh, Danh mục bảng biểu, Danh mục từ viết tắt
- [x] Script `report/compile.bat` và `report/compile.sh` hỗ trợ biên dịch tự động qua XeLaTeX, BibTeX hoặc Docker
- [x] Kiểm tra cú pháp toàn bộ tài liệu bằng bộ validator LaTeX chuẩn (`validate_latex.py`), đạt 0 lỗi (clean)

## Comments
- Đã khởi tạo hoàn tất cấu trúc thư mục `report/`.
- File `report/main.tex` đã được cấu hình toàn diện với các gói lệnh: `extsizes` (13pt), `geometry` (30-20-20-20mm), `setspace` (1.5), `titlesec`, `fancyhdr`, `listings`, `booktabs`, `tabularx`, `longtable`, `hyperref`.
- File `report/chapters/00_frontmatter.tex` đã được soạn thảo đầy đủ với quy thức ĐH GTVT.
- Đã tạo file logo mẫu `report/images/logo_utc.png`, hướng dẫn `report/images/README.md` và file trích dẫn `report/references.bib`.
