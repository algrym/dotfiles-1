dotfiles
========

Be warned this is my personal 🐧 files and configuration  
This configuration is targeted [Arch Linux][arch]. But might work on other
distros.

Feel free to make a [pull request][pulls] or use the [issue tracker][issues] if
you have any improvements or questions.

Browse:
-------

All files in the [`home`](home) directory will be symbolic linked to the users
home directory (`$HOME`). Directories will be created as needed.

Installation:
------------

	git clone https://github.com/andlrc/dotfiles "$HOME/work/dotfiles" \
		&& cd "$HOME/work/dotfiles" \
		&& make install

Quick links
-----------


* [`.festivalrc`](home/.festivalrc)
* [`.getmail`](home/.getmail)
* [`.gitconfig`](home/.gitconfig)
* [`.i3`](home/.config/i3)
* [`.i3status.conf`](home/.i3status.conf)
* [`.inputrc`](home/.inputrc)
* [`.jscsrc`](home/.jscsrc)
* [`.muttrc`](home/.muttrc)
* [`.vim`](home/.vim)
* [`.weechat`](home/.weechat)
* [`.xinitrc`](home/.xinitrc)
* [`.Xmodmap`](home/.Xmodmap)
* [`.zlogin`](home/.zlogin)
* [`.zshrc`](home/.zshrc)

License:
--------

See [LICENSE](LICENSE)

[arch]: https://archlinux.org
[pulls]: https://github.com/andlrc/dotfiles/pulls
[issues]: https://github.com/andlrc/dotfiles/issues
