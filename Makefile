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

ctags: $(HOME)/.local/bin/ctags
$(HOME)/.local/bin/ctags:
	svn checkout https://svn.code.sf.net/p/ctags/code/trunk $(ROOT)
	cd $(ROOT) \
		&& wget https://gist.github.com/complex857/5693196/raw/14a770b436b5116eb22ec65492d8c0e8a4271210/0000-PHP-parser-rewrite-full-string-parameters.patch \
		&& svn patch 0000-PHP-parser-rewrite-full-string-parameters.patch \
		&& autoconf \
		&& autoheader \
		&& ./configure --prefix=$(HOME)/.local \
		&& make \
		&& make install
	cd $(CURDIR)
	rm -rf $(ROOT)

$(HOME)/.%: %
	[ ! -e $@ -o -L $@ ]
	$(RM) $@
	ln -s $(CURDIR)/$* $@

uninstall: $(addsuffix __unlink, $(home-dotfiles))

%__unlink:
	[ -L $* ] && $(RM) $*
