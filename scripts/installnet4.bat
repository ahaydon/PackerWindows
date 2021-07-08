powershell -NoProfile -ExecutionPolicy unrestricted -Command "(New-Object System.Net.WebClient).DownloadFile('https://download.visualstudio.microsoft.com/download/pr/2d6bb6b2-226a-4baa-bdec-798822606ff1/8494001c276a4b96804cde7829c04d7f/ndp48-x86-x64-allos-enu.exe', 'C:\Windows\Temp\ndp48-x86-x64-allos-enu.exe')" <NUL
C:\Windows\Temp\ndp48-x86-x64-allos-enu.exe /q /norestart
echo "completed with exit code %errorlevel%"
exit /b %errorlevel%
