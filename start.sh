#!/bin/bash

# Finish Function runs when the Container is being Stopped.
function finish {
  echo "####################################"
  echo "  CAUGHT A SIGNAL: stopping quagga"
  echo "####################################"
  /usr/lib/quagga/quagga stop
  exit 0
}

trap finish HUP INT QUIT TERM

echo "##############################"
echo "Generating OSPF Config From Python"
echo "##############################"
/usr/bin/python3 /usr/lib/quagga/start.py

echo "##############################"
echo "  Applying Sysctl Values"
echo "##############################"
/sbin/sysctl -p -w /etc/sysctl.d/99cumulus_defaults.conf

echo "##############################"
echo "  Starting Quagga..."
echo "##############################"
/usr/lib/quagga/quagga start

# Waiting Forever or Until Someone Presses Enter to Stop the Container
echo "[hit enter key to exit] or run 'docker stop <container>'"
read

echo "##############################"
echo "  Stopping Quagga..."
echo "##############################"
/usr/lib/quagga/quagga stop

echo "Done."
echo "exited $0"
