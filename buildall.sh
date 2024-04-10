#!/bin/bash
cpus=$(nproc)
threads=$(( cpus * 2 ))
export ESP_HOME=/opt/esp-quick-toolchain
export SMING_HOME=/opt/Sming/Sming
export IDF_PATH=IDF_PATH:=/opt/esp-idf
export IDF_TOOLS_PATH=IDF_TOOLS_PATH:=/opt/esp32
cd /home/pjakobs/esp_rgbww_build/esp_build/esp_rgbww_firmware
git pull
git checkout devel
git submodule deinit Sming
rm Sming -rf
git rm Sming
git submodule init
git submodule sync
git submodule update

podman run --replace --name build_quasar -it -v /home/pjakobs/esp_rgbww_build/esp_build/:/build:z build_quasar /usr/bin/deploy
podman run --replace --name build_sming -it -v /home/pjakobs/esp_rgbww_build/esp_build/:/build:z build_sming /usr/bin/make.firmware

cd /home/pjakobs/esp_rgbww_build/esp_build/esp_rgbww_firmware
./deployOTA
