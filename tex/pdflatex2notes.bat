
@echo off
setlocal



:: Prompt for a commit message
set /p filename="Enter file name: "
set /p CommitName="Enter Commit name: "
:: Clean all old aux files first

for %%x in (aux log out bcf xml blg bbl toc) do (
    ::echo Deleting *.%%x files
    del /s /q *.%%x >nul 2>&1
)

echo initial precompilation
:: Generate files
pdflatex main >nul 2>&1

echo running biber
biber main >nul 2>&1

echo re-compilation 1
pdflatex main >nul 2>&1

echo re-compilation 2 
pdflatex main >nul 2>&1

:: Copy PDF to notes
copy /Y main.pdf  ..\notes\%filename%.pdf

:: Perform Git operations
cd ..
git add .
git commit -m "[Update %filename%.pdf] %CommitName%"
git push 


::echo Changes pushed to both remotes successfully.

::cd tex
:end
endlocal
