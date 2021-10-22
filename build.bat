if exist build rd /s /q build
mkdir build
csc.exe /debug+ /out:build\HelloCS.exe src\helloCS.cs