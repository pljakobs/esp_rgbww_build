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
	git clone git@github.com:pljakobs/esp_rgb_webapp2.git
fi
podman build -f containerfile.base -t build_base
podman build -f containerfile.quasar -t build_quasar
podman build -f containerfile.sming -t build_sming -v $BUILDDIR/:/build:z 

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
git submodule init
git submodule sync
git submodule update
make -j \$threads SMING_SOC=esp8266

podman run --replace --name build_quasar -it -v $BUILDDIR/:/build:z build_quasar /usr/bin/deploy
podman run --replace --name build_sming -it -v $BUILDDIR/:/build:z build_sming /usr/bin/make.firmware
EOF

chmod +x buildall.sh
