dotfiles = $(filter-out Makefile dpkg.selections NStun.sh config tags, $(wildcard *)) \
	$(filter-out Makefile, $(wildcard config/*))

home-dotfiles = $(addprefix $(HOME)/.,$(dotfiles))

install: $(home-dotfiles)
	fc-cache ~/.fonts

$(HOME)/.%: %
	[ ! -e $@ -o -L $@ ]
	$(RM) $@
	ln -s $(CURDIR)/$* $@

uninstall: $(addsuffix __unlink, $(home-dotfiles))
%__unlink:
	[ -L $* ] && $(RM) $*
