FROM archlinux/base:latest

#Install deps
RUN pacman -Syu --noconfirm gettext vi tar sudo grep fakeroot file gawk which openssh xorg-xhost xorg-xauth xorg-server-xvfb

#Install spotify build deps
RUN pacman -Syu --noconfirm alsa-lib gconf gtk2 nss libxtst libxss "openssl-1.0" libcurl-compat desktop-file-utils rtmpdump

#Build/Install spotify package
COPY install.sh .
RUN /usr/bin/sh install.sh

#Copy run script
COPY spotify-headless.sh /usr/bin/spotify-headless.sh
RUN chmod a+x /usr/bin/spotify-headless.sh

#Activate ssh x forwarding and ssh root login
RUN echo "X11Forwarding yes" >> /etc/ssh/sshd_config
RUN echo "X11UseLocalhost no" >> /etc/ssh/sshd_config
RUN echo "PermitRootLogin yes" >> /etc/ssh/sshd_config

EXPOSE 22

CMD '/usr/bin/spotify-headless.sh'
