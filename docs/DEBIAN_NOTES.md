[Kernel Links]
 - kernel versions: http://packages.debian.org/search?keywords=linux-source
 - more info: http://packages.qa.debian.org/l/linux.html
 - build kernel: http://code.jasonbhill.com/linux/rolling-a-kernel-in-debian-wheezysid/
 - kernel 3.8 (other, just edit url): http://kernelnewbies.org/Linux_3.8
 - docker on debian 7 wheezy using ubuntu kernel: http://www.grendelman.net/wp/docker-on-debian-wheezy/
 - other ubuntu kernels: http://kernel.ubuntu.com/~kernel-ppa/mainline/  (wget headers-all.deb, headers.deb, image.deb + sudo dpkg -i *.deb)
 - liquorix multimedia kernel: http://liquorix.net/

[Preseed]
 - !!! full example + description: http://www.debian.org/releases/stable/amd64/apbs04.html.en (http://www.debian.org/releases/stable/amd64/apb.html.en)
 - !!! example: http://www.debian.org/releases/wheezy/example-preseed.txt
 - ! example from ubuntu (keyboard): https://help.ubuntu.com/lts/installation-guide/i386/preseed-contents.html
 - example from ubuntu (more links): http://sfxpt.wordpress.com/2013/06/09/get-the-debianubuntu-ready-and-customized-the-way-you-like-in-10-minutes/
 - example with X: http://www.debian.org/releases/etch/example-preseed.txt
 - using preseed files: http://debian-handbook.info/browse/stable/sect.automated-installation.html
 - install media: http://www.debian.org/devel/debian-installer
 - tasksel: https://wiki.debian.org/tasksel
 - include other preseed files: http://www.debian.org/releases/stable/amd64/apbs05.html.en
 - boot parameters: http://www.debian.org/releases/wheezy/i386/ch05s03.html.en
 - aliases useful with preseeding: http://www.debian.org/releases/stable/i386/apbs02.html.en#preseed-bootparms
 - generate preseed - 4.13: http://www.debian.org/releases/stable/amd64/apbs04.html.en

[Debian Stable + Backports]
 - full install guide: http://www.debian.org/releases/stable/amd64/
 - http://backports.debian.org/
 - http://backports.debian.org/Instructions/

[Debian Testing "Jessie"]
 - http://www.debian.org/releases/jessie/
 - http://ftp.debian.org/debian/dists/
 - http://security.debian.org/dists/

[Debian Unstable "Sid"]
 - http://www.debian.org/releases/sid/
 - https://wiki.debian.org/DebianUnstable#How_do_I_install_Unstable.3F
 - !!! http://wooledge.org/~greg/sidfaq.html
 - mini.iso: https://wiki.debian.org/InstallFAQ
 - /etc/apt/apt.conf.d/05default-release: http://forums.debian.net/viewtopic.php?f=30&t=103878
 - /etc/apt/preferences: http://linuxaria.com/howto/how-to-install-a-single-package-from-debian-sid-or-debian-testing
 - APT::Default-Release: http://www.linuxquestions.org/questions/linux-distributions-5/best-way-to-install-debian-sid-45156/
 - apt-cache policy: https://wiki.debian.org/DebianUnstable#How_do_I_install_Unstable.3F

[Debian Experimental]
 - http://packages.debian.org/experimental/

[lxc]
 - http://www.stefan-seelmann.de/wiki/lxc

[init]
 - upstart, systemd, sysvinit: http://lists.debian.org/debian-devel/2012/03/msg00452.html

[desktop]
 - flash: https://wiki.debian.org/Flash (http://www.cyberciti.biz/faq/debian-linux-7-wheezy-install-flash-player/)
 - iceweasel/firefox: http://blog.toubiweb.com/iceweasel-firefox-on-debian/ (https://wiki.debian.org/Iceweasel)
 - mozilla deb: http://mozilla.debian.net/
 - java: http://openjdk.java.net/install/
 - sound: https://wiki.debian.org/SoundCard
 - sound troubleshooting: http://forums.debian.net/viewtopic.php?f=6&t=63720 (http://forums.debian.net/viewtopic.php?f=7&t=69198)
 - multimedia: https://wiki.debian.org/DebianMultimedia/FAQ

