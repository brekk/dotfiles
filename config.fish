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
  figtest (pwd | lsnang -P "split(C.s) | map(trim) | last")
end

# let them know you're repping flipmode
set -gx EDITOR vim

alias tube="ytdl -o '{author.name} - {title}'"
alias sed="gsed"

alias xx="echo"

# alias cargo="$HOME/.cargo/bin/cargo"
# alias rustup="$HOME/.cargo/bin/rustup"
alias knock="~/work/binoculars/binocular.js"

alias wifi="osx-wifi-cli"

alias gpsup="git push -u origin (branch)"
function nname
  available $1 -r
end
