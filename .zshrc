# FOLLOW THE PATH

export PATH=$HOME/work/depot_tools:$HOME/bin:/usr/local/bin:$HOME/.cabal/bin:$HOME:$PATH

# antigen plugins

source ~/antigen.zsh

antigen bundle git
antigen bundle node
antigen bundle command-not-found
antigen bundle chrissicool/zsh-256color
antigen theme geometry-zsh/geometry
antigen apply

# ZSH Shell

export ZSH="/Users/brekkbockrath/.oh-my-zsh"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# ZSH plugins
plugins=(
  git
  osx
  node
  dotenv
  ssh-agent
)

source $ZSH/oh-my-zsh.sh

# thefuck is great, type "mpdir uh" then "fuck"

eval $(thefuck --alias)

# meta utilities

alias bashpro="vi ~/work/dotfiles/.zshrc"
alias bashsource="source ~/work/dotfiles/.zshrc"
alias bashcat="bat ~/.zshrc"
alias bashgat="bat ~/.zshrc | rg"

# the best editor on the planet

alias vivify="vi ~/work/dotfiles/.vimrc"

# the basics

alias ..="cd .."
alias ll="ls -Algp"

# git

alias branch="git branch | grep '*' | snang -P \"split(C._), last)\""

function flush {
  git push origin `branch` --force-with-lease
}

alias gs="git status"
alias gitpurty="git log --oneline --decorate --graph"

alias work="cd ~/work"

alias cat="bat --tabs=2"
alias ping="prettyping --nolegend"

# autojump - j for joy
[[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh

# fzf for fuzzy funnies
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# figlet is an important tool

function figfont {
  figlet -l | snang -P "split(C.n) | filter(I) | tackOn(z => Math.round((z.length - 1) * Math.random())) | ([l, i]) => l[i]"
}

function figtext {
  figfont | snang -P "z => 'figlet -f \'' + z + '\' \'$1\'' | exec"
}
function figtest {
  figlet -l | snang -P "split(C.n) | filter(I) | tackOn(z => Math.round((z.length - 1) * Math.random())) | ([l, i]) => l[i] | trace('picked:') | z => 'figlet -f \'' + z + '\' \'$1\'' | exec"
}

alias emma="emma --limit 20"

function spool {
  package-json $1 > src/data/$1.json
}

function replaceIn {
  # replaceIn ./src elements view
  LOC=${1:-./src}
  WHAT=$2
  WITH=$3
  KIND=${4:-\\*\\.js}
  # echo "find $LOC -name $KIND -exec sed -i '' -e "s/$WHAT/$WITH/g" {} \;"
  find $LOC -name $KIND -exec sed -i '' -e "s/$WHAT/$WITH/g" {} \;
}


alias d8=$HOME/work/v8/out.gn/x64.optdebug/d8
alias tick-processor=$HOME/work/v8/tools/mac-tick-processor
export D8_PATH=$HOME/work/v8/out.gn/x64.optdebug

# create-react-app && git init
function create {
  create-react-app $1
  cd $1
  echo "Φ fix git"
  rm -rf .git
  git init
  echo "Φ fix .gitignore"
  echo "*.swp" >> .gitignore
  echo "*.swo" >> .gitignore
  echo "Φ set readme"
  echo "\`\`\`" > README.md
  figtext $1 >> README.md
  echo "\`\`\`" >> README.md
  echo "# $1" >> README.md
  echo "Φ add sass"
  yarn add node-sass -D
  cd src
  mv App.css > App.scss
  mv index.css > index.scss
  sed "s/css/scss/g" App.js
  sed "s/css/scss/g" index.js
  echo "Φ swap logo.svg"
  cp ~/work/brekk.is/src/logos/brekk-is.svg logo.svg
  cd ..
  echo "Φ prepare initial commit"
  git add .gitignore
  git add src
  git add public
  git add package.json
  git add yarn.lock
  git add README.md
  echo "Φ celebrate"
  cat README.md
  yarn start
}
