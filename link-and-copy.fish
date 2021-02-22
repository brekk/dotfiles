echo "symlinking... 🔗"
ln -s ~/work/dotfiles/config.fish ~/.config/fish/config.fish
ln -s ~/work/dotfiles/.vimrc ~/.vimrc
echo "copying... 👯‍♂️"
cp ~/work/dotfiles/nvim-init.vim ~/.config/nvim/init.vim
cp ~/work/dotfiles/starship.toml ~/.config/starship.toml
cp ~/work/dotfiles/.ripgreprc ~/.ripgreprc
