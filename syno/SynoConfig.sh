#!/bin/sh
/usr/syno/bin/synopkg install_from_server py3k
/usr/syno/bin/synopkg install_from_server Docker #(sometimes need to manually install)

cd ~
curl -k https://bootstrap.pypa.io/get-pip.py | python3
echo -e '\nexport PATH="~/.local/bin:/var/packages/py3k/target/usr/local/bin:$PATH"' | tee -a ~/.profile
. .profile
pip install ansible requests
pip3 install ansible requests