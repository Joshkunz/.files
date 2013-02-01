.PHONY: unlink kill link backup
PWD := $(shell pwd)

dotfiles = ~/.bashrc ~/.gitconfig ~/.gitignore ~/.hgrc ~/.todo ~/.vim ~/.vimrc ~/.weechat

link: $(dotfiles)

~/.bashrc: ./.bashrc
	ln -s $(PWD)/.bashrc ~/.bashrc

~/.git: ./.git
	ln -s $(PWD)/.git ~/.git

~/.gitconfig: ./.gitconfig
	ln -s $(PWD)/.gitconfig ~/.gitconfig

~/.gitignore: ./.gitignore
	ln -s $(PWD)/.gitignore ~/.gitignore

~/.hgrc: ./.hgrc
	ln -s $(PWD)/.hgrc ~/.hgrc

~/.todo: ./.todo
	ln -s $(PWD)/.todo ~/.todo

~/.vim: ./.vim
	ln -s $(PWD)/.vim ~/.vim

~/.vimrc: ./.vimrc
	ln -s $(PWD)/.vimrc ~/.vimrc

~/.weechat: ./.weechat
	ln -s $(PWD)/.weechat ~/.weechat

~/Makefile: ./Makefile
	ln -s $(PWD)/Makefile ~/Makefile

unlink:
	for file in $(dotfiles); do if test -L \$file; then rm ~/\$file; fi; done;

kill:
	rm -rf $(dotfiles)

backup:
	if [ ! -d .backup ]; then mkdir .backup; fi
	find ~ -maxdepth 1 -type f -or -type d -name '.*' |     xargs -I % cp -rv % /Users/Joshkunz/code/dotfiles/.backup
