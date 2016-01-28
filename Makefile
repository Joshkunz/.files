.PHONY: unlink kill link
PWD := $(shell pwd)
HOME := $(shell echo $$HOME)

scripts = scripts

dotfiles-dir = $(PWD)/dotfiles
dotfiles-local = $(shell find $(dotfiles-dir) -type f)
dotfiles-linked = $(patsubst $(dotfiles-dir)/%,$(HOME)/%,$(dotfiles-local))

all-config = $(dotfiles-linked)

$(HOME)/%: $(dotfiles-dir)/%
	@$(scripts)/install-dotfile "$<" "$@"

link: $(dotfiles-linked)
	@for file in $(dotfiles-linked); do echo $$file; done

unlink:
	for file in $(dotfiles-linked); do if test -L "$$file"; then rm "$$file"; fi; done;

kill:
	rm -rf $(dotfiles)
