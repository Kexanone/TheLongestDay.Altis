PROJECT_NAME=TheLongestDayKexed.Altis

build: release/$(PROJECT_NAME).pbo

release/$(PROJECT_NAME).pbo:
	mkdir -p release
	armake build -f -p -z \
		-x 'tools/*' -x '.git*' -x '.vscode/*' -x '*.bak' -x makefile \
		. release/$(PROJECT_NAME).pbo

clean:
	rm release/$(PROJECT_NAME).pbo
