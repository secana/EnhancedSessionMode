#!/bin/bash
# Install Hyper-V Enhanced Session Mode on Fedora 30

# Load the Hyper-V kernel module
if ! [ -f "/etc/modules-load.d/hv_sock.conf" ] || [ "$(cat /etc/modules-load.d/hv_sock.conf | grep hv_sock)" = ""  ]; then
  echo "hv_sock" | sudo tee -a /etc/modules-load.d/hv_sock.conf > /dev/null
fi

sudo dnf install -y xrdp xrdp-selinux
sudo systemctl enable xrdp
sudo systemctl start xrdp

# Configure xrdp
sudo sed -i "/^port=3389/c\port=vsock://-1:3389" /etc/xrdp/xrdp.ini
sudo sed -i "/^use_vsock=.*/c\use_vsock=false" /etc/xrdp/xrdp.ini
sudo sed -i "/^security_layer=.*/c\security_layer=rdp" /etc/xrdp/xrdp.ini
sudo sed -i "/^crypt_level=.*/c\crypt_level=none" /etc/xrdp/xrdp.ini
sudo sed -i "/^bitmap_compression=.*/c\bitmap_compression=false" /etc/xrdp/xrdp.ini
sudo sed -i "/^max_bpp=.*/c\max_bpp=24" /etc/xrdp/xrdp.ini

sudo sed -i "/^X11DisplayOffset=.*/c\X11DisplayOffset=0" /etc/xrdp/sesman.ini
if [ "$(cat /etc/X11/Xwrapper.config | grep allowed_users=anybody)" = "" ]; then
  echo "allowed_users=anybody" | sudo tee -a /etc/X11/Xwrapper.config > /dev/null
fi


