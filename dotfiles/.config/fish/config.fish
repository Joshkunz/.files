# Clear out the greeting.
set fish_greeting

# The current time in a 12 hour format
function 12-hour-time
    date +"%I:%M:%S"
end

function host-os
    uname -s
end

# Output's the entire path (no shortening) with the
# part that is the user's home directory replaced with ~
function full-pwd
    pwd | sed -e s!^(echo ~)!~!
end

# Outputs arguments [2...] in color 
# given in argument [1].
function color-text 
    set_color $argv[1]
    echo -n $argv[2..(count $argv)]
    set_color normal
end
    
function fish_prompt
    printf "%s (%s) %s:%s\n%s " \
        (12-hour-time) \
        (color-text white (hostname)) \
        (color-text red (whoami)) \
        (color-text 85e7ff (full-pwd)) \
        "><>"
end 

#### Key Bindings ####

# auto sourced function that holds keybindings. Keybindings
# must be set in this function to be used in the shell
function fish_user_key_bindings
    bind \cb backward-word
    bind \cf forward-word
end

#### Path Updates ####
# Grab out the bash-specific path modifications for rust.
set -l _bash_path (bash -c 'source ~/.cargo/env; env' | rg '^PATH=' | tail -c+6 | tr ":" \n)
set PATH $_bash_path $PATH
set PATH /usr/local/bin $PATH
set PATH /usr/local/sbin $PATH
set PATH ~/bin $PATH
set PATH ~/.local/bin $PATH
set PATH $HOME/opt/zig-linux-x86_64-0.4.0 $PATH
# set PATH ~/.cabal/bin $PATH
# set PATH /usr/texlive/2015/bin/x86_64-linux/ $PATH

# Add Linuxbrew environment
/home/linuxbrew/.linuxbrew/bin/brew shellenv | source

# Add OPAM environment variables
# opam config env | source

#eval set -x MANPATH (manpath | tr ':' ' ')

if test (host-os) = "Darwin"
    set PATH /Applications/Racket\ v6.3/bin $PATH
end

#### Aliases ####

alias ls "ls --color=auto -GFh"
alias ll "ls -la"

alias grep "grep --color"

alias weechat "weechat-curses"
alias irc "weechat"

alias irkt "racket -il xrepl"

if test (host-os) = "Darwin"
    alias vlc "vlcwrap"
end

alias blaze "bazel"

#### Exports ####

set -x LESS "-R"

set -x EDITOR vim
set -x PAGER less
set -x LANG "en_US.UTF-8"

set -x VACTIVATE_ENVS "$HOME/code/.virtualenvs"

# For PDF2Kindle
set -x PDF2KINDLE_FROM "joshkunz@me.com"
set -x PDF2KINDLE_KINDLE "joshkunz@kindle.com"
set -x PDF2KINDLE_SMTP_HOST "smtp.mail.me.com"
set -x PDF2KINDLE_SMTP_PORT "587"

# For hledger
set -x LEDGER_FILE "$HOME/money/journal.ledger"

# For ssh-agent
set -x SSH_AUTH_SOCK "$XDG_RUNTIME_DIR/ssh-agent.socket"

# OPAM autocomplete configuration
source /Users/Joshkunz/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true

#### Helper Functions ####

function vactivate
    source $VACTIVATE_ENVS/$argv[1]/bin/activate.fish
end
