call plug#begin('~/.vim/plugged')

Plug 'joshdick/onedark.vim'
Plug 'preservim/nerdtree'
Plug 'romgrk/barbar.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'jiangmiao/auto-pairs'
Plug 'itchyny/lightline.vim'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
Plug 'preservim/nerdcommenter'
Plug 'mattn/emmet-vim'

Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'evanleck/vim-svelte'

Plug 'honza/vim-snippets'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
Plug 'nvim-lua/plenary.nvim'

Plug 'dart-lang/dart-vim-plugin'
Plug 'neevash/awesome-flutter-snippets'
Plug 'akinsho/flutter-tools.nvim'

call plug#end()

function! LightLineCocError()
  let s:error_sign = get(g:, 'coc_status_error_sign')
  let info = get(b:, 'coc_diagnostic_info', {})
  if empty(info)
    return ''
  endif
  let errmsgs = []
  if get(info, 'error', 0)
    call add(errmsgs, s:error_sign . info['error'])
  endif
  return trim(join(errmsgs, ' '))
endfunction

function! LightLineCocWarn() abort
  let s:warning_sign = get(g:, 'coc_status_warning_sign')
  let info = get(b:, 'coc_diagnostic_info', {})
  if empty(info)
    return '' 
  endif
  let warnmsgs = []
  if get(info, 'warning', 0)
    call add(warnmsgs, s:warning_sign . info['warning'])
  endif
  return trim(join(warnmsgs, ' '))
endfunction

let g:lightline = {
  \ 'colorscheme': 'onedark',
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ],
  \             [ 'cocerror', 'cocwarn', 'readonly', 'filename', 'modified' ] ]
  \ },
  \ 'component_expand': {
  \   'cocerror': 'LightLineCocError',
  \   'cocwarn' : 'LightLineCocWarn',
  \ },
  \ 'component_type': {
  \   'cocerror': 'error',
  \   'cocwarn' : 'warning',  
  \ },
  \ }
let g:user_emmet_leader_key ='<C-Z>'
let g:indent_guides_auto_colors = 0
let g:indent_guides_enable_on_vim_startup = 1
let g:UltiSnipsExpandTrigger = '<Nop>'
let g:coc_snippet_next = '<TAB>'
let g:coc_snippet_prev = '<S-TAB>'
let g:NERDCreateDefaultMappings = 1
let g:Hexokinase_highlighters = [ 'backgroundfull' ]
let g:dart_format_on_save = 1
let g:dartfmt_options = ['--fix', '--line-length 120']

set noshowmode
set relativenumber
set splitbelow
set clipboard=unnamedplus
set termguicolors
set ts=2 sw=2 et

nnoremap <C-S-w>	      :BufferClose            <CR>
nnoremap <C-PageDown>   :BufferNext             <CR>
nnoremap <C-PageUp> 	  :BufferPrevious         <CR>
nnoremap <C-S-PageUp> 	:BufferMoveNext         <CR>
nnoremap <C-S-PageDown> :BufferMovePrevious     <CR>
nnoremap <C-h>		      :NERDTreeFocus          <CR>
nnoremap <C-e>		      :NERDTreeToggle         <CR>
nnoremap <C-l> 		      :wincmd w               <CR>
nnoremap <C-a>          :FlutterOutlineToggle   <CR>
nnoremap <C-t>          :new +resize7 term://zsh<CR>

imap <tab>  <Plug>  (coc-snippets-expand)
imap <expr> <C-j>   vsnip#expandable() ? '<Plug>(vsnip-expand)' : '<C-j>'

inoremap <expr>   <cr>    pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <expr>   <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr>   <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <silent> <expr>  <c-space> coc#refresh()

smap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)' : '<C-j>'

syntax enable
colorscheme onedark

filetype plugin on

lua << EOF
  require("flutter-tools").setup{}
EOF

autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg='#343746' ctermbg=3
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg='#44475A' ctermbg=4
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
autocmd User CocDiagnosticChange call lightline#update()
