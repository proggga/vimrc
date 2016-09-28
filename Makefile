SCRIPT_BACKUP = $(CURDIR)/.backup
VIMRC = $$HOME/.vimrc
VIM_PLUGINS_FILE = $$HOME/.vim_plugins
VIM_DIR = $$HOME/.vim
VIM_PLUGINS_DIR = $(VIM_DIR)/plugin
SET_COLORS = $(VIM_PLUGINS_DIR)/setcolors.vim
VIM_BACKUP = $(VIM_DIR)/backup
VIM_BUNDLE = $(VIM_DIR)/bundle
VUNDLE_LINK = https://github.com/VundleVim/Vundle.vim.git
VUNDLE_DIR = $(VIM_BUNDLE)/Vundle.vim
VIM_PROJ_DIR = $(CURDIR)/vim.git
VIM_GITHUB = https://github.com/vim/vim
CONFIGURE_OPTIONS = "--with-features=huge --enable-rubyinterp --enable-python3interp --enable-pythoninterp --enable-perlinterp --enable-multibyte --enable-luainterp --with-x --enable-gui=auto"
init: install
	# PREPARE DIRS
	-@test ! -d $(SCRIPT_BACKUP) && mkdir $(SCRIPT_BACKUP) || true
	-@test ! -d $(VIM_DIR)&& mkdir $(VIM_DIR) || true
	-@test ! -d $(VIM_PLUGINS_DIR) && mkdir $(VIM_PLUGINS_DIR) || true
	-@test ! -d $(VIM_BACKUP) && mkdir $(VIM_BACKUP) || true
	-@test ! -d $(VIM_BUNDLE) && mkdir $(VIM_BUNDLE) || true
	# DOWNLOAD VUNDLE FROM GITHUB
	-@test ! -d $(VUNDLE_DIR) && git clone $(VUNDLE_LINK) $(VUNDLE_DIR) || true

	# BACKUP .vimrc
	-@test -L $(VIMRC) && mv $(VIMRC) $(SCRIPT_BACKUP)/.vimrc_backup_link || true
	-@test -f $(VIMRC) && mv $(VIMRC) $(SCRIPT_BACKUP)/.vimrc_backup || true
	# INSTALL .vimrc
	-@test ! -L $(VIMRC) && ln -s $(CURDIR)/.vimrc $(VIMRC) || true

	# BACKUP .vim_plugins
	-@test -L $(VIM_PLUGINS_FILE) && mv $(VIM_PLUGINS_FILE) $(SCRIPT_BACKUP)/.vim_plugins_backup_link || true
	-@test -f $(VIM_PLUGINS_FILE) && mv $(VIM_PLUGINS_FILE) $(SCRIPT_BACKUP)/.vim_plugins_backup || true
	# INSTALL .vim_plugins
	-@test ! -L $(VIM_PLUGINS_FILE) && ln -s $(CURDIR)/.vim_plugins $(VIM_PLUGINS_FILE) || true

	# BACKUP setcolors.vim
	-@test -L $(SET_COLORS) && mv $(SET_COLORS) $(SCRIPT_BACKUP)/setcolors.vim_backup_link || true
	-@test -f $(SET_COLORS) && mv $(SET_COLORS) $(SCRIPT_BACKUP)/setcolors.vim_backup || true
	# INSTALL setcolors.vim
	-@test ! -L $(SET_COLORS) && ln -s $(CURDIR)/setcolors.vim $(SET_COLORS) || true

	# INSTALL PLUGINS
	vim +PluginInstall +qall

install:
	@if [ ! -d "$(VIM_PROJ_DIR)" ]; then echo "installing vim"; \
		echo "# CLONE VIM FROM GITHUB"; \
		git clone $(VIM_GITHUB) $(VIM_PROJ_DIR); \
		cd $(VIM_PROJ_DIR)/src; \
		make distclean; \
		./configure $(CONFIGURE_OPTIONS) ;\
		make; \
		sudo make install; \
		echo "successful installed"; \
	else \
		echo "vim installed"; \
	fi;

update:
	@if [ ! -d "$(VIM_PROJ_DIR)" ]; then echo "installing vim"; \
		echo "# CLONE VIM FROM GITHUB"; \
		git clone $(VIM_GITHUB) $(VIM_PROJ_DIR); \
	fi;
	cd $(VIM_PROJ_DIR) ; \
	echo "# PULL VIM FROM GITHUB"; \
	git pull ; \
	cd $(VIM_PROJ_DIR)/src; \
	make distclean; \
	./configure $(CONFIGURE_OPTIONS) ;\
	make; \
	sudo make install; \
	echo "successful installed"; \
