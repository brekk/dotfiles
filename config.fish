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
alias ll="ls -Algp"

# git

alias gs="git status"
alias branch="git branch | grep '*' | snang -P \"split(C._), last)\""

function figfont
  figlet -l | snang -P "split(C.n) | filter(I) | z => z[Math.floor(Math.random() * z.length]"
end

function figtext
  figfont | snang -P "z => 'figlet -f \'' + z + '\' \'$argv\'' | exec" | lolcat
end

function figtest
  figlet -l | snang -P "split(C.n) | filter(I) | tackOn(z => Math.round((z.length - 1) * Math.random())) | ([l, i]) => l[i] | trace('picked:') | z => 'figlet -f \'' + z + '\' \'$argv\'' | exec" | lolcat
end

# z is autojump
alias j='z'

# bat cat with wings
alias cat="bat --tabs=2"

# ping ping ping
alias ping="prettyping --nolegend"

function fish_greeting
  figtest "javascript"
end
