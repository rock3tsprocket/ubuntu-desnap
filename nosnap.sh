#!/bin/sh

# this removes snapd and packages installed by it
sudo apt autoremove --purge snapd
# that makes it not install when ubuntu updates
sudo apt-mark hold snapd
# this asks the user for if they want firefox
echo "If you want Firefox, wait 7 seconds. Otherwise, press Ctrl+C within that 7 seconds."
sleep 7s
echo Installing Firefox;
sudo add-apt-repository ppa:mozillateam/ppa;
echo '
Package: *
Pin: release o=LP-PPA-mozillateam
Pin-Priority: 1001

Package: firefox
Pin: version 1:1snap*
Pin-Priority: -1
' | sudo tee /etc/apt/preferences.d/mozilla-firefox;
sudo apt install firefox;
echo 'Unattended-Upgrade::Allowed-Origins:: "LP-PPA-mozillateam:${distro_codename}";' | sudo tee /etc/apt/apt.conf.d/51unattended-upgrades-firefox;
exit;

