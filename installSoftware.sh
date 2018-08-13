#! /bin/bash

sudo add-apt-repository ppa:ricotz/docky -y && sudo add-apt-repository ppa:ubuntu-toolchain-r/test -y && sudo add-apt-repository ppa:webupd8team/sublime-text-3 -y && sudo add-apt-repository ppa:webupd8team/atom -y && sudo add-apt-repository ppa:gezakovacs/ppa -y && sudo add-apt-repository ppa:wiznote-team -y && sudo add-apt-repository ppa:inkscape.dev/stable -y && sudo add-apt-repository ppa:alessandro-strada/ppa -y


sudo apt-get update

sudo apt-get -y install gedit chromium-browser gparted htop texlive-full subversion git plank apcalc xournal steam pinta qbittorrent default-jdk gcc-4.9 nautilus-dropbox wine sublime-text-installer unetbootin python-pip numlockx vim network-manager-openvpn network-manager-openvpn-gnome thefuck evince inkscape google-drive-ocamlfuse

# _________________________________________________________________________________________
# Additional customization & software:

# https://simplenote.com/

# replace /etc/bash.bashrc
# put .bashrc to ~/

# To enable Numlock on startup
# sudo gedit /etc/mdm/Init/Default
# and put this inthere:
# if [ -x /usr/bin/numlockx ]; then
# exec /usr/bin/numlockx on
# fi

# Unicode stuff:
# place .XCompose to home