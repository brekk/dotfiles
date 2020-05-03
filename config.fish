# \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
# ///////// \///// \\/////// \\/// \\/// \
# /// \\\\\\\\/// \\/// \\\\\\\/// \\/// \
# /////// \\\\/// \\\/////// \\///////// \
# /// \\\\\\\\/// \\\\\\\\/// \/// \\/// \
# /// \\\\\\\///// \\/////// \\/// \\/// \
# \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\


# fisher
if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end

# starship theme
eval (starship init fish)

# snang
alias lsnang="~/work/snang/snang.js"

# the fuck
thefuck --alias | source

# meta utilities

alias bashpro="vi ~/work/dotfiles/config.fish"
alias bashsource="source ~/work/dotfiles/config.fish"
alias bashcat="bat ~/.config/fish/config.fish"
alias bashgat="bat ~/.config/fish/config.fish | rg"

# the best editor on the planet

alias vivify="vi ~/work/dotfiles/.vimrc"

# the basics

alias ..="cd .."
alias ll="ls -Agplash"

# git

alias gs="git status"
alias branch="git branch | grep '*' | lsnang -P 'split(C._) | last'"
alias gitpurty="git log --oneline --decorate --graph"
alias flush="git push --set-upstream origin $branch --force-with-lease"

function figfont
  figlet -l | lsnang -P "split(C.n) | filter(I) | z => z[Math.floor(Math.random() * z.length)]"
end

function figtext
  figfont | lsnang -P "z => 'figlet -f \'' + z + '\' \'$argv\'' | exec" | lolcat
end

function figtest
  figlet -l | lsnang -P "split(C.n) | filter(I) | tackOn(z => Math.round((z.length - 1) * Math.random())) | ([l, i]) => l[i] | trace('picked:') | z => 'figlet -f \'' + z + '\' \'$argv\'' | exec" | lolcat
end

# z is autojump
alias j='z'

# bat cat with wings
alias cat="bat --tabs=2"

# ping ping ping
alias ping="prettyping --nolegend"

# yarn! offline!
alias jarn='yarn --prefer-offline'

function fish_greeting
  figtext (pwd | lsnang -P "split(C.s) | map(trim) | last")
end

# let them know you're repping flipmode
set -gx EDITOR vim

alias sed="gsed"

# alias cargo="$HOME/.cargo/bin/cargo"
# alias rustup="$HOME/.cargo/bin/rustup"
alias knock="~/work/binoculars/binocular.js"

alias gpsup="git push -u origin (branch)"
function nname
  available $1 -r
end


# sssshhhhh, it's secure
# eval (ssh-agent -c)

# if test -z (pgrep ssh-agent)
#   eval "(ssh-agent -c)" >/dev/null
#   set -Ux SSH_AUTH_SOCK $SSH_AUTH_SOCK
#   set -Ux SSH_AGENT_PID $SSH_AGENT_PID
#   set -Ux SSH_AUTH_SOCK $SSH_AUTH_SOCK
# end
fish_ssh_agent

# byobu / tmux
# set BYOBU_PREFIX /usr/local

# yes captain
# starship init fish | source

# the fuck
# thefuck --alias | source

# meta utilities
if available tmux
  alias whodat="tmux ls"
  alias sup="tmux attach -t"
  alias peace="tmux detach"
end
if available bat
  alias cat="bat --tabs=2"
end
if available exa
  alias ls=exa
  alias ll='exa --all --long --header --grid --ignore-glob="*.un~|*node_modules|*.git*" --git-ignore'
else
  alias ll="ls -Agplash"
end

alias fishpro="vi ~/.config/fish/config.fish"
alias fishsource="source ~/.config/fish/config.fish"
alias fishbat="cat ~/.config/fish/config.fish"
alias fishgat="cat ~/.config/fish/config.fish | rg"
alias vivify="vi ~/work/dotfiles/.vimrc"

# old habits die hard

alias ..="cd .."

alias bashpro='fishpro'
alias bashsource='fishsource'
alias j="z" # never washed

# ripgrep
set -x RIPGREP_CONFIG_PATH /Users/bbockrath/.ripgreprc

# inimitable

alias gs="git status"
alias branch="git branch | grep '*' | snang -P 'split(C._) | last'"
alias gitpurty="git log --oneline --decorate --graph"
alias gpsup="git push -u origin (branch)"

# other languages

## javasc-- oh, gross
set JAVA_HOME /Library/Java/JavaVirtualMachines/adoptopenjdk-11.jdk/Contents/Home

## why would I ever want an infinite list?
set GHCUP_INSTALL_BASE_PREFIX = $HOME
set PATH $HOME/.cabal/bin $PATH
set PATH $HOME/.ghcup/bin $PATH

## make sure you have tetanus
source $HOME/.cargo/env


# fun

function figfont
  figlet -l | sort -R | head -1
end

function figtext
  figfont | xargs -I{} figlet -f "{}" $argv[1]
end

function figtest
  set TEST_FONT (figfont)
  echo "figlet -f \"$TEST_FONT\" $argv[1]"
  figlet -f "$TEST_FONT" $argv[1] | lolcat
end

function fish_greeting
  figtest (basename (pwd))
end

function fuckf5
  sudo cp /etc/hosts ~/hosts.bak
  sudo cp /etc/hosts-before-stupid-f5 /etc/hosts
end
