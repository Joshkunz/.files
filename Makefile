.PHONY: unlink kill link backup
PWD := $(shell pwd)

dotfiles = ~/.bashrc ~/.hgrc ~/.todo ~/.gitconfig \
		   ~/.vim ~/.vimrc ~/.weechat ~/.muttrc ~/.xmonad ~/.Xresources \
		   ~/.imapfilter

link: $(dotfiles)

~/.imapfilter: ./.imapfilter
	ln -s $(PWD)/.imapfilter ~/.imapfilter

~/.bashrc: ./.bashrc
	ln -s $(PWD)/.bashrc ~/.bashrc

~/.Xresources: ./.Xresources
	ln -s $(PWD)/.Xresources ~/.Xresources

~/.gitconfig: ./.gitconfig
	ln -s $(PWD)/.gitconfig ~/.gitconfig

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

~/.muttrc: ./.muttrc
	ln -s $(PWD)/.muttrc ~/.muttrc

~/.xmonad: ./.xmonad
	ln -s $(PWD)/.xmonad ~/.xmonad

unlink:
	for file in $(dotfiles); do if test -L \$file; then rm ~/\$file; fi; done;

kill:
	rm -rf $(dotfiles)

backup:
	if [ ! -d .backup ]; then mkdir .backup; fi
	find ~ -maxdepth 1 -type f -or -type d -name '.*' | xargs -I % cp -rv % $(PWD)/.backup
