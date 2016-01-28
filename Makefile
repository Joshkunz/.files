.PHONY: unlink link pre-push secret default
PWD := $(shell pwd)
HOME := $(shell echo $$HOME)

dotfiles-secret = .ssh/config

scripts = scripts

dotfiles-secret-dir = $(PWD)/dotfiles-secret
dotfiles-secret-file = secret.gpg
dotfiles-secret-local = $(addprefix $(dotfiles-secret-dir)/,$(dotfiles-secret))

dotfiles-dir = $(PWD)/dotfiles
dotfiles-local = $(shell find $(dotfiles-dir) -type f)
dotfiles-linked = $(patsubst $(dotfiles-dir)/%,$(HOME)/%,$(dotfiles-local))
dotfiles-linked += $(patsubst $(dotfiles-secret-dir)/%,$(HOME)/%,$(dotfiles-secret-local))

GPG-ARGS = --cipher-algo aes256

quiet-install-dotfile = @printf '    [LINK] %b -> %b\n' "$<" "$@";
quiet-gpg-enc = @printf '    [GPG] --encrypt %b\n' "$@";
quiet-gpg-dec = @printf '    [GPG] --decrypt %b\n' "$<";

default: link
#	@for file in $(dotfiles-secret-local); do echo $$file; done

link: $(dotfiles-linked)

pre-push: secret

unlink:
	@for file in $(dotfiles-linked); do \
		if test -L "$$file"; \
		then echo "    [UNLINK] $$file"; rm "$$file"; \
		fi; \
	done;

$(HOME)/%: $(dotfiles-dir)/%
	$(quiet-install-dotfile)$(scripts)/install-dotfile "$<" "$@"

$(HOME)/%: $(dotfiles-secret-dir)/%
	$(quiet-install-dotfile)$(scripts)/install-dotfile "$<" "$@"

$(dotfiles-secret-local): $(dotfiles-secret-file)
	$(quiet-gpg-dec)gpg --decrypt "$<" | tar -xz

_tarfile = $(patsubst %.gpg,%,$(dotfiles-secret-file))
secret: $(patsubst $(PWD)/%,%,$(dotfiles-secret-local))
	@printf '    [TAR] $(_tarfile)\n'; tar -cz $< > $(_tarfile)
	$(quiet-gpg-enc)gpg $(GPG-ARGS) --output $(dotfiles-secret-file) --symmetric $(_tarfile)
	@rm $(_tarfile)
