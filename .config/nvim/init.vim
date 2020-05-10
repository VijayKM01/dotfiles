" Basic Settings
	let mapleader =","
	set shell=/usr/bin/zsh
	set number
	set wildmenu
	set wildmode=longest,list,full
	set autoindent
	set incsearch
	set hidden
	set termguicolors
	" setlocal spell spelllang=en_us
	set splitbelow splitright
	set lazyredraw
	au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif " Return to last edit position when opening files (You want this!)
	set fcs=eob:\ " Protecting trailing whitespace " Remove annoying tilde

" Some mappings and shortcuts

" vsplit file under cursor; C-w+f for hsplit (https://vi.stackexchange.com/questions/3364/open-filename-under-cursor-like-gf-but-in-a-new-tab-or-split)
	nnoremap <C-W><C-F> <C-W>vgf

" Spell check bindings
	inoremap <c-L> <c-g>u<Esc>[s1z=`]a<c-g>u
	inoremap <c-K> <c-g>u<esc>u[s2z=gi<c-g>u
	inoremap <c-J> <c-g>u<esc>u[s3z=gi<c-g>u

" Save a few keypresses
	map <C-h> <C-w>h
	map <C-l> <C-w>l
	map <leader>h <C-w>h:q<cr>
	map <leader>j <C-w>j:q<cr>
	map <leader>k <C-w>k:q<cr>
	map <leader>l <C-w>l:q<cr>
	nnoremap c "_c
	nnoremap <silent> Q @q
	map <C-t>k :tabr<cr>
	map <C-t>j :tabl<cr>
	map <C-t>h :tabp<cr>
	map <C-t>l :tabn<cr>

" Compile document, be it groff/LaTeX/markdown/etc.
	map <leader>C :w! \| !compiler <c-r>%<CR>
" Open corresponding .pdf/.html or preview
	map <leader>p :!opout <c-r>%<CR><CR>

" Runs a script that cleans out tex build files whenever I close out of a .tex file.
	autocmd VimLeave *.tex !texclear %

" Allow saving of files as sudo when I forgot to start vim using sudo.
	cmap w!! w !sudo tee > /dev/null %

" Insert new lines in Normal Mode
	nnoremap <leader>o mao<Esc>`a
	nnoremap <leader>O maO<Esc>`a

" Turn off search highlight
	nnoremap <leader><space> :nohlsearch<CR>

" Edit vimrc/zshrc and load vimrc bindings
	nnoremap <leader>ev :vsp ~/.config/nvim/init.vim<CR>
	nnoremap <leader>ez :vsp ~/.config/zsh/.zshrc<CR>
	nnoremap <leader>sv :source ~/.config/nvim/init.vim<CR>

" C compiling
	nnoremap <leader>co :!gcc -Wall -pedantic % -o %:r<CR>
	nnoremap <leader>cp :vsp<CR>:te<CR>a ./

" Open Terminal
	nnoremap <leader>t :te<CR>a

" Automatically deletes all trailing whitespace and newlines at end of file on save.
	autocmd BufWritePre * %s/\s\+$//e
	autocmd BufWritepre * %s/\n\+\%$//e

" Run xrdb whenever Xdefaults or Xresources are updated.
	autocmd BufWritePost *Xresources,*Xdefaults !xrdb %

" Turns off highlighting on the bits of code that are changed, so the line that is changed is highlighted but the actual text that has changed stands out on the line and is readable.
	if &diff
	    highlight! link DiffText MatchParen
	endif

" Sessions
	" let g:session_dir = '~/.config/nvim/vim-sessions'
	" let g:session#default_opener = 'edit'
	" let g:session#default_session = 'default'
	" exec 'nnoremap <Leader>ss :mks! ' . g:session_dir . '/*.vim<C-D><BS><BS><BS><BS><BS>'
	" exec 'nnoremap <Leader>sr :so ' . g:session_dir. '/*.vim<C-D><BS><BS><BS><BS><BS>'

" Plugins
call plug#begin('~/.local/share/nvim/plugged')

Plug 'mbbill/undotree'
Plug 'Shougo/deoplete.nvim'
Plug 'deoplete-plugins/deoplete-zsh'
Plug 'Shougo/neco-vim'
Plug 'Shougo/neco-syntax'

Plug 'lervag/vimtex'
Plug 'KeitaNakamura/tex-conceal.vim'
	set conceallevel=2
	let g:tex_conceal='abdmg'
	hi Conceal ctermbg=none

" Utilities
Plug 'ptzz/lf.vim'
Plug 'rbgrouleff/bclose.vim'

" Discord
Plug 'hugolgst/vimsence'


" Plug 'sirver/ultisnips'
	" let g:UltiSnipsExpandTrigger = '<tab>'
	" let g:UltiSnipsJumpForwardTrigger = '<tab>'
	" let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
	" let g:UltiSnipsSnippetDirectories = ['UltiSnips',$HOME.'/.config/nvim/UltiSnips']
	" let g:UltiSnipsSnippetsDir = $HOME."/.config/nvim/UltiSnips"
Plug 'lukelbd/vim-scrollwrapped'
Plug 'wlemuel/vim-tldr'
Plug '907th/vim-auto-save'
	let g:auto_save = 1
Plug 'scrooloose/nerdcommenter'
	let g:NERDSpaceDelims = 1
	let g:NERDCompactSexyComs = 1
	let g:NERDCustomDelimiters = { 'lf': { 'left': '#' } }	" Fix lfrc comments
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'

" Appearance
Plug 'chrisbra/Colorizer'
	nnoremap <leader>H :ColorToggle<cr>
Plug 'morhetz/gruvbox'		" Gruvbox
Plug 'iCyMind/NeoSolarized' 	" NeoSolarized
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Syntax highlighting
Plug 'VebbNix/lf-vim'
Plug 'cespare/vim-toml'
" Plug 'arakashic/chromatica.nvim'
	" let g:chromatica#libclang_path='/usr/lib/llvm-7.0/lib/libclang.so'
	" let g:chromatica#enable_at_startup=1

" Icons
Plug 'ryanoasis/vim-devicons'

call plug#end()

"Post-Plugin

" lf
	let g:lf_command_override = 'lf -command "set hidden"'
	let g:lf_replace_netrw = 1 " open lf when vim open a directory

" Deoplete
	let g:deoplete#enable_at_startup = 1

" Fuzzy Finder
	let g:fzf_layout = { 'window': '10new' }
	nnoremap <silent> <C-p> :FZF -m<cr>

" Better command history with q:
	command! CmdHist call fzf#vim#command_history({'right': '40'})
	nnoremap q: :CmdHist<CR>

" Change Colorscheme using fzf
	nnoremap <silent> <Leader>sc :call fzf#run({
	\   'source':
	\     map(split(globpath(&rtp, "colors/*.vim"), "\n"),
	\         "substitute(fnamemodify(v:val, ':t'), '\\..\\{-}$', '', '')"),
	\   'sink':    'colo',
	\   'options': '+m',
	\   'left':    30
	\ })<CR>

" Change buffers with fzf
	function! s:buflist()
	  redir => ls
	  silent ls
	  redir END
	  return split(ls, '\n')
	endfunction

	function! s:bufopen(e)
	  execute 'buffer' matchstr(a:e, '^[ 0-9]*')
	endfunction

	nnoremap <silent> <Leader><Enter> :call fzf#run({
	\   'source':  reverse(<sid>buflist()),
	\   'sink':    function('<sid>bufopen'),
	\   'options': '+m',
	\   'down':    len(<sid>buflist()) + 2
	\ })<CR>

" Custom statusline for fzf
	" autocmd! FileType fzf set laststatus=0 noshowmode noruler
	  " \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

	function! s:fzf_statusline()
		highlight fzf1 ctermfg=161 ctermbg=251
		highlight fzf2 ctermfg=23 ctermbg=251
		highlight fzf3 ctermfg=237 ctermbg=251
		setlocal statusline=%#fzf1#\ >\ %#fzf2#fz%#fzf3#f
	endfunction

	autocmd! User FzfStatusLine call <SID>fzf_statusline()

" UndoTree
	nnoremap <F5> :UndotreeToggle<cr>

" Vimtex Configuration
	let g:tex_flavor='latex'
	let g:vimtex_quickfix_latexlog = {'fix_paths':0}
	let g:vimtex_quickfix_mode=0
	let g:vimtex_compiler_progname = 'nvr'
	let g:vimtex_view_method='zathura'

" fzf integration for vimtex
	nnoremap <localleader>lt :call vimtex#fzf#run('cti', {'window': '50vnew'} )<cr>

" vimtex deoplete
	call deoplete#custom#var('omni', 'input_patterns', {
		\ 'tex': g:vimtex#re#deoplete
		\})
" Appearance
	let g:airline_powerline_fonts = 1
	let g:airline#extensions#tabline#enabled = 1

" ColorSchemes
	set background=dark
	" colorscheme gruvbox
	colorscheme NeoSolarized
	let g:airline_theme='base16_solarized'

	" hi Normal ctermbg=NONE guibg=NONE
	" hi NonText ctermbg=NONE guibg=NONE
	" hi EndOfBuffer ctermbg=NONE guibg=NONE
	" hi LineNr ctermbg=NONE guibg=NONE

" Goyo mapping and configuration
	map <leader>g :Goyo \| set linebreak<CR>
	map <leader>G :Goyo \| set nolinebreak<CR>
" Enable Goyo by default for mutt writting
	autocmd BufRead,BufNewFile /tmp/neomutt* let g:goyo_width=80
	autocmd BufRead,BufNewFile /tmp/neomutt* :Goyo | set linebreak
	autocmd BufRead,BufNewFile /tmp/neomutt* map ZZ :Goyo\|x!<CR>
	autocmd BufRead,BufNewFile /tmp/neomutt* map ZQ :Goyo\|q!<CR>
