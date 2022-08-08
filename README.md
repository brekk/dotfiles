# dotfiles for brekk

1. install `brew` and other curl-ables:
   ```bash
   ./curl-install.sh
   ```
2. install things with `brew`:
   ```bash
   ./brew-install.sh
   ```
3. now you have `fish`, make it the default shell:
   ```bash
   echo /usr/local/bin/fish | sudo tee -a /etc/shells
   chsh -s /usr/local/bin/fish
   ```
4. run the copier:
   ```shell
   fish link-and-copy.fish
   ```
5. set up vim-plug:
   ```shell
   fish vim-setup.fish
   ```
5. install all the fisher plugins:
   ```
   fish fisher-plugins.fish
   ```
6. open `~/.vimrc` and run `:PlugInstall`
