" Load vim-plug
source ~/.config/nvim/plug.vim

" Load plugin directory
call plug#begin('~/.nvim/user-plugins')

" Load plugins
" see https://github.com/junegunn/vim-plug readme file for examples

" Plugins
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'triglav/vim-visual-increment'
Plug 'rust-lang/rust.vim'
Plug 'preservim/nerdtree'

Plug 'rust-lang/rust.vim'

Plug 'majutsushi/tagbar'
Plug 'vim-syntastic/syntastic'
" Plug 'ycm-core/YouCompleteMe'
Plug 'neoclide/coc.nvim'

Plug 'sakhnik/nvim-gdb'

Plug 'kien/ctrlp.vim'

" Initialize plugin system
call plug#end()

" load vim settings
source ~/.vimrc

