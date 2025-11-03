:: Script for cleaning up all auxiliary files across the repo

@echo off
setlocal

cd .\tex\.

echo Deleting LaTeX auxiliary files...

for %%x in (aux log out bcf xml blg bbl toc) do (
    echo Deleting *.%%x files
    del /s /q *.%%x >nul 2>&1
)

echo Cleanup complete.
endlocal
