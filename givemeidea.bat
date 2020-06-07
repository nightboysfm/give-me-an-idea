@echo off
setlocal

:: Create numbered list of files in a temporary file
set "tempFile=%temp%\%~nx0_fileList_%time::=.%.txt"
dir /b /s /a-d %1 | findstr /n "^" >"%tempFile%"

:: Count the files
for /f %%N in ('type "%tempFile%" ^| find /c /v ""') do set cnt=%%N

:: Open 999 random files
for /l %%N in (1 1 999) do (
  call :openRandomFile
)

:: Delete the temp file
del "%tempFile%"
exit /b

:openRandomFile
set /a "randomNum=(%random% %% cnt) + 1"
for /f "tokens=1* delims=:" %%A in (
  'findstr "^%randomNum%:" "%tempFile%"'
) do (
  start https://www.pornhub.com/random
  start "" "%%B"
  REM start /WAIT "C:\Program Files\WindowsApps\Microsoft.Windows.Photos_2020.19111.24110.0_x64__8wekyb3d8bbwe\Microsoft.Photos.exe" "%%B"
  pause
)
exit /b

REM Sources :
REM https://fr.pornhub.com/blog/1531
REM https://superuser.com/a/872137
REM https://stackoverflow.com/questions/2252979/windows-batch-call-more-than-one-command-in-a-for-loop