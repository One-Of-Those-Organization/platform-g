all: love

clean: game.love
	rm game.love

run-fast: game/main.lua
	./love-11.5-x86_64.AppImage game

run: love
	./love-11.5-x86_64.AppImage game.love

love: game/main.lua
	cd game && zip -9 -r game.love . -x '*.git*' '*~' '*.swp'
	mv game/game.love ./

linux: love
	echo "TODO: make linux exe"

android: love
	echo "TODO: make android exe"

windows: love
	unzip love-win32.zip
	cd love-11.5-win32 && cat love.exe ../game.love > game.exe
	zip -r game-win32.zip love-11.5-win32/

web: love
	npm i --save-dev love.js
	npx love.js game.love out/web --memory 100000000

web-run: out/web/index.html
	python serve.py
