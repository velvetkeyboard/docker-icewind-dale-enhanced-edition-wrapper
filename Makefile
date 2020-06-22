company=gog
game=icewind_dale
docker_img=$(company)/$(game):ed-2.5.17
guest_path='/home/player/GOG Games/Icewind Dale Enhanced Edition/'
host_path=$$PWD'/Icewind Dale Enhanced Edition/'
guest_save_path='/home/player/.local/share/Icewind Dale - Enhanced Edition/save/'
host_save_path=$$PWD'/saves/'
run=bash '/home/player/GOG Games/Icewind Dale Enhanced Edition/start.sh'

build:
	docker build . -t $(docker_img) 

run:
	docker run \
		--rm \
		-ti \
		-e DISPLAY=$$DISPLAY \
		-v /tmp/.X11-unix:/tmp/.X11-unix \
		-v $(host_path):$(guest_path):Z \
		-v $(host_save_path):$(guest_save_path):Z \
		$(docker_img) $(run)

#-v $$PWD/Game/:'/home/player/GOG Games':Z \
