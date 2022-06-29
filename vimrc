" ---------------------------
" Simple Configs
" ---------------------------
set number
set relativenumber

if has('nvim')
    set tabstop=4 shiftwidth=4 expandtab

    set splitbelow
    set splitright

    " CtrlP Configs
    let g:ctrlp_map = '<c-p>'
    let g:ctrlp_cmd = 'CtrlP'
    let g:ctrlp_custom_ignore = '\v(\.cache)$'
    let g:ctrlp_user_command =  ['.git', 'cd %s && git ls-files . -co --exclude-standard']

    " Color Scheme
    let g:airline_powerline_fonts = 1
    let g:airline_theme = 'powerlineish'

    colorscheme Tomorrow-Night

    " VimWiki Configs
    let g:vimwiki_list = [{'path': '~/vimwiki/',
                          \ 'syntax': 'markdown', 'ext': '.md'}]
    set nocompatible
    filetype plugin on
    syntax on

    " Autocomplete Configs
    let g:deoplete#enable_at_startup = 1
endif

" ---------------------------
" Plugins
" ---------------------------
if has('nvim')
    call plug#begin()

    " Core
    Plug 'ctrlpvim/ctrlp.vim'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'christoomey/vim-system-copy'

    " File Navigation
    Plug 'preservim/nerdtree'

    " Multiple Cursors
    Plug 'terryma/vim-multiple-cursors'

    " Kotlin
    Plug 'udalov/kotlin-vim'

    " Github
    Plug 'tpope/vim-fugitive'

    " Github copilot
    Plug 'github/copilot.vim'

    " Autocomplete
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

    " VimWiki
    Plug 'vimwiki/vimwiki'

    call plug#end()
endif

" ---------------------------
" Shortcuts
" ---------------------------

" Disable arrow keys
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
noremap! <Up> <Nop>
noremap! <Down> <Nop>
noremap! <Left> <Nop>
noremap! <Right> <Nop>

" Tabs Movement
nnoremap K :tabn<CR>
nnoremap J :tabN<CR>
nnoremap <C-t> :tabnew<CR>
nnoremap <C-w> :tabc<CR>

" Split Movement
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Fugitive/Mergetool
nnoremap gdh :diffget //2<CR>
nnoremap gdl :diffget //3<CR>

" NERDTree
nnoremap <leader>n :NERDTreeToggle<CR>

" Vimrc
map <leader>vm :tabnew $MYVIMRC<CR>
map <leader>sv :source $MYVIMRC<CR>

" Maximize Split
nnoremap <leader><Space> :call MaximizeToggle()<CR>
" nnoremap <C-W>o :call MaximizeToggle()<CR>
" nnoremap <C-W><C-O> :call MaximizeToggle()<CR>

function! MaximizeToggle()
  if exists("s:maximize_session")
    exec "source " . s:maximize_session
    call delete(s:maximize_session)
    unlet s:maximize_session
    let &hidden=s:maximize_hidden_save
    unlet s:maximize_hidden_save
  else
    let s:maximize_hidden_save = &hidden
    let s:maximize_session = tempname()
    set hidden
    exec "mksession! " . s:maximize_session
    only
  endif
endfunction
