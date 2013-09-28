[Kernel Links]
 - kernel versions: http://packages.debian.org/search?keywords=linux-source
 - more info: http://packages.qa.debian.org/l/linux.html
 - build kernel: http://code.jasonbhill.com/linux/rolling-a-kernel-in-debian-wheezysid/
 - kernel 3.8 (other, just edit url): http://kernelnewbies.org/Linux_3.8
 - docker on debian 7 wheezy using ubuntu kernel: http://www.grendelman.net/wp/docker-on-debian-wheezy/
 - other ubuntu kernels: http://kernel.ubuntu.com/~kernel-ppa/mainline/  (wget headers-all.deb, headers.deb, image.deb + sudo dpkg -i *.deb)
 - liquorix multimedia kernel: http://liquorix.net/

[Preseed]
 - !!! http://www.debian.org/releases/stable/amd64/apbs04.html.en
 - example: http://www.debian.org/releases/wheezy/example-preseed.txt
 - example from ubuntu: http://sfxpt.wordpress.com/2013/06/09/get-the-debianubuntu-ready-and-customized-the-way-you-like-in-10-minutes/
 - http://www.debian.org/devel/debian-installer

[Debian Stable + Backports]
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

[Other]
 - debuild -us -uc (skip promptings for the GPG signatures): http://www.debian.org/doc/manuals/maint-guide/build.en.html#debuild
 - multimedia: http://www.deb-multimedia.org/
 - mozilla team: http://mozilla.debian.net/
 - missing firmware: http://www.debian.org/releases/stable/i386/ch06s04.html.en
 - sourcelist gen: http://debgen.simplylinux.ch/
