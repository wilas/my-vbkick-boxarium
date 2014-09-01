# Description:

Vagrant boxes for my projects described as a code (vbkick templates).

All templates are using Polish keymaps.
You may prefer use [vbkick-templates](https://github.com/wilas/vbkick-templates) or [vbkick-templates-forge](https://github.com/wilas/vbkick-templates-forge)

# Step by step (SL6 as an example):

```
# installed vbkick is required
# git clone https://github.com/wilas/vbkick
# cd vbkick && sudo make install

# installed vagrant is required
# http://docs.vagrantup.com/v2/installation/index.html

cd SL6
vbkick build 'SL6'
vbkick postinstall 'SL6'
vbkick validate 'SL6'
vbkick export 'SL6'

vagrant box add 'SL6' 'SL6.box'
vagrant box list
```

# Bibliography:

- vbkick project page: https://github.com/wilas/vbkick
- vagrant step by step: http://www.jedi.be/blog/2011/03/28/using-vagrant-as-a-team/
- how to create vagrant box by hand: http://blog.vandenbrand.org/2012/02/21/creating-a-centos-6-2-base-box-for-vagrant/
