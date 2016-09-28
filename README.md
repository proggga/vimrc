# VIMRC
VIMRC for dummy int VIM (but useful for Admins/Developers)

installing:

```bash
git clone https://github.com/proggga/vimrc
cd vimrc
make install
make init
```

What does this script?
* download vim from github.com/vim/vim
* make install: for vim package -'configure', 'make' and 'make install' to your system (with most useful options)
* make init: make symlink to your ~/.vimrc file
* execute Vundle which download all plugins (list in .vimrc file, lines started from 'Plugin')
