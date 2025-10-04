@echo off
setlocal

:: Prompt for a commit message
set /p commitMessage="Enter a commit message: "

:: Perform Git operations
git add .
git commit -m "%commitMessage%"
git push origin master
::git push bonn master

:: echo Changes pushed to both remotes successfully.

:end
endlocal
