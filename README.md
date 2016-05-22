dotfiles
========

This is my personal `.files` and configuration and scripts that I use for
development  
Use at own risk, NO WARRANTY, to the extent permitted by law.

This configuration is targeted [Arch Linux][arch] but should, with smaller
modifications, be able to run on almost any Linux distro.

Feel free to make a [pull request][pulls] or use the [issue tracker][issues] if
you have any improvements or question.

Installation:
------------

	git clone https://github.com/andlrc/dotfiles "$HOME/work/dotfiles"
	cd "$HOME/work/dotfiles" || exit 2
	make install

Browse:
-------

All files in the [`home`](home) directory will be symbolic linked to the users
home directory (`$HOME`). Directories will be created as needed.

**Quick links**

* [`vimrc`](home/.vim/vimrc)
* [`zshrc`](home/.zshrc)
* [`zlogin`](home/.zlogin)
* [`i3 configuration file`](home/.config/i3/config)

License:
--------

See [LICENSE](LICENSE)

[arch]: https://archlinux.org
[pulls]: https://github.com/andlrc/dotfiles/pulls
[issues]: https://github.com/andlrc/dotfiles/issues
