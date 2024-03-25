installRoot=$(pwd)
if [ ! -d ~/build ]
then
	mkdir ~/build
	cd ~/build
fi
if [ ! -d ~/build/esp_rgb_webapp2 ]
then 
	cd ~/build
	git clone git@github.com:pljakobs/esp_rgb_webapp2.git
fi
if [ ! -d ~/build/esp_rgbww_firmware ]
then
	git clone git@github.com:pljakobs/esp_rgbww_firmware
fi
cd $installRoot
podman build -f containerfile.base -t build_base
podman build -f containerfile.quasar -t build_quasar
podman build -f containerfile.sming -t build_sming

