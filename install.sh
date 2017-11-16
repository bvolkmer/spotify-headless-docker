TMP_DIR=/tmp/spotify-install
AUR_NAME=spotify
AUR_VERSION="1.0.66.478-1"

#Create tmp
rm -rf $TMP_DIR
mkdir -p $TMP_DIR
cd $TMP_DIR

#Add user for build (makepkg don't like root)
useradd build

#Build and install spotify package
curl https://aur.archlinux.org/cgit/aur.git/snapshot/$AUR_NAME.tar.gz --output $AUR_NAME.tar.gz
tar xzf $AUR_NAME.tar.gz
cd $AUR_NAME
chown build .
sudo -u build makepkg

#Install
pacman -U --noconfirm "${AUR_NAME}-${AUR_VERSION}-x86_64.pkg.tar.xz"

#Cleanup
cd
rm -rf $TMP_DIR
userdel build
