# .files

This is a very basic method for synchronizing per-user configuration files
across machines. To use, copy your "dotfiles" in the `dotfiles` directory and
run `make link`. This will convert all of your current dot files into symbolic
links to files in the `dotfiles` directory. Then you can `git add` them to
the repository and push them onto a git hosting site, so they can be pulled by
you on another machine. You can see the `dotfiles` folder in this repository
for an example.

Files put into a `dotfiles-secret` directory will be tar-gzipped and encrypted
with a symmetric key (using gpg). This way, they can be safely put into a public
repository, but only those who know the password can `make link` them. This is good
for dot files that require plaintext passwords, or have sensitive information
(like ip addresses) in them. You can do `make NOSECRET=yes link` if you want to
skip unpacking secret dot files.
