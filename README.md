# configs

## Useful configs that I've developed over the years.

### Vim + Vundle
I've discovered plugins that I especially like, and some I especially don't. I crave useful keymappings, and spent some time developing a workflow that does well for me.
To Install:

1. git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
2. Copy the vimrc to ~/.vimrc. Launch `vim` and run `:PluginInstall`
3. Do some plugin-specific setup
  1. YouCompleteMe
    - `cd ~/.vim/bundle/YouCompleteMe`
    - `./install.py --clang-completer`
  2. jedi-vim
    - `cd ~/.vim/bundle/jedi-vim`
    - `submodule update --init`
  3. Tagbar
    - `apt-get install exuberant-ctags`
  4. vim-go
    - `apt-get install golang golang-go.tools glaze git`
    - Ensure you have your GOPATH set up correctly
    - Launch `vim` and run `:GoInstallBinaries`
  5. syntastic
    - `apt-get install pylint`



