dotfiles = $(filter-out Makefile dpkg.selections NStun.sh config local mozilla tags, $(wildcard *)) \
	$(filter-out Makefile, $(wildcard config/* local/share/* local/bin/*))

home-dotfiles = $(addprefix $(HOME)/.,$(dotfiles))

PREFIX := $(HOME)/.local

install: links modules

links: $(home-dotfiles)

modules:
	git submodule init
	git submodule update

$(HOME)/.%: %
	[ -e `dirname $@` ] || mkdir -p `dirname $@`

	[ ! -e $@ -o -L $@ ]
	$(RM) $@
	ln -s $(CURDIR)/$* $@

uninstall: $(addsuffix __unlink, $(home-dotfiles))

%__unlink:
	[ -L $* ] && $(RM) $*
