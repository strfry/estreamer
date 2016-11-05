# Raspbian specific auto-start
systemctl set-default multi-user.target
ln -sf /etc/systemd/system/autologin@.service /etc/systemd/system/getty.target.wants/getty@tty1.service

# Replace pi with ewindow user

useradd -G video -s /home/ewindow/ewindow.sh ewindow
sudo git clone https://github.com/strfry/estreamer /home/ewindow
sudo chown -R ewindow:ewindow /home/ewindow/


# sudo apt-get install stuff
# dialog (or use whiptail??)
# daemontools

# echo ip tuntap add dev peervpn0 mode tap user ewindow >> /etc/rc.local
# echo ip addr add IP dev peervpn0 >> /etc/rc.local ???
