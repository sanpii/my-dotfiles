dotfiles = $(filter-out Makefile dpkg.selections NStun.sh config local librewolf tags, $(wildcard *)) \
	$(filter-out Makefile, $(wildcard config/* local/share/* local/bin/*))

home-dotfiles = $(addprefix $(HOME)/.,$(dotfiles))

PREFIX := $(HOME)/.local

install: links

links: $(home-dotfiles)

$(HOME)/.%: %
	[ -e `dirname $@` ] || mkdir -p `dirname $@`

	[ ! -e $@ -o -L $@ ]
	$(RM) $@
	ln -s $(CURDIR)/$* $@

uninstall: $(addsuffix __unlink, $(home-dotfiles))

%__unlink:
	[ -L $* ] && $(RM) $*
