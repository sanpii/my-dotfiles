dotfiles = $(filter-out Makefile dpkg.selections NStun.sh config tags, $(wildcard *)) \
	$(filter-out Makefile, $(wildcard config/*))

home-dotfiles = $(addprefix $(HOME)/.,$(dotfiles))

ROOT := $(shell mktemp -d)

install: $(home-dotfiles) fonts modules ctags

fonts:
	fc-cache ~/.fonts

modules:
	git submodule init
	git submodule update

ctags: $(HOME)/.local/bin/phpctags
$(HOME)/.local/bin/phpctags:
	git clone https://github.com/vim-php/phpctags.git $(ROOT)
	cd $(ROOT) \
		&& make \
		&& mv phpctags $@
	cd $(CURDIR)
	rm -rf $(ROOT)

$(HOME)/.%: %
	[ ! -e $@ -o -L $@ ]
	$(RM) $@
	ln -s $(CURDIR)/$* $@

uninstall: $(addsuffix __unlink, $(home-dotfiles))

%__unlink:
	[ -L $* ] && $(RM) $*
