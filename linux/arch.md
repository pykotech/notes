
Arch Linux Notes
================

I. Installation
---------------

###Package selection

    base, base-devel, wireless-tools, sudo, links, dbus-core, openssh,
    iwl3945 (laptop wireless)

###See also

[https://wiki.archlinux.org/index.php/Beginners'_Guide](Beginner's Guide)
[https://wiki.archlinux.org/index.php/General_Recommendations](General Recommendations)


Post Installation
-----------------

###Enable networking

**Connect to network (static ip, netcfg)**

check available interfaces

    ip addr
    ip link

configure netcfg

    cp /etc/network.d/examples/ethernet-static /etc/network.d/BLA

vim /etc/network.d/BLA

    CONNECTION='ethernet'
    DESCRIPTION='whatever'
    INTERFACE='enp0s25'
    IP='static'
    ADDR='xxx'
    GATEWAY='yyy'
    DNS=('zzz')

connect once

    ip link set enp0s25 up
    netcfg -u BLA
    ping -c 3 www.google.com

auto connect

    sudo pacman -S ifplugd
    sudo systemctl enable net-auto-wired.service
    sudo systemctl enable netcfg@BLA

**Connect to network (static ip, old way)**

    ifconfig eth0 xxx
    netmask 255.255.255.0
    broadcast xx.255
    add default gw yyy

**Connect to network (old way, wireless)**

    ifconfig wlan0 up

*WEP*

    iwconfig wlan0 essid <ssid> <hexkey>
    dhcpcd wlan0

*WPA With password*

    wpa_passphrase <SSID> "password" > /etc/wpa_supplicant.conf
    wpa_supplicant -B -Dwext -iwlan0 -c/etc/wpa_supplicant.conf
    dhcpcd wlan0

**Disable eth0**

comment out section in
sudo vim /etc/rc.conf

**Install GUI tool to automatically connect**

 pacman -S network-manager-applet (gnome)

Follow config steps from [https://wiki.archlinux.org/index.php/NetworkManager](the)
[https://wiki.archlinux.org/index.php/Configuring_Network](wiki).


###Update system

    pacman -Syu
    pacman -S curl vim bash-completion dbus

    vim /etc/pacman.d/mirrorlist #Enable all U.S. mirrors except VT

    cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
    rankmirrors -n 6 /etc/pacman.d/mirrorlist.backup > /etc/pacman.d/mirrorlist
    pacman -Syu

NOTE: Not all mirrors are up to date! See [https://wiki.archlinux.org/index.php/Beginners%27_Guide#.2Fetc.2Fpacman.d.2Fmirrorlists](the wiki)
for suggestionon using rankmirror and a website to check a mirror's freshness.

###Add new user

**useradd**

    useradd -m -g users -G wheel -s /bin/bash username
    passwd username

**adduser**

    adduser username
    visudo

**sudo privileges**

    pacman -S visudo
    visudo
    %wheel ALL=(ALL) ALL

Groups to add user to: sys disk lp scanner audio video locate network power 
storage.

See: [https://wiki.archlinux.org/index.php/Users_and_Groups](Users and Groups)

###Xorg & Graphics drivers

**Install X**

    pacman -S xorg-server xorg-xinit xorg-server-utils xorg-xauth

For laptops, also install

    pacman -S xf86-input-synaptics

**ATI**

    pacman -S xf86-video-ati

**NVIDIA**

    pacman -S nvidia nvidia-utils pkgconfig

**Intel**

    xf86-video-intel libva-driver-intel
    (add 'Option "AccelMethod" "xna"' to xorg.conf)

###Gnome

    pacman -S gnome gnome-extra gnome-system-tools gksu

###GDM 

    sudo pacman -S gdm
    sudo systemctl enable gdm.service

###Printer support

**CUPS**

    sudo pacman -S cups cups-pdf hplip
    sudo usermod -a -G sys,lp,scanner <username>

**GUI configuration**

    printer management
    hp management

    # add cupsd to /etc/rc.conf daemons

    # run hp gui
    Is user added to "sys" group(s)

###ZSH

    sudo pacman -S zsh

    curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
    ~/Dropbox/dotfiles/setup.sh

###Fonts

    mkdir ~/.fonts
    mkdir ~/.local/share/applications
    cp ~/Dropbox/linux/fonts/* ~/.fonts
    cp ~/Dropbox/linux/.local/share/*.desktop ~/.local/share/applications
    fc-cache -fv

    yaourt ttf-ms-fonts ttf-ms-fonts-zh ttf-ubuntu-font-family droid-sans

###Lolcat

    sudo pacman -S ruby
    gem install lolcat
    mkdir ~/bin
    ln -s ~/.gem/ruby/1.9.1/bin/lolcat ~/bin/lolcat

###Autojump

    sudo pacman -S autojump
    wget https://raw.github.com/joelthelion/autojump/master/bin/autojump.zsh
    sudo cp autojump.zsh /etc/profile.d

###AUR support

**Install yaourt**

    sudo pacman -S wget
    wget https://aur.archlinux.org/packages/ya/yaourt/PKGBUILD
    makepkg -s
    sudo pacman -U yaourt-1.2.2-1-any.pkg.tar.xz 

**Powerpill**

    pacman -S powerpill

    # Edit  /etc/yaourtrc and add
    PacmanBin=/usr/bin/powerpill

###Everything else

    pacman -S bash-completion ttf-bitstream-vera terminator leafpad vim \
              dnsutils mlocate dosfstools mtools  chromium flashplugin \
              jre7-openjdk jdk7-openjdk icedtea-web-java7 alsa-utils  \
              figlet pkgfile p7zip openssh

    pacman -S dnsutils mlocate dosfstools mtools flashplugin jre7-openjdk \
              icedtea-web-java7 figlet pkgfile p7zip openssh libvdpau
              python2-keybinder2 gstreamer0.10-ugly-plugins pithos
              gst-libav totem-plugin gecko-mediaplayer gst-plugins-base
              gst-plugins-good gst-plugins-bad gst-plugins-ugly 

    pacman -S libreoffice-writer libreoffice-calc libreoffice-impress \
              libreoffice-draw libreoffice-en-US

    pacman -S thunderbird evince brasero gnuplot

    pacman -S bzr git subversion meld

    pacman -S python-pip python-virtualenv ipython wxpython

    pacman -S pidgin pidgin-libnotify

    yaourt dropbox revelation redshift ttf-ms-fonts ttf-ms-fonts-zh_cn toilet \
           esound libpng12 sunpy xcursor-human-aero archey alsi scrot 
           vim-pkgbuild

Set evince as default PDF viewer

    xdg-mime default evince.desktop application/pdf

###Suspend/hibernate

https://wiki.archlinux.org/index.php/Pm-utils
http://arcierisinasce.wordpress.com/2011/11/12/suspend-on-lid-close/

    sudo pacman -S acpi acpid pm-utils

    add acpid to daemons in rc.conf
    enable regular user access (visudo)    

    sudo gpasswd -a <user> power

###SSHD

    # /etc/ssh/sshd_config
    PasswordAuthentication no
    ChallengeResponseAuthentication no

###URxvt

    sudo pacman -S rxvt-unicode

###Dropbox

    yaourt dropbox nautilus-dropbox

###Prettier X Cursors

    yaourt xcursor-human-aero

    # Edit ~/.Xdefaults
    Xcursor.theme: XcursorHuman

    # To support Firefox, etc
    sudo mkdir -p /usr/share/icons/default/
    sudo vim /usr/share/icons/default/index.theme

    [icon theme] 
    Inherits=XcursorHuman

    (https://wiki.archlinux.org/index.php/X11_Cursors)

###R

    sudo pacman -S r gcc-gfortran tcl tk
    yaourt rstudio

###Synthesia

    1. Install synthesia via playonlinux
    2. Install timidity++ and soundfont-fluid (AUR)
    3. Edit /etc/timidity++/timidity.cfg and add:
        soundfont "/usr/share/soundfonts/FluidR3 GM2-2.sf2"
    4. Start timidity with:
        timidity -A100 -iA -B2,8 -Os -EFreverb=0

###Conky

    sudo pacman -S conky ttf-liberation
    yaourt -S conkyforecast ttf-ubuntu-font-family

    # 1) Copy .conkyrc and .conkyForecast.config to ~
    # 2) Copy fonts to ~/.fonts

    mkdir ~/.fonts
    cp ~/Dropbox/linux/.fonts/* ~/.fonts
    cp ~/Dropbox/linux/.conkyForecast.config ~/
    fc-cache -fv

###Java

    pacman -S jre jdk

    # current .bashrc sets JAVA_HOME to /usr/lib/jvm/java-6-sun
    sudo mkdir /usr/lib/jvm
    sudo ln -s /opt/java/jre/ /usr/lib/jvm/java-6-sun

    # Edit /etc/profile or .bashrc and add to $PATH:
    /opt/java/jre/bin/

    # Fix font rendering (add to .bashrc)
    export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'

###LAMP

    pacman -S apache php php-apache mysql

    # Add daemons
    DAEMONS=(...httpd mysqld...)

    # MySQL
    sudo /etc/rc.d/mysqld start
    sudo /usr/bin/mysql_secure_installation

    # PHP
    Edit /etc/httpd/conf/httpd.conf and place this in the "LoadModule" list anywhere after LoadModule dir_module modules/mod_dir.so: 
        LoadModule php5_module modules/libphp5.so

    Place this at the end of the "Include" list: 
        Include conf/extra/php5_module.conf

    (https://wiki.archlinux.org/index.php/LAMP)

###UFW

    # Install
    sudo pacman -S ufw
    yaourt gufw
    sudo systemctl enable ufw
    sudo systemctl start ufw

    # Allow SSH access for IP range
    whois 216.15.29.2
    sudo ufw allow proto tcp from 216.15.0.0/17 to any port 22
    sudo ufw delete allow ssh

###Redshift

    yaourt redshift

    # Add to startup
    redshift -l xx.xx:-yy.yy

###Chinese support

ibus-qt is needed to input into goldendict

    sudo pacman -S ibus-pinyin ibus-qt goldendict
    sudo pacman -S wqy-zenhei wqy-bitmapfont

###Python

**Python 2**

    sudo pacman -S python2 ipython2 python2-numpy python2-matplotlib \
    python2-scipy python2-sphinx python2-virtualenv

    sudo pip2 install pyfits pytest pylint tox numpydoc paver

**Python 3**

    sudo pacman -S python ipython python-numpy python-scipy python-sphinx \
    python-qt python-virtualenv python-dateutil python-pytz python-pyparsing \
    pygtk tk

    sudo pip install pyfits  pytest tox numpydoc

###Mount Windows partition

    sudo pacman -S ntfs-3g
    sudo vim /etc/fstab
    /dev/<NTFS-part>  /mnt/windows  ntfs-3g   defaults          0       0

    (https://wiki.archlinux.org/index.php/NTFS-3G)

###Better fonts

    yaourt freetype2-infinality

Other
-----

###Pacman

**Basic commands**

    pacman -Syu                            // update system
    pacman -S <package>                    // install a package
    pacman -R <package>                    // remove a package
    pacman -Rns <package>                  // remove a package, uneeded dependencies, and config files
    pacman -Ss <package>                   // search for package
    pacman -Si <package>                   // get package details
    pacman -Sii <package>                  // same as above but includes 'required by'
    pacman -Ql <package>                   // get list of files installed for package
    pacman -Sp --print-format %n <package> // apt-get build-dep
    pacman -Qdtq | pacman -Rs -            // apt-get autoremove
    pacman -Scc                            // apt-get autoclean
    pacman -Sc                             // clean up cache
    pacman -Qm                             // list AUR installed packages

**list regular installed packages**

    comm -23 <(pacman -Qeq|sort) <(pacman -Qmq|sort) > packages.txt

    https://wiki.archlinux.org/index.php/Pacman_Rosetta
    https://bbs.archlinux.org/viewtopic.php?pid=878329

**apt-file like tools**

    sudo pacman -S pkgfile
    sudo pkgfile -u
    pkgfile -s <filename>

###LAMP issues

1) Symbolic link not allowed or link target not accessible: /srv/http/vso (where vso points to /home/hughitt1/Dropbox/vso)

    First, make sure that "FollowSymLinks" is enabled for / in /etc/httpd/conf/httpd.conf

    PROBLEM: Apache user (http) must be able to change directories to the linked dir... this means they must
    be able to change to /home, /home/hughitt1, etc.

    /home/ is owned by root:root, but has global execute priveleges,
    /home/hughitt is owned by hughitt1:users, but does NOT have global execute privileges, so

        usermod -a -G users http  // adds apache to 'users' group
        chmod g+x /home/keith
        chmod g+x /home/keith/Dropbox
        chmod -R g+x /home/keith/Dropbox/vso
        sudo rc.d restart httpd

    (https://bbs.archlinux.org/viewtopic.php?id=42413)

2) When attempting to login as "http" for testing you are forced
   to change the password: "You are required to change your password immediately (root enforced)"

   UNSOLVED

   (http://www.puschitz.com/SecuringLinux.shtml)
   (https://bbs.archlinux.org/viewtopic.php?pid=247076)

###Change default browser

    Edit ~/.local/share/applications/mimeapps.list:
        [Added Associations]
        x-scheme-handler/http=chromium.desktop

###Installing OpenJPEG

    * Remove all old versions from /usr/include and /usr/lib
    * Compile and install from trunk using "./configure --prefix=/usr"
        (see https://bbs.archlinux.org/viewtopic.php?id=99807)

###PlayOnLinux

    yaourt esound
    yaourt libpng12

Awesome
-------

    sudo pacman -S awesome vicious
    ln -s ~/Dropbox/dotfiles/awesome ~/.config/

URxvt
-----

1. copy & paste 

From Manpages:

THE SELECTION: SELECTING AND PASTING TEXT

The behaviour of text selection and insertion/pasting mechanism is similar to 
xterm(1).

Selecting:

    Left click at the beginning of the region, drag to the end of the region 
    and release; Right click to extend the marked region; Left double-click 
    to select a word; Left triple-click to select the entire logical line 
    (which can span multiple screen lines), unless modified by resource 
    tripleclickwords.

    Starting a selection while pressing the Meta key (or Meta+Ctrl keys) 
    (Compile: frills) will create a rectangular selection instead of a normal 
    one. In this mode, every selected row becomes its own line in the 
    selection, and trailing whitespace is visually underlined and removed from 
    the selection.

Pasting:

    Pressing and releasing the Middle mouse button in an urxvt window causes 
    the value of the PRIMARY selection (or CLIPBOARD with the Meta modifier) 
    to be inserted as if it had been typed on the keyboard.

    Pressing Shift-Insert causes the value of the PRIMARY selection to be 
    inserted too.

Solution:

    1) Primary

        COPY  Select with mouse
        PASTE Middle-mouse click (or shift-insert within a terminal)

    2) Clipboard

        Install xsel and urxvt-perls from community repos, and enable the
        clipboard extension and keyboard shortcuts in Xresources:

            URxvt.perl-ext-common: default,clipboard,
            URxvt.keysym.M-c:      perl:clipboard:copy
            URxvt.keysym.M-v:      perl:clipboard:paste
            URxvt.keysym.M-C-v:    perl:clipboard:paste_escaped

        COPY   Alt + c (in terminal/vim) or Cntl + c (anywhere else)
        PASTE  Alt + v (in terminal/vim) or Cntl + v / Shift + insert (anywhere else)

    3) Synchronizing PRIMARY and CLIPBOARD

        To automatically sync the two selections, a clipboard manager daemon
        such as autocutsel (command-line) or parcellite (GUI) can be used.

    4) Copying and pasting URLs

        To copy and paste a URL from the terminal to a browser using the primary
        buffer, select the text and then use Cntl + L in the browser to switch
        to the location bar and highlight the existing text -- this will avoid
        overwriting the primary buffer.

        Alternatively, the perl matcher extension can be used to automatically 
        launch links.

2. SSH terminfo

    1. Copy rxvt-related terminfo files from /usr/share/terminfo to 
       ~/.terminfo on the host machine.
    2. In local .Xresources, add:
        URxvt*termName: rxvt-256color
    3. In host .screenrc, add:
        term rxvt-256color
AUR Packaging
-------------

### Upgrading:

1. Create an empty directory and download the existing PKGBUILD file there.
2. Update the PKGBUILD to point to the new version
3. Copy xxx.install and any other additional files required into directory.
4. run 'makepkg -g' to update the md5 checksum
5. run 'makepkg -s' to generate an installable package.
6. use 'sudo pacman -U xxx.pkg.tar.xz' to install and verify that 
   everything is working as expected.
7. run 'makepkg --source'
8. upload src package to [https://aur.archlinux.org/](AUR)

