HEADER_FILES = vim.git
init:
	-@test ! -d ~/.vim && mkdir ~/.vim
	-@test ! -d ~/.vim/backup && mkdir ~/.vim/backup
	-@test ! -d ~/.vim/bundle && mkdir ~/.vim/bundle
	-@test ! -d ~/.vim/bundle && mkdir ~/.vim/bundle
	-@test ! -d ~/.vim/bundle/Vundle.vim && git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
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
