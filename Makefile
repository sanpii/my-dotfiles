dotfiles = $(filter-out Makefile dpkg.selections NStun.sh config local tags, $(wildcard *)) \
	$(filter-out Makefile, $(wildcard config/* local/share/* local/bin/*))

home-dotfiles = $(addprefix $(HOME)/.,$(dotfiles))

PREFIX := $(HOME)/.local

install: links fonts modules ctags rofi neovim

links: $(home-dotfiles)

fonts:
	fc-cache ~/.fonts

modules:
	git submodule init
	git submodule update

ctags: $(PREFIX)/bin/ctags

$(PREFIX)/bin/ctags:
	wget https://github.com/shawncplus/phpcomplete.vim/raw/master/misc/ctags-5.8_better_php_parser.tar.gz -O - | tar zx
	cd ctags \
		&& ./configure --prefix=$(PREFIX) \
		&& make \
		&& make install
	cd $(CURDIR)
	rm -rf ctags/

roffi: $(PREFIX)/bin/rofi

$(PREFIX)/bin/rofi:
	git clone https://github.com/DaveDavenport/rofi.git
	cd rofi \
		&& autoreconf -i \
		&& ./configure --prefix=$(PREFIX) \
		&& make \
		&& make install
	cd $(CURDIR)
	rm -rf rofi

neovim:
	pip install --user neovim

$(HOME)/.%: %
	[ ! -e $@ -o -L $@ ]
	$(RM) $@
	ln -s $(CURDIR)/$* $@

uninstall: $(addsuffix __unlink, $(home-dotfiles))

%__unlink:
	[ -L $* ] && $(RM) $*
