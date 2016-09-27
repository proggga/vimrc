HEADER_FILES = vim.git
init: install
	-@test ! -d $(CURDIR)/.backup && mkdir $(CURDIR)/.backup || true
	-@test -L ~/.vimrc && mv ~/.vimrc $(CURDIR)/.backup/.vimrc_backup_link || true
	-@test -f ~/.vimrc && mv ~/.vimrc $(CURDIR)/.backup/.vimrc_backup || true
	-@test ! -L ~/.vimrc && ln -s $(CURDIR)/.vimrc ~/.vimrc || true
	-@test ! -d ~/.vim && mkdir ~/.vim || true
	-@test ! -d ~/.vim/backup && mkdir ~/.vim/backup || true
	-@test ! -d ~/.vim/bundle && mkdir ~/.vim/bundle || true
	-@test ! -d ~/.vim/bundle && mkdir ~/.vim/bundle || true
	-@test ! -d ~/.vim/bundle/Vundle.vim && git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim || true
	vim +PluginInstall +qall

install:
	@if [ ! -d "vim.git" ]; then echo "installing vim"; \
		git clone https://github.com/vim/vim vim.git; \
		cd vim.git/src; \
		make distclean; \
		./configure --with-features=huge --enable-rubyinterp --enable-python3interp --enable-pythoninterp --enable-perlinterp --enable-multibyte --enable-luainterp --with-x --enable-gui=auto; \
		make; \
		sudo make install; \
	else \
		echo "vim installed"; \
	fi;

update:
	@if [ ! -d "vim.git" ]; then echo "installing vim"; \
		echo "yolo"; \
		git clone https://github.com/vim/vim vim.git; \
	fi;
	cd vim.git/src; \
	make distclean; \
	./configure --with-features=huge --enable-rubyinterp --enable-python3interp --enable-pythoninterp --enable-perlinterp --enable-multibyte --enable-luainterp --with-x --enable-gui=auto; \
	make; \
	sudo make install; \
