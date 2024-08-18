#!/bin/bash

rm -rf ldmud
git clone https://github.com/Tamedhon/ldmud.git
cd ldmud/src
./autogen.sh
chmod +x settings/tamedhon
settings/tamedhon
make install-all
read -p "Beliebige Taste drücken..."
