#!/bin/bash
# Install Hyper-V Enhanced Session Mode on Fedora 36

# Load the Hyper-V kernel module
if ! [ -f "/etc/modules-load.d/hv_sock.conf" ] || [ "$(cat /etc/modules-load.d/hv_sock.conf | grep hv_sock)" = ""  ]; then
  echo "hv_sock" | sudo tee -a /etc/modules-load.d/hv_sock.conf > /dev/null
fi

# Install XRDP server
sudo dnf install -y xrdp xrdp-selinux

sudo firewall-cmd --permanent --add-port=3389/tcp
sudo firewall-cmd --reload

sudo chcon --type=bin_t /usr/sbin/xrdp 
sudo chcon --type=bin_t /usr/sbin/xrdp-sesman 

sudo systemctl enable xrdp
sudo systemctl start xrdp

# Configure xrdp
sudo sed -i "/^port=3389/c\port=vsock://-1:3389" /etc/xrdp/xrdp.ini
sudo sed -i "/^use_vsock=.*/c\use_vsock=false" /etc/xrdp/xrdp.ini
sudo sed -i "/^security_layer=.*/c\security_layer=rdp" /etc/xrdp/xrdp.ini
sudo sed -i "/^crypt_level=.*/c\crypt_level=none" /etc/xrdp/xrdp.ini
sudo sed -i "/^bitmap_compression=.*/c\bitmap_compression=false" /etc/xrdp/xrdp.ini
sudo sed -i "/^max_bpp=.*/c\max_bpp=24" /etc/xrdp/xrdp.ini

echo "¡Make sure you reboot your system after running this script!"
