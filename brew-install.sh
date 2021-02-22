echo "installing..."
echo "fish shell - 🐟"
brew install fish
echo "starship theme - 🚀"
brew install starship
echo "node.js - ☊"
brew install node
echo "yarn - 🧶"
brew install yarn
echo "fnm - 🐡"
brew install fnm
mkdir -p ~/.config/fish/conf.d
echo "fnm env | source" > ~/.config/fish/conf.d/fnm.fish
echo "bat - 🦇"
brew install bat
echo "fd - 🔍"
brew install fd 
echo "exa - 🗂"
brew install exa
echo "ripgrep - 🔬"
brew install ripgrep
echo "thefuck - 💢"
brew install thefuck
echo "nvim - 📝"
brew install nvim
echo "graphviz - 📈"
brew install graphviz
