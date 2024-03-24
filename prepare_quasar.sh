BUILDROOT=/build
cd $BUILDROOT
# Set environment variables
export NODE_VERSION=18

npm install npm@latest -g 
wget -qO- https://deb.nodesource.com/setup_$NODE_VERSION.x|/bin/bash - 
apt-get install nodejs -y 
echo "nvm installed" 

export NODE_PATH=$NVM_DIR/v$NODE_VERSION/lib/node_modules
export PATH=$NVM_DIR/v$NODE_VERSION/bin:$PATH


