installRoot=$(pwd)
if [ "$1"=="" ]
then
	BUILDDIR=$installRoot/esp_build
else
	BUILDDIR=$1
fi

if [ ! -d $BUILDDIR ]
then
	mkdir -p $BUILDDIR
	cd $BUILDDIR
fi
if [ ! -d $BUILDDIR/esp_rgb_webapp2 ]
then 
	cd $BUILDDIR
	#git clone git@github.com:pljakobs/esp_rgb_webapp2.git
	git clone https://github.com/pljakobs/esp_rgb_webapp2.git
fi
if [ ! -d $BUILDDIR/esp_rgbww_firmware ]
then
	cd $BUILDDIR
	#git clone git@github.com:pljakobs/esp_rgbww_firmware.git
	git clone https://github.com/pljakobs/esp_rgbww_firmware.git
	cd $BUILDDIR/esp_rgbww_firmware
	git submodule deinit Sming
	rm Sming -rf
	git rm Sming
	git stash
	if [ ! -d spiffs ]
	then
		mkdir spiffs
	fi
	cd $installRoot
fi
cd $installRoot
podman build -f containerfile.base -t build_base
podman build -f containerfile.quasar -t build_quasar
podman build -f containerfile.sming -t build_sming 

cat <<EOF >buildall.sh
#!/bin/bash
cpus=\$(nproc)
threads=\$(( cpus * 2 ))
export ESP_HOME=/opt/esp-quick-toolchain
export SMING_HOME=/opt/Sming/Sming
export IDF_PATH=IDF_PATH:=/opt/esp-idf
export IDF_TOOLS_PATH=IDF_TOOLS_PATH:=/opt/esp32
cd $BUILDDIR/esp_rgbww_firmware
git pull
git checkout devel
git submodule deinit Sming
rm Sming -rf
git rm Sming
git submodule init
git submodule sync
git submodule update

podman run --replace --name build_quasar -it -v $BUILDDIR/:/build:z build_quasar /usr/bin/deploy
podman run --replace --name build_sming -it -v $BUILDDIR/:/build:z build_sming /usr/bin/make.firmware
EOF

chmod +x buildall.sh
