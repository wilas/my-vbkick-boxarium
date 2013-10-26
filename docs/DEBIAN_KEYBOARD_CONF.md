# Debian keyboard polonization.

## Helpful configuration commands

```
    ls -la /usr/share/X11/xkb/symbols/pl
    sudo dpkg-reconfigure keyboard-configuration 
    sudo dpkg-reconfigure console-setup
```

## Correct settings output

```
vagrant@vagrant:~$ sudo debconf-show console-setup
* console-setup/codeset47: # Latin2 - central Europe and Romanian
* console-setup/fontface47: Fixed
  console-setup/fontsize-text47: 8x16
* console-setup/charmap47: UTF-8
  console-setup/framebuffer_only:
  console-setup/codesetcode: Lat2
  console-setup/guess_font:
  console-setup/store_defaults_in_debconf_db: true
* console-setup/fontsize-fb47: 8x16
  console-setup/use_system_font:
  console-setup/fontsize: 8x16

```

```
vagrant@vagrant:~$ sudo debconf-show keyboard-configuration 
* keyboard-configuration/modelcode: pc105
  keyboard-configuration/unsupported_config_options: true
  keyboard-configuration/unsupported_config_layout: true
* keyboard-configuration/toggle: No toggling
* keyboard-configuration/compose: No compose key
* keyboard-configuration/layout:
* keyboard-configuration/xkb-keymap: pl
* keyboard-configuration/variant: Polish
  debian-installer/console-setup-udeb/title:
* keyboard-configuration/switch: No temporary switch
  keyboard-configuration/unsupported_options: true
* keyboard-configuration/altgr: The default for the keyboard layout
  keyboard-configuration/ctrl_alt_bksp: false
  keyboard-configuration/unsupported_layout: true
* keyboard-configuration/variantcode:
* keyboard-configuration/model: Generic 105-key (Intl) PC
* keyboard-configuration/layoutcode: pl
* keyboard-configuration/other:
* keyboard-configuration/store_defaults_in_debconf_db: true
* keyboard-configuration/optionscode:

```

```
vagrant@vagrant:~$ cat /etc/default/keyboard 
    # KEYBOARD CONFIGURATION FILE

    # Consult the keyboard(5) manual page.

    XKBMODEL="pc105"
    XKBLAYOUT="pl"
    XKBVARIANT=""
    XKBOPTIONS=""

    BACKSPACE="guess"
```

```
vagrant@vagrant:~$ cat /etc/default/console-setup 
    # CONFIGURATION FILE FOR SETUPCON

    # Consult the console-setup(5) manual page.

    ACTIVE_CONSOLES="/dev/tty[1-6]"

    CHARMAP="UTF-8"

    CODESET="Lat2"
    FONTFACE="Fixed"
    FONTSIZE="8x16"

    VIDEOMODE=

    # The following is an example how to use a braille font
    # FONT='lat9w-08.psf.gz brl-8x8.psf'
```

## Dump cmds for preseed.

```
    sudo apt-get -y install debconf-utils
    sudo debconf-get-selections --installer > preseed.cfg
    sudo debconf-get-selections >> preseed.cfg
```

## Installation - boot parameters
```
debian-installer/keymap=pl keymap=pl
or
auto=true priority=critical #+preseed
```
More, why both: (keymap question and boot settings, but still English): http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=693956

## Installation - preseed

!! Note: Not working when keymap boot parameters are used.
```
d-i debian-installer/keymap select pl
d-i keyboard-configuration/xkb-keymap select pl
#or
d-i console-setup/ask_detect boolean false
#d-i keyboard-configuration/layout select Polish
d-i keyboard-configuration/variant select Polish
d-i keyboard-configuration/modelcode string pc105
d-i keyboard-configuration/layoutcode string pl
#d-i keyboard-configuration/variantcode string pl
d-i keyboard-configuration/xkb-keymap select pl
```

Note (!! Not working): problem with "console-setup/codesetcode" setting to Lat2 (latin2) in both boot_param and preseed.
"console-setup/codeset   string  # Latin2 - central Europe and Romanian" doesn't work as well.
```
#d-i debian-installer/consoledisplay string  console-setup
d-i console-setup/ask_detect boolean false
d-i console-setup/codesetcode string Lat2
d-i console-setup/codeset   string  # Latin2 - central Europe and Romanian
d-i console-setup/codeset   string  Lat2
d-i console-setup/codeset47 string  # Latin2 - central Europe and Romanian
d-i console-setup/codeset47 string  Lat2
#d-i console-setup/variant   select  PL
```

# Localization
```
# People live in Poland
d-i debian-installer/country string PL
# System speak English
d-i debian-installer/language string en
d-i debian-installer/locale string en_US.UTF-8
d-i localechooser/supported-locales multiselect en_US.UTF-8, pl_PL.UTF-8
```

```
d-i clock-setup/utc boolean true
d-i time/zone string Europe/Warsaw
#d-i time/zone string UTC
```
