MISSION_NAME=TheLongestDayKexed
MAP_NAME=Altis
PROJECT_NAME="$(MISSION_NAME).$(MAP_NAME)"
STEAM_WORKSHOP_NAME="$(MISSION_NAME)_SW.$(MAP_NAME)"

.PHONY : all

all:
	mkdir -p release
	armake build -f -p -z \
		-x 'tools/*' -x '.git*' -x '.vscode/*' -x '*.bak' -x makefile \
		. release/$(PROJECT_NAME).pbo
	rm -rf ../$(STEAM_WORKSHOP_NAME)
	armake unpack release/$(PROJECT_NAME).pbo ../$(STEAM_WORKSHOP_NAME)

clean:
	rm -f release/$(PROJECT_NAME).pbo
	rm -rf ../$(STEAM_WORKSHOP_NAME)
