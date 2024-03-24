podman run --replace --name build_quasar -it -v /home/pjakobs/nginx/html/:/html:z -v /home/pjakobs/build/:/build:z build_quasar /usr/bin/deploy
podman run --replace --name build_sming -it -v /home/pjakobs/nginx/html/:/html:z -v /home/pjakobs/build/:/build:z build_sming /usr/bin/make.firmware

