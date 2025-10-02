all: love

clean: game.love
	rm game.love

run-fast: game/main.lua
	./extern/love-11.5-x86_64.AppImage game

run: love
	./extern/love-11.5-x86_64.AppImage game.love

love: game/main.lua
	cd game && zip -9 -r game.love . -x '*.git*' '*~' '*.swp'
	mv game/game.love ./

linux: love
	mkdir -p out/linux
	echo -e "#!/usr/bin/env sh\n./love.appimage game.love" > out/linux/run.sh
	chmod +x out/linux/run.sh
	cp extern/love-11.5-x86_64.AppImage ./out/linux/love.appimage
	cp game.love ./out/linux/game.love

android: love
	echo "TODO: make android exe"

windows: love
	mkdir -p out/win32 out/win32/dist
	unzip extern/love-win32.zip
	cd love-11.5-win32 && cat love.exe ../game.love > game.exe
	mv love-11.5-win32 out/win32/game
	zip -r out/win32/dist/game-win32.zip out/win32/game

web: love
	npm i --save-dev love.js
	npx love.js game.love out/web --memory 100000000

web-run: out/web/index.html
	python serve.py
