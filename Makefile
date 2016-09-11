root := $$(git rev-parse --show-toplevel)

all:
	@echo "Run:"
	@echo "  yaourt-install"
	@echo "  deps-install"
	@echo "  dash-install"
	@echo "  rc-install"
	@echo "  vim-install"

deps-install:
	sudo pacman -S base-devel gvim sysstat alsa-utils termite \
		xautolock chromium nodejs npm feh acpi acpid ttf-dejavu redshift xclip ed \
		rdesktop openssh deadbeef imagemagick scrot dmenu perl-json dunst \
		getmail mutt gnome-keyring libnotify lynx weechat openconnect pptpclient

	yaourt -S ttf-font-awesome

	sudo npm install -g jscs
	sudo cpan install Perl::Critic
	sudo pacman -S shellcheck

	git clone https://github.com/trapd00r/clipbored "$(HOME)/.clipbored" || true
	git clone https://github.com/michaeldfallen/git-radar "$(HOME)/.git-radar" || true

yaourt-install:
	mkdir -p build
	rm -rf build/package-query 2> /dev/null || true
	git clone https://aur.archlinux.org/package-query.git build/package-query
	cd build/package-query; \
		makepkg -si

	rm -rf build/yaourt 2> /dev/null || true
	git clone https://aur.archlinux.org/yaourt.git build/yaourt
	cd build/yaourt; \
		makepkg -si

dash-install:
	sudo pacman -S dash
	sudo ln -sfT dash /bin/sh
	sudo sed -i '/^\[options\]/,/^\[/ { /^NoUpgrade\|^NoExtract/d; }' /etc/pacman.conf
	( echo '/\[options\]/a'; \
		echo 'NoUpgrade = usr/bin/sh'; \
		echo 'NoExtract = usr/bin/sh'; \
		echo '.'; \
		echo 'w'; \
	) | sudo ed -s /etc/pacman.conf

rc-clean:
	git log --pretty=format: --name-only --diff-filter=A | sort -u \
		| sed -n '/^home/p' | xargs -n 1 -I '{}' \
			sh -c 'file="{}"; file_abs="$(HOME)/$${file#home/}"; \
				if (stat "$$file_abs" 2> /dev/null || printf "\n") | sed -n '\''/ -> /q;q1'\''; then \
					unlink -- "$$file_abs"; \
					rmdir -- "$$(dirname "$$file_abs")" 2> /dev/null; \
				else \
				>&2 printf "%s is not a symbolic link\n" "$$file"; \
				fi; exit 0'

rc-install:
	find home -type f | while read -r file; do \
		mkdir -p "$(HOME)/$$(dirname "$${file#home/}")"; \
		ln -sv "$(root)/$$file" "$(HOME)/$${file#home/}" || true; \
	done

vim-clean:

vim-install:
	mkdir -p "$(HOME)/.vim/bundle"
	sed -n "s/Plugin \(['\"]\)\(.*\)\1/\2/p;/vundle#end/q" "$(root)/home/.vim/vimrc" \
		| while read -r f; do \
			git clone https://github.com/"$$f" \
				"$(HOME)/.vim/bundle/$$(basename "$$f")" 2> /dev/null || true; \
		done
