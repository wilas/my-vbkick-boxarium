# Description:

Vagrant boxes mix for my projects.

## Step by step (SL6 as an example):

    # installed vbkick is required
    # git clone https://github.com/wilas/vbkick
    # cd vbkick && sudo make install && cd ..

    # installed vagrant is required
    # http://docs.vagrantup.com/v2/installation/index.html

    cd SL6_box
    vbkick build 'SL6_box'
    vbkick validate 'SL6_box'
    vbkick export 'SL6_box'

    vagrant box add 'SL6' 'SL6_box.box'
    vagrant box list

## Bibliography:
 - vbkick project page: https://github.com/wilas/vbkick
 - vbkick scientific linux template: https://github.com/wilas/scientificlinux6-vbkick-template
 - vagrant step by step: http://www.jedi.be/blog/2011/03/28/using-vagrant-as-a-team/
 - how to create vagrant box by hand: http://blog.vandenbrand.org/2012/02/21/creating-a-centos-6-2-base-box-for-vagrant/
