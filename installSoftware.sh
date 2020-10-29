#! /bin/bash

sudo add-apt-repository ppa:ricotz/docky -y && sudo add-apt-repository ppa:ubuntu-toolchain-r/test -y && sudo add-apt-repository ppa:webupd8team/atom -y && sudo add-apt-repository ppa:gezakovacs/ppa -y && sudo add-apt-repository ppa:wiznote-team -y && sudo add-apt-repository ppa:inkscape.dev/stable -y && sudo add-apt-repository ppa:alessandro-strada/ppa -y


sudo apt-get update

sudo apt-get -y install gedit chromium-browser gparted htop texlive-full subversion git plank apcalc xournal steam pinta qbittorrent default-jdk gcc-4.9 nautilus-dropbox wine python-pip vim network-manager-openvpn network-manager-openvpn-gnome thefuck evince inkscape google-drive-ocamlfuse

# _________________________________________________________________________________________
# Additional customization & software:

# replace /etc/bash.bashrc
# put .bashrc to ~/.

# Unicode stuff:
# place .XCompose and .xprofile to home
