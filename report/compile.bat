@echo off
chcp 65001 > nul
echo ==============================================================================
echo   HE THONG BIEN DICH BAO CAO LATEX - UTC POS BILLING SOFTWARE
echo ==============================================================================
echo.

where xelatex >nul 2>nul
if %ERRORLEVEL% EQU 0 (
    echo [THONG TIN] Phat hien trinh bien dich XeLaTeX trong he thong.
    echo [BUOC 1/4] Chay XeLaTeX lan 1...
    xelatex -interaction=nonstopmode main.tex
    
    echo [BUOC 2/4] Xu ly danh muc Tai lieu tham khao (BibTeX)...
    bibtex main
    
    echo [BUOC 3/4] Chay XeLaTeX lan 2 de cap nhat danh muc va trich dan...
    xelatex -interaction=nonstopmode main.tex
    
    echo [BUOC 4/4] Chay XeLaTeX lan 3 de dong bo toan dien muc luc va so trang...
    xelatex -interaction=nonstopmode main.tex
    
    if exist main.pdf (
        echo.
        echo ==============================================================================
        echo   BIEN DICH THANH CONG! File ket qua: report\main.pdf
        echo ==============================================================================
    ) else (
        echo.
        echo [LOI] Khong tao duoc file main.pdf. Vui long kiem tra log file main.log
    )
    goto end
)

where docker >nul 2>nul
if %ERRORLEVEL% EQU 0 (
    echo [THONG TIN] Khong tim thay xelatex local, nhung tim thay Docker.
    echo Dang khoi chay bien dich qua TeX Live Docker container...
    docker run --rm -v "%cd%":/workdir -w /workdir ghcr.io/xu-cheng/latex sh -c "xelatex -interaction=nonstopmode main.tex && (bibtex main || true) && xelatex -interaction=nonstopmode main.tex && xelatex -interaction=nonstopmode main.tex"
    if exist main.pdf (
        echo [THANH CONG] File bao cao PDF da duoc tao: report\main.pdf
        goto end
    )
)

echo [CANH BAO] May cua ban chua cai dat cong cu XeLaTeX / MiKTeX / TeX Live.
echo Ban co the bien dich theo mot trong cac cach sau:
echo   1. Cai dat MiKTeX (https://miktex.org) hoac TeX Live tren Windows.
echo   2. Mo thu muc 'report' bang VS Code va cai extension "LaTeX Workshop".
echo   3. Nen thu muc 'report' thanh file zip va upload len https://overleaf.com de bien dich truc tuyen.
echo.

:end
pause
