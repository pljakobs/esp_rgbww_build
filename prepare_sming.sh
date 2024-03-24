BUILDROOT=/build
cd /opt	
#cloning and installing current Sming version
git clone https://github.com/SmingHub/Sming.git
cd /opt/Sming
git checkout develop 

# Esp8266
export SMING_HOME=/opt/Sming/Sming

# Esp32
export IDF_PATH=${IDF_PATH:=/opt/esp-idf}
export IDF_TOOLS_PATH=${IDF_TOOLS_PATH:=/opt/esp32}

# Rp2040
export PICO_TOOLCHAIN_PATH=${PICO_TOOLCHAIN_PATH:=/opt/rp2040}

/opt/Sming/Tools/install.sh all

export SMING_HOME=/Sming
export ESP_HOME=/opt/esp-quick-toolchain
export IDF_PATH=/opt/esp-idf
export ESP32_PYTHON_PATH=/usr/bin

echo "SMING_HOME=$SMING_HOME" 
echo "ESP_HOME=$ESP_HOME"
echo "IDF_PATH=$IDF_PATH"
echo "ESP32_PYTHON_PATH=$ESP32_PYTHON_PATH"

