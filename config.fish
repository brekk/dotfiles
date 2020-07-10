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

# yes captain
starship init fish | source

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

set -gx EDITOR vim
alias vivify="vi ~/work/dotfiles/.vimrc"

# the basics

alias ..="cd .."

alias bashpro='fishpro'
alias bashsource='fishsource'
alias j="z" # never washed

# git

alias gs="git status"
alias branch="git branch | grep '*' | lsnang -P 'split(C._) | last'"
alias gitpurty="git log --oneline --decorate --graph"
alias flush="git push --set-upstream origin $branch --force-with-lease"
alias gpsup="git push -u origin (branch)"

# ping ping ping
alias ping="prettyping --nolegend"

alias sed="gsed"

# alias cargo="$HOME/.cargo/bin/cargo"
# alias rustup="$HOME/.cargo/bin/rustup"

function nname
  available $1 -r
end

fish_ssh_agent

# ripgrep
set -x RIPGREP_CONFIG_PATH ~/.ripgreprc

# other languages

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

# tmux
alias whodat="tmux ls"
alias yo="tmux new -s"
alias sup="tmux attach -t"
alias peace="tmux detach"

# standard tools
alias cat="bat --tabs=2"
alias ls=exa
alias ll='exa --all --long --header --grid --ignore-glob="*node_modules|*.git*|*.un~|*.swp" --git-ignore'

# ripgrep
set -x RIPGREP_CONFIG_PATH /Users/bbockrath/.ripgreprc

# other languages

## why would I ever want an infinite list?
set GHCUP_INSTALL_BASE_PREFIX = $HOME
set PATH $HOME/.cabal/bin $PATH
set PATH $HOME/.ghcup/bin $PATH

## make sure you have tetanus
source $HOME/.cargo/env

function testDeprecated
  npm i 2>&1 | rg 'deprecated' | tee deprecated.log
  figtext 'deprecated' | lolcat
end

function allRequires
  rg "require\(" | snang -P "split(C.n) | filter(I) | map(pipe(split(':'), slice(1, Infinity), nth(0), y => y.substr(y.indexOf('require') + 9, y.indexOf(')')) | replace(';', '') | replace(',', '') | z => { var a = z.indexOf(').'); return a > -1 ? z.slice(0, a) : z } | replace('\"', '') | replace(')', '') | z => z.indexOf('.') === 0 ? '~' + z.slice(z.lastIndexOf('/') + 1, Infinity) : z)) | uniq | filter(I) | sort((a, b) => a === b ? 0 : a > b ? 1 : -1) | j2"
end

alias xovi="xargs -o vi"

function griprep
  rg -l $argv[1] | uniq | xargs echo | xovi
end

alias stripColors="gsed -r \"s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g\""

function crumb --description 'leaves a trail of crumbs'
  tee last-run.log && cat last-run.log
end

function brb --description 'cd into a directory, execute a command, then cd back.'
  j $argv[1] && eval $argv[2..-1] && cd -
end
