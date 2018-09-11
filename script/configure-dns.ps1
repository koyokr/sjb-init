netsh interface ip set dns "로컬 영역 연결" static 1.1.1.1 primary
netsh interface ip add dns "로컬 영역 연결" 1.0.0.1
ipconfig /flushdns
