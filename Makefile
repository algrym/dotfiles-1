root := $$(git rev-parse --show-toplevel)

all: clean install
install: rc-install vim-install
clean: rc-clean vim-clean

rc-clean:
	git log --pretty=format: --name-only --diff-filter=A | sort -u \
		| sed -n '/^home/p' | xargs -n 1 -I '{}' \
			sh -c 'file="{}"; \
				unlink "$(HOME)/$${file#home/}" 2> /dev/null; \
				rmdir "$$(dirname "$(HOME)/$${file#home/}")" 2> /dev/null || exit 0'

rc-install:
	find home -type f | while read -r file; do \
		mkdir -p "$(HOME)/$$(dirname "$${file#home/}")"; \
		ln -s "$(root)/$$file" "$(HOME)/$${file#home/}"; \
	done

vim-clean:

vim-install:
	mkdir -p "$(HOME)/.vim/bundle"
	sed -n "s/Plugin \(['\"]\)\(.*\)\1/\2/p;/vundle#end/q" "$(root)/home/.vim/vimrc" | while read -r f; do \
			git clone https://github.com/"$$f" \
				"$(HOME)/.vim/bundle/$$(basename "$$f")" 2> /dev/null || true; \
		done
