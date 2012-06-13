dotfiles = $(filter-out Makefile dpkg.selections NStun.sh, $(wildcard *))

home-dotfiles = $(addprefix $(HOME)/.,$(dotfiles))

install: $(home-dotfiles)

$(HOME)/.%: %
	[ ! -e $@ -o -L $@ ]
	$(RM) $@
	ln -s $(CURDIR)/$* $@

uninstall: $(addsuffix __unlink, $(home-dotfiles))
%__unlink:
	[ -L $* ] && $(RM) $*
