all: love

clean: game.love
	rm game.love

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
	echo "TODO: make windows exe"

web: love
	npm i --save-dev love.js
	npx love.js game.love out/web --memory 100000000

web-run: out/web/index.html
	python serve.py