[pl]
 - Polonizacja: http://www.debian.pl/threads/524-Polonizacja-Debiana-Etch-Sid
 - Locale: http://pl.wikipedia.org/wiki/Locale
 - configure locale (/etc/locale.gen): http://people.debian.org/~schultmc/locales.html
 - ubuntu + usb + pl: http://ubuntu.pl/forum/viewtopic.php?f=133&t=153208&sid=deffbbe98ba6022b3eea36ad72be8696&start=20
 - setxkbmap pl (https://wiki.debian.org/Keyboard) (http://www.pclinuxos.com/forum/index.php?topic=95438.0)

[keyboard]
 - keyboard-configuration/modelcode=SKIP: http://ubuntuforums.org/archive/index.php/t-1865826.html
 - keyboard + locale: http://ubuntuforums.org/archive/index.php/t-2004485.html
 - keyboard-configuration (layoutcode)(XKBMODEL="pc105"): http://www.archivum.info/debian-bugs-closed@lists.debian.org/2010-03/00395/Bug-568475-marked-as-done-%28No-need-to-use-pc104-for-Brazilian-and-US-layouts%29.html
 - XKB Configuration Guide: http://www.x.org/archive/X11R7.5/doc/input/XKB-Config.html
 - setxkbmap pl: http://forums.debian.net/viewtopic.php?f=30&t=50215
 - dpkg-reconfigure keyboard-configuration: https://wiki.debian.org/Keyboard
 - keymap + linux_console + font (make pl): http://www.linuxfromscratch.org/lfs/view/development/chapter07/console.html
 - select variant was necessary:  http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=610524
 - keyboard - various distro: http://www.howtoforge.com/changing-language-and-keyboard-layout-on-various-linux-distributions
 - keyboard-configuration/layoutcode=us. "The layout code is an X layout name, as would be used in the XkbLayout option in /etc/X11/xorg.conf"

[console-setup]
 - pl lang. in Lat2 (files: /etc/default/console-setup; /etc/default/keyboard): http://dev.man-online.org/man5/console-setup/
 - codesets to choose: http://dev.man-online.org/man5/console-setup/
 - codeset problem (d-i console-setup/codesetcode string Uni1): https://bugs.launchpad.net/ubuntu/+source/console-setup/+bug/379498
 - console-setup usually runs before the preseed file is processed (2008): https://lists.ubuntu.com/archives/ubuntu-installer/2008-October/000251.html
 - whole bunch of settings (preseed): http://lists.debian.org/debian-boot/2010/10/msg00164.html

[boot param.]
 - !!! keymap question and boot settings (still English): http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=693956
 - about boot param: http://www.debian.org/releases/stable/i386/ch05s03.html.en
 - boot param example (auto-install/enable=false): http://www.credativ.co.uk/credativ-blog/2010/07/howto-debian-preseed-with-netboot
 - auto=true as boot parameter does not work properly: https://bugs.launchpad.net/ubuntu/+source/debian-installer/+bug/827861

[Other]
 - debuild -us -uc (skip promptings for the GPG signatures): http://www.debian.org/doc/manuals/maint-guide/build.en.html#debuild
 - missing firmware: http://www.debian.org/releases/stable/i386/ch06s04.html.en
 - sourcelist gen: http://debgen.simplylinux.ch/
 - DEBIAN_FRONTED: https://github.com/travis-ci/travis-cookbooks/issues/80
 - "Bootstraps a basic puppet defaults file over to the target drive": http://blogs.cae.tntech.edu/mwr/2007/04/17/unattended-debian-installations-or-how-i-learned-to-stop-worrying-and-love-the-preseedcfg/
