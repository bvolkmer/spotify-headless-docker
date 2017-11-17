 Info
======

This image provides the spotify on headless environments, for use with SpotifyConnect.
This is based on the archlinux base image and xvfb as virtual x server.
The spotify client is based on the archlinux aur spotify package[1]. So the version is based on this and report there if not up-to-date and the version of image and aur match.
Tested on x86-64.
**As long as I don't know about spotify redistribution rules, I won't provide a prebuild container. So you have to clone the git repository and build it on your own**


 Install
=========

 Alsa/Host Audio
-----------------
For plain use, i.e. using the hosts alsa, it is required to map `/dev/snd` to the container and run in privilege.
(`-v /dev/snd:/dev/snd --privileged`)

 First run/Login
-----------------
On first run, for login, the client must be run in actual graphic environment.
To keep it light weight, ssh with XForward is preconfigured. Follow the steps to login:
1. Run bash in container: `docker exec -it [container-name] "/bin/bash"`
2. Set root password: `passwd`
3. Generate ssh host keys: `ssh-keygen -A`
4. Start sshd: `/usr/bin/sshd -D`
5. Switch to terminal on host to get sshd port when container is created with `-P`: `docker port [container-name]`
6. Switch to terminal on machine with X server: `ssh root@[host-ip] -p[ssh-port] -X spotify`
7. Login
8. Close spotify and restart container


 Problems/Solutions
====================

 Alsa/Upmix
------------
A problem I encountered on a host system with alsa upmix (upmix plugin). It (plug:upmix51) wasn't used/known by the container, instead uses hw:0,0 as default. That is because upmixing have to happen on client/container. So you might link/copy the host `/etc/asound.conf` to the container and install alsa-plugins inside (`pacman -S alsa-plugins`).

[1]:https://aur.archlinux.org/packages/spotify/
