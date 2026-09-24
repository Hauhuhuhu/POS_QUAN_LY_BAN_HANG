#!/usr/bin/env bash
# Script biên dịch báo cáo LaTeX trên Linux / macOS / WSL
set -e

echo "=== BẮT ĐẦU BIÊN DỊCH BÁO CÁO LATEX (UTC POS REPORT) ==="
ENGINE="xelatex"

if command -v xelatex >/dev/null 2>&1; then
    echo "1. Chạy XeLaTeX lần 1..."
    xelatex -interaction=nonstopmode main.tex
    echo "2. Chạy BibTeX..."
    bibtex main || true
    echo "3. Chạy XeLaTeX lần 2..."
    xelatex -interaction=nonstopmode main.tex
    echo "4. Chạy XeLaTeX lần 3 (hoàn thiện)..."
    xelatex -interaction=nonstopmode main.tex
    echo "=== BIÊN DỊCH HOÀN TẤT: main.pdf ==="
elif command -v docker >/dev/null 2>&1; then
    echo "Sử dụng Docker container TeX Live..."
    docker run --rm -v "$(pwd)":/workdir -w /workdir ghcr.io/xu-cheng/latex sh -c "xelatex -interaction=nonstopmode main.tex && (bibtex main || true) && xelatex -interaction=nonstopmode main.tex && xelatex -interaction=nonstopmode main.tex"
    echo "=== BIÊN DỊCH HOÀN TẤT QUA DOCKER: main.pdf ==="
else
    echo "LỖI: Chưa cài đặt XeLaTeX hoặc Docker."
    exit 1
fi
