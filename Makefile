# README.md
# make - install vim without support any modules

#Makefile 'spacebar' problem hack
EMPTY :=
SPACE := $(EMPTY) $(EMPTY)

#VARIABLES
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
VIM_CONFIG_OPTS_FILE = $(VIM_PROJ_DIR)/.configure_options
VIM_GITHUB = https://github.com/vim/vim
VIMDIR_EXISTS = $(shell if [ -d "$(VIM_PROJ_DIR)" ]; then echo "True"; fi; )

KEY_RUBY = --enable-rubyinterp
KEY_PYTHON2 = --enable-pythoninterp
KEY_PYTHON3 = --enable-python3interp
KEY_LUA = --enable-luainterp
KEY_PERL = --enable-perlinterp
KEY_GUI = --with-x --enable-gui=auto
KEY_FEATURES = --with-features=huge --enable-multibyte

ALL_CONFIGURE_OPTIONS = \
	--with-features=huge \
	--enable-rubyinterp \
	--enable-pythoninterp=dynamic \
	--enable-python3interp=dynamic \
	--enable-perlinterp \
	--enable-multibyte \
	--enable-luainterp \
	--with-x \
	--enable-gui=auto

#CONFIGURE_OPTIONS =
CONFIGURE_OPTIONS = $(shell if [ -f $(VIM_CONFIG_OPTS_FILE) ] ; then cat $(VIM_CONFIG_OPTS_FILE); fi;)
MAKECMDGOALS := $(shell echo $(MAKECMDGOALS) | sed 's/preconfigure //g')
PARAM_RUBY := $(shell echo $(MAKECMDGOALS) | grep -i ruby)
PARAM_PYTHON2 := $(shell echo $(MAKECMDGOALS) | grep -i python2)
PARAM_PYTHON3 := $(shell echo $(MAKECMDGOALS) | grep -i python3)
PARAM_LUA := $(shell echo $(MAKECMDGOALS) | grep -i lua)
PARAM_PERL := $(shell echo $(MAKECMDGOALS) | grep -i perl)
PARAM_GUI := $(shell echo $(MAKECMDGOALS) | grep -i gui)
PARAM_FEATURES := $(shell echo $(MAKECMDGOALS) | grep -i features)

# install with all keys
clean:
	rm -rf $(VIM_PROJ_DIR)

cleaninstall: preconfigure cleanopts install
install: all
all: installvim generatelinks

generatelinks:
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

up-plug:
	# INSTALL PLUGINS
	vim +PluginInstall +qall

installvim: preconfigure
ifneq ($(VIMDIR_EXISTS),True)
	@echo "installing vim";
	@echo "# CLONE VIM FROM GITHUB";
	@git clone $(VIM_GITHUB) $(VIM_PROJ_DIR);
	@echo "CONFIGURE" $(CONFIGURE_OPTIONS);
	@cd $(VIM_PROJ_DIR)/src && ./configure $(CONFIGURE_OPTIONS);
	@cd $(VIM_PROJ_DIR)/src && make;
	@cd $(VIM_PROJ_DIR)/src && sudo make install;
	@echo "successful install";
else
	@echo "vim installed";
endif

reinstall : update
update : updatevim generatelinks
updatevim: preconfigure
ifneq ($(VIMDIR_EXISTS),True)
	@echo "installing vim";
	@echo "# CLONE VIM FROM GITHUB";
	@git clone $(VIM_GITHUB) $(VIM_PROJ_DIR);
else
	@echo "# PULL VIM FROM GITHUB";
	@cd $(VIM_PROJ_DIR) && git pull;
endif
	@cd $(VIM_PROJ_DIR)/src && make distclean;
	@cd $(VIM_PROJ_DIR)/src && ./configure $(CONFIGURE_OPTIONS);
	@cd $(VIM_PROJ_DIR)/src && make;
	@cd $(VIM_PROJ_DIR)/src && sudo make install;
	@echo "successful installed";


# It catch any target that was not found ( I use it like arguments)
%:
	@:

preconfigure:
	echo "preconfigure"

ifneq ($(PARAM_RUBY),)
	$(eval CONFIGURE_OPTIONS := $(KEY_RUBY)$(SPACE))
endif

ifneq ($(PARAM_PYTHON2),)
	$(eval CONFIGURE_OPTIONS := $(CONFIGURE_OPTIONS)$(KEY_PYTHON2)$(SPACE))
endif

ifneq ($(PARAM_PYTHON3),)
	$(eval CONFIGURE_OPTIONS := $(CONFIGURE_OPTIONS)$(KEY_PYTHON3)$(SPACE))
endif

ifneq ($(PARAM_LUA),)
	$(eval CONFIGURE_OPTIONS := $(CONFIGURE_OPTIONS)$(KEY_LUA)$(SPACE))
endif

ifneq ($(PARAM_PERL),)
	$(eval CONFIGURE_OPTIONS := $(CONFIGURE_OPTIONS)$(KEY_PERL)$(SPACE))
endif

ifneq ($(PARAM_GUI),)
	$(eval CONFIGURE_OPTIONS := $(CONFIGURE_OPTIONS)$(KEY_GUI)$(SPACE))
endif

ifneq ($(PARAM_FEATURES),)
	$(eval CONFIGURE_OPTIONS := $(CONFIGURE_OPTIONS)$(KEY_FEATURES)$(SPACE))
endif

ifeq ($(CONFIGURE_OPTIONS),)
	$(eval CONFIGURE_OPTIONS := $(ALL_CONFIGURE_OPTIONS))
endif
	@echo $(CONFIGURE_OPTIONS)

cleanopts:
	$(eval CONFIGURE_OPTIONS := )
