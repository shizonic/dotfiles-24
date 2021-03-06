" general {{{

  " --- mappings {{{

    " ------- set mapleader to comma {{{
    let mapleader=","
    " ------- }}}
    " ------- map ; to : {{{
    nnoremap ; :
    vnoremap ; :
    " ------- }}}
    " ------- turn off F1 help shortcut {{{
    inoremap <F1> <nop>
    nnoremap <F1> <nop>
    vnoremap <F1> <nop>
    " ------- }}}
    " ------- turn off manual key {{{
    nnoremap K <nop>
    vnoremap K <nop>
    " ------- }}}
    " ------- never use ZZ, too dangerous {{{
    nnoremap ZZ <nop>
    " ------- }}}
    " ------- disable <C-A>, interferes with tmux prefix {{{
    noremap <C-A> <nop>
    inoremap <C-A> <nop>
    " ------- }}}
    " ------- Ctrl-Q to quit {{{
    nnoremap <C-Q> :qall<CR>
    cnoremap <C-Q> <C-C>:qall<CR>
    inoremap <C-Q> <C-O>:qall<CR>
    vnoremap <C-Q> <ESC>:qall<CR>
    onoremap <C-Q> <ESC>:qall<CR>
    tnoremap <C-Q> <C-\><C-N>:qall<CR>
    " ------- }}}

  " --- }}}

  " --- directories {{{

    " ------- store backups in the same directory {{{
    set backupdir=~/.config/nvim/.backups
    " ------- }}}
    " ------- store swap files in the same directory {{{
    set directory=~/.config/nvim/.swaps
    " ------- }}}
    " ------- store undo files in the same directory {{{
    set undodir=~/.config/nvim/.undo
    " ------- }}}
    " ------- make directories if necessary {{{
    if !isdirectory(expand(&backupdir))
      call mkdir(expand(&backupdir), "p")
    endif
    if !isdirectory(expand(&directory))
      call mkdir(expand(&directory), "p")
    endif
    if !isdirectory(expand(&undodir))
      call mkdir(expand(&undodir), "p")
    endif
    " ------- }}}

  " --- }}}

  " --- file {{{

    " ------- use utf-8 without BOM {{{
    set encoding=utf-8
    set fileencoding=utf-8
    set termencoding=utf-8
    set nobomb
    " ------- }}}
    " ------- read unix, dos and mac file formats {{{
    set fileformats=unix,dos,mac
    " ------- }}}
    " ------- flush file to disk after writing for protection against data loss {{{
    set nofsync
    " ------- }}}
    " ------- write swap file every N characters {{{
    set updatecount=20
    " ------- }}}
    " ------- never write or update the contents of any buffer unattended {{{
    set noautowrite
    set noautowriteall
    set noautoread
    " ------- }}}
    " ------- greatly restrict local .vimrc and .exrc files {{{
    set secure
    " ------- }}}
    " ------- disable modelines, use securemodelines.vim instead {{{
    set nomodeline
    let g:secure_modelines_allowed_items = [
                \ "expandtab", "et", "noexpandtab", "noet",
                \ "filetype", "ft",
                \ "foldlevel", "fdl",
                \ "foldmarker", "fmr",
                \ "foldmethod", "fdm",
                \ "rightleft", "rl", "norightleft", "norl",
                \ "shiftwidth", "sw",
                \ "softtabstop", "sts",
                \ "tabstop", "ts",
                \ "textwidth", "tw",
                \ "wrap", "nowrap"
                \ ]
    " ------- }}}
    " ------- prefer blowfish2 encryption method {{{
    silent! set cryptmethod=blowfish2
    " ------- }}}

  " --- }}}

  " --- viminfo {{{

    " ------- configure viminfo then read from it {{{
    set viminfo='100,<50,s10,h,!
    "           |    |   |   | |
    "           |    |   |   | +--- Save and restore all-uppercase global variables
    "           |    |   |   +----- Don't restore hlsearch on startup
    "           |    |   +--------- Exclude registers greater than N Kb
    "           |    +------------- Keep N lines for each register
    "           +------------------ Keep marks for N files
    rviminfo
    " ------- }}}

  " --- }}}

  " --- mouse {{{

    " ------- turn on mouse in all modes {{{
    if has('mouse')
      set mouse=a
      set mousemodel=popup_setpos
    endif
    " ------- }}}

  " --- }}}

" }}}


" load plugin manager {{{

if filereadable(expand('~/.config/nvim/plugs.vim'))
  source ~/.config/nvim/plugs.vim
endif

" }}}


" load functions {{{

if filereadable(expand('~/.config/nvim/functions.vim'))
  source ~/.config/nvim/functions.vim
endif

" }}}


" display {{{

  " --- system display settings {{{

    " ------- intro screen {{{
    " hide intro screen, use all abbreviations, omit redundant messages
    set shortmess=aIoO
    " ------- }}}
    " ------- descriptive window title {{{
    set title
    if has('title') && (has('gui_running') || &title)
      set titlestring=
      set titlestring+=%f\                                              " File name
      set titlestring+=%h%m%r%w                                         " Flags
      set titlestring+=\ \|\ %{v:progname}                              " Program name
      set titlestring+=\ \|\ %{substitute(getcwd(),\ $HOME,\ '~',\ '')} " Working directory
    endif
    " ------- }}}
    " ------- do not redraw screen when executing macros {{{
    set lazyredraw
    " ------- }}}
    " ------- insert N pixel lines between characters {{{
    set linespace=1
    " ------- }}}
    " ------- don't clear screen when nvim closes {{{
    set t_ti= t_te=
    " ------- }}}
    " ------- fix background color bleed in tmux / screen {{{
    set t_ut=""
    " ------- }}}
    " ------- turn off syntax coloring of long lines {{{
    set synmaxcol=1024
    " ------- }}}

  " --- }}}

  " --- terminal display settings {{{

    " change the cursor shape to a vertical bar while in insert mode
    "let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

    " assume the host terminal supports 24 bit colors
    "let $NVIM_TUI_ENABLE_TRUE_COLOR=1

    " ------- colorscheme {{{
    set background=dark
    if ($TERM =~ "256" || &t_Co >= 256 || $COLORTERM == "gnome-terminal")
      \ || has('gui_running')
      set t_Co=256
      "let g:seoul256_background = 233
      "colorscheme seoul256
      colorscheme jellyx
    elseif $TERM == "linux" || $TERM == "tmux" || $TERM == "screen"
      colorscheme miro8
      highlight clear Pmenu
      highlight Pmenu ctermfg=7 ctermbg=0
    endif
    " ------- }}}

  " --- }}}

  " --- gui display settings {{{

    if has('gui_running')
      " no menu bar
      set guioptions-=m
      " no toolbar
      set guioptions-=T
      " no right-hand scrollbar
      set guioptions-=r
      set guioptions-=R
      " no left-hand scrollbar
      set guioptions-=l
      set guioptions-=L
      " use console style tabbed interface
      set guioptions-=e
      " use console dialogs instead of popups
      set guioptions+=c
      " use lightline-compatible monaco
      set guifont=Monaco\ for\ Powerline\ 16
      " allow gvim window to occupy whole screen
      set guiheadroom=0
      " set normal mode cursor to unblinking Cursor highlighted block
      set guicursor+=n:blinkon0-block-Cursor
      " set insert and command line mode cursor to 25% width unblinking iCursor highlighted block
      set guicursor+=i-c:blinkon0-ver25-iCursor
      " set visual mode cursor to unblinking vCursor highlighted block
      set guicursor+=v:blinkon0-block-vCursor
      " set replace mode cursor to unblinking rCursor highlighted block
      set guicursor+=r:blinkon0-block-rCursor
      " set operator pending mode cursor to 50% height unblinking oCursor highlighted block
      set guicursor+=o:blinkon0-hor50-oCursor
      " no visual bell
      if has('autocmd')
        augroup errorbells
          autocmd!
          autocmd GUIEnter * set vb t_vb=
        augroup END
      endif
      " resize font
      noremap <silent> <M--> :Smaller<CR>
      noremap <silent> <M-+> :Bigger<CR>
      " paste selection with <S-Ins>
      inoremap <S-Insert> <MiddleMouse>
      cnoremap <S-Insert> <MiddleMouse>
    endif

  " --- }}}

  " --- statusline {{{

    " ------- always show statusline {{{
    set laststatus=2
    " ------- }}}
    " ------- don't show active mode on last line {{{
    set noshowmode
    " ------- }}}

  " --- }}}

  " --- highlighting {{{

    " ------- searches {{{
    highlight clear Search
    highlight Search term=bold cterm=bold ctermfg=0 ctermbg=191 gui=bold guifg=black guibg=#DFFF5F
    highlight clear IncSearch
    highlight IncSearch term=bold cterm=bold ctermfg=0 ctermbg=214 gui=bold guifg=black guibg=#FFAF00
    " ------- }}}
    " ------- searches (seoul256) {{{
    "highlight clear Search
    "highlight Search term=bold cterm=bold ctermfg=0 ctermbg=116 gui=bold guifg=black guibg=#97DDDF
    "highlight clear IncSearch
    "highlight IncSearch term=bold cterm=bold ctermfg=0 ctermbg=217 gui=bold guifg=black guibg=#FFBFBD
    " ------- }}}
    " ------- matching parens {{{
    highlight clear MatchParen
    highlight MatchParen term=bold,NONE cterm=bold,NONE ctermfg=179 gui=bold,NONE guifg=#D7AF5F
    " ------- }}}
    " ------- cursor {{{
    highlight clear Cursor
    highlight Cursor guifg=black guibg=gray
    highlight clear iCursor
    highlight iCursor guifg=white guibg=#FFFFAF
    highlight clear vCursor
    highlight vCursor guifg=white guibg=#5F5F87
    highlight clear rCursor
    highlight rCursor guifg=black guibg=#CF6A4C
    highlight clear oCursor
    highlight oCursor guifg=black guibg=gray
    " ------- }}}
    " ------- cursor (seoul256) {{{
    "highlight clear Cursor
    "highlight Cursor guifg=black guibg=gray
    "highlight clear iCursor
    "highlight iCursor guifg=white guibg=#FFFFAF
    "highlight clear vCursor
    "highlight vCursor guifg=white guibg=#5FAFAF
    "highlight clear rCursor
    "highlight rCursor guifg=black guibg=#DF005F
    "highlight clear oCursor
    "highlight oCursor guifg=black guibg=gray
    " ------- }}}
    " ------- cursor line and column (seoul256) {{{
    "highlight clear CursorLine
    "highlight CursorLine term=NONE cterm=NONE ctermbg=234 gui=NONE guibg=#1C1C1C
    "highlight clear CursorColumn
    "highlight CursorColumn term=NONE cterm=NONE ctermbg=234 gui=NONE guibg=#1C1C1C
    "highlight clear ColorColumn
    "highlight ColorColumn term=NONE cterm=NONE ctermbg=95 gui=NONE guibg=#875F5F
    " ------- }}}
    " ------- error, warning and mode messages {{{
    highlight clear Error
    highlight Error ctermfg=gray ctermbg=NONE guifg=gray guibg=NONE
    highlight clear ErrorMsg
    highlight ErrorMsg ctermfg=gray ctermbg=NONE guifg=gray guibg=NONE
    highlight clear WarningMsg
    highlight ErrorMsg ctermfg=gray ctermbg=NONE guifg=gray guibg=NONE
    highlight clear ModeMsg
    highlight ModeMsg ctermfg=gray ctermbg=NONE guifg=gray guibg=NONE
    " ------- }}}
    " ------- question and more messages {{{
    highlight clear Question
    highlight Question term=standout ctermfg=179 gui=bold guifg=#D7AF5F
    highlight clear MoreMsg
    highlight MoreMsg term=bold cterm=bold ctermfg=179 gui=bold guifg=#D7AF5F
    " ------- }}}
    " ------- directories {{{
    highlight clear Directory
    highlight Directory term=bold cterm=bold ctermfg=110 gui=bold guifg=#87AFD7
    " ------- }}}
    " ------- spelling {{{
    highlight clear SpellBad
    highlight SpellBad term=standout ctermfg=1 term=underline cterm=underline
    highlight clear SpellCap
    highlight SpellCap term=underline cterm=underline
    highlight clear SpellRare
    highlight SpellRare term=underline cterm=underline
    highlight clear SpellLocal
    highlight SpellLocal term=underline cterm=underline
    " ------- }}}
    " ------- conflict markers {{{
    match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'
    " ------- }}}

  " --- }}}

  " --- listchars {{{

    " ------- don't show listchars by default {{{
    set nolist
    set listchars+=extends:›
    set listchars+=precedes:‹
    set listchars+=nbsp:·
    set listchars+=trail:·
    " ------- }}}

  " --- }}}

" }}}


" editing {{{

  " --- spacing and tabs {{{

    " ------- copy indent from current line when starting a new line {{{
    set autoindent
    " ------- }}}
    " ------- set the width of a <Tab> character to N {{{
    set tabstop=2
    " ------- }}}
    " ------- use spaces instead of <Tab> characters {{{
    set expandtab
    " ------- }}}
    " ------- indent/dedent by N on <Tab> / <BS> {{{
    set softtabstop=2
    " ------- }}}
    " ------- indent/dedent by N on <Tab> / <BS> in normal mode (>, <) {{{
    set shiftwidth=2
    " ------- }}}
    " ------- round indent to multiple of shiftwidth {{{
    set shiftround
    " ------- }}}
    " ------- <Tab> in front of a line inserts blanks according to shiftwidth {{{
    set smarttab
    " ------- }}}

  " --- }}}

  " --- cursor {{{

    " ------- enable virtual edit in visual block mode {{{
    set virtualedit=block
    " ------- }}}
    " ------- don't highlight the screen line or column {{{
    set nocursorline nocursorcolumn
    " ------- }}}
    " ------- number of screen lines around cursor {{{
    set scrolloff=8
    set sidescrolloff=16
    set sidescroll=1
    " ------- }}}
    " ------- always keep cursor in the same column if possible {{{
    set nostartofline
    " ------- }}}
    " ------- don't move back cursor one position when exiting insert mode {{{
    augroup cursorpos
      autocmd!
      autocmd InsertEnter * let CursorColumnI = col('.')
      autocmd CursorMovedI * let CursorColumnI = col('.')
      autocmd InsertLeave * if col('.') != CursorColumnI | call cursor(0, col('.')+1) | endif
    augroup END
    " ------- }}}
    " ------- return to last edit position {{{
    augroup cursormem
      autocmd!
      autocmd BufReadPost *
        \ if line("'\"") > 1 && line("'\"") <= line("$") |
        \   exe "normal! g`\"" |
        \ endif
    augroup END
    " ------- }}}

  " --- }}}

  " --- windows {{{

    " ------- vertical diffsplit by default {{{
    set diffopt+=vertical
    " ------- }}}
    " ------- split windows below and to the right of the current {{{
    set splitright
    set splitbelow
    " ------- }}}
    " ------- allow no height, no width windows {{{
    set winminheight=0
    set winminwidth=0
    " ------- }}}
    " ------- readjust window sizing {{{
    augroup autoresize
      autocmd!
      autocmd VimResized * :wincmd =
    augroup END
    " ------- }}}

  " --- }}}

  " --- buffers {{{

    " ------- switch buffers without saving {{{
    set hidden
    " ------- }}}
    " ------- switching buffers {{{
    set switchbuf=useopen,usetab,newtab
    "             |       |      |
    "             |       |      +-------- Prefer opening quickfix windows in new tabs
    "             |       +--------------- Consider windows in other tab pages wrt useopen
    "             +----------------------- Jump to the first open window that contains the specified buffer if there is one
    " ------- }}}

  " --- }}}

  " --- lines {{{

    " ------- visually break lines {{{
    set wrap
    " ------- }}}
    " ------- wrap on these chars {{{
    set whichwrap+=<,>,[,]
    " ------- }}}
    " ------- break lines at sensible place {{{
    set linebreak
    " ------- }}}
    " ------- don't autowrap text as it's being inserted {{{
    set textwidth=0
    " ------- }}}
    " ------- indicate wrapped lines {{{
    set showbreak=⁍
    " ------- }}}

  " --- }}}

  " --- line numbers {{{

    " ------- show the line number in front of each line {{{
    set number
    " ------- }}}
    " ------- minimum number of columns to use for the line number {{{
    set numberwidth=1
    " ------- }}}

  " --- }}}

  " --- feedback {{{

    " ------- timeout settings {{{
    set timeout
    set nottimeout
    set timeoutlen=1000
    set ttimeoutlen=50
    " ------- }}}
    " ------- no annoying error noises {{{
    set noerrorbells
    set vb t_vb=
    " ------- }}}
    " ------- use a dialog when an operation has to be confirmed {{{
    set confirm
    " ------- }}}
    " ------- don't show us the command we're typing {{{
    set noshowcmd
    " ------- }}}
    " ------- always report the number of lines changed {{{
    set report=0
    " ------- }}}

  " --- }}}

  " --- search {{{

    " ------- don't wrap searches around the end of the file {{{
    set nowrapscan
    " ------- }}}
    " ------- incremental search, highlight search {{{
    set incsearch
    set hlsearch
    " ------- }}}
    " ------- ignore case in search patterns {{{
    set ignorecase
    " ------- }}}
    " ------- override ignorecase option if search pattern contains upper case characters {{{
    set smartcase
    " ------- }}}
    " ------- adjust the case of the match depending on the typed text {{{
    set infercase
    " ------- }}}
    " ------- turn off any existing search {{{
    if has('autocmd')
      augroup searchhighlight
        autocmd!
        autocmd VimEnter * nohls
      augroup END
    endif
    " ------- }}}
    " ------- use ag/pt/ack for grepping if available {{{
    if executable('ag')
      set grepprg=ag\ --nogroup\ --nocolor\ --hidden\ --smart-case\ --skip-vcs-ignores\ --path-to-agignore=$HOME/.agignore
    elseif executable('pt')
      set grepprg=pt\ --nogroup\ --nocolor\ --hidden\ --nocolor\ -e
    elseif executable('ack')
      set grepprg=ack\ --nogroup\ --nocolor\ --nopager
    endif
    " ------- }}}

  " --- }}}

  " --- completion {{{

    " ------- turn on wildmenu completion {{{
    set wildmenu
    set wildmode=list:longest,full
    " ------- }}}
    " ------- disable some filetypes for completion {{{
    set wildignore+=*.o,*.obj,*.dll,*.pyc
    set wildignore+=*~,*.DS_Store
    set wildignore+=.git/*,.subgit/*,.hg/*,.subhg/*,.svn/*
    set wildignore+=*.gif,*.jpg,*.jpeg,*.png
    set wildignore+=*.class,*.jar
    set wildignore+=*.beam
    set wildignore+=*.hi,*.p_hi,*.p_o
    " ------- }}}
    " ------- give following files lower priority {{{
    set suffixes+=.bak,~,.swp,.o,.info,.aux
    set suffixes+=.log,.dvi,.bbl,.blg,.brf
    set suffixes+=.cb,.ind,.idx,.ilg,.inx
    set suffixes+=.out,.toc,CVS/,tags
    " ------- }}}

  " --- }}}

  " --- convenience {{{

    " ------- generous backspacing {{{
    set backspace=2
    " ------- }}}
    " ------- jump between the following characters that form pairs {{{
    set matchpairs+=<:>
    set matchpairs+=«:»
    set matchpairs+=「:」
    " ------- }}}
    " ------- don't highlight matching parens {{{
    set noshowmatch
    " ------- }}}
    " ------- automatic formatting options {{{
    set formatoptions=
    set formatoptions+=r " Automatically insert the current comment leader after <Enter> in insert mode
    set formatoptions+=o " Automatically insert the current comment leader after 'o' or 'O' in normal mode
    set formatoptions+=q " Allow formatting of comments with gq
    set formatoptions+=n " Recognize numbered lists when formatting text
    set formatoptions+=2 " Use the indent of the second line of a paragraph for the rest of the paragraph instead of the first
    set formatoptions+=l " Don't break long lines in insert mode
    set formatoptions+=1 " Don't break a line after a one-letter word
    set formatoptions+=j " Remove comment leader when joining two comments
    " ------- }}}
    " ------- do not consider octal numbers for C-A/C-X {{{
    set nrformats-=octal
    " ------- }}}

  " --- }}}

  " --- history and undo {{{

    " ------- save undo history to an undo file {{{
    set undofile
    " ------- }}}
    " ------- allow N number of changes to be undone {{{
    set undolevels=500
    " ------- }}}
    " ------- store N previous vim commands and search patterns {{{
    set history=500
    " ------- }}}

  " --- }}}

  " --- folds {{{

    " ------- triple matching curly braces form a fold {{{
    set foldmethod=marker
    " ------- }}}
    " ------- higher numbers close fewer folds, 0 closes all folds {{{
    set foldlevel=99
    " ------- }}}
    " ------- automatically open folds on these commands {{{
    set foldopen=insert,mark,percent,tag,undo
    " ------- }}}
    " ------- deepest fold is 3 levels {{{
    set foldnestmax=3
    " ------- }}}

  " --- }}}

  " --- sessions {{{

    " ------- save and restore session data {{{
    set sessionoptions+=blank,buffers,curdir,folds
    "                   |     |       |      |
    "                   |     |       |      +------- Manually created folds, opened/closed folds, local fold options
    "                   |     |       +-------------- The current directory
    "                   |     +---------------------- Hidden and unloaded buffers
    "                   +---------------------------- Empty windows
    set sessionoptions+=globals,help,localoptions,options
    "                   |       |    |            |
    "                   |       |    |            +--------- All options and mappings, global values for local options
    "                   |       |    +---------------------- Options and mappings local to a window or buffer
    "                   |       +--------------------------- The help window
    "                   +----------------------------------- Global variables that start with an uppercase letter and contain at least one lowercase letter
    set sessionoptions+=resize,tabpages,winpos,winsize
    "                   |      |        |      |
    "                   |      |        |      +--------- Window sizes
    "                   |      |        +---------------- Position of the whole Vim window
    "                   |      +------------------------- All tab pages
    "                   +-------------------------------- Size of the Vim window
    " ------- }}}

  " --- }}}

" }}}


" shortcuts {{{

  " --- display {{{

    " ------- toggle showcmd {{{
    nnoremap <silent> <leader>sc :set showcmd!<CR>
    " ------- }}}

  " --- }}}

  " --- selecting {{{

    " ------- bind escape key {{{
    call arpeggio#load()
    Arpeggio noremap jk <ESC>
    Arpeggio inoremap jk <ESC>
    Arpeggio cnoremap jk <C-C>
    "Arpeggio tnoremap jk <ESC>
    Arpeggio noremap kj <ESC>
    Arpeggio inoremap kj <ESC>
    Arpeggio cnoremap kj <C-C>
    "Arpeggio tnoremap kj <ESC>
    " ------- }}}
    " ------- visually select the text that was last edited/pasted {{{
    nnoremap <expr> gV '`[' . strpart(getregtype(), 0, 1) . '`]'
    " ------- }}}
    " ------- preserve selection when indenting {{{
    vnoremap > >gv
    vnoremap < <gv
    nnoremap > >>
    nnoremap < <<
    " ------- }}}

  " --- }}}

  " --- pasting {{{

    " ------- yank to end of line {{{
    noremap Y y$
    " ------- }}}
    " ------- copy to clipboard {{{
    vnoremap <leader>y "+yy<ESC>
    nnoremap <leader>y "+y
    nnoremap <leader>Y "+y$
    " ------- }}}
    " ------- paste from clipboard {{{
    noremap <leader>p "+p
    noremap <leader>P "+P
    " ------- }}}
    " ------- toggle paste mode {{{
    set pastetoggle=<F2>
    inoremap <silent> <F2> <C-O>:set paste!<CR>
    nnoremap <silent> <F2> :set paste!<CR>
    vnoremap <silent> <F2> :set paste!<CR>
    " ------- }}}

  " --- }}}

  " --- movement {{{

    " ------- move between beginning and end of line {{{
    nnoremap H ^
    vnoremap H ^
    nnoremap L g_
    vnoremap L g_
    " ------- }}}
    " ------- move to middle of current line {{{
    nnoremap <expr> - (strlen(getline("."))/2)."<Bar>"
    " ------- }}}
    " ------- move to last change {{{
    nnoremap gI `.
    " ------- }}}
    " ------- fix <PageUp> and <PageDown> normal mode with folds {{{
    noremap <PageUp> <C-U>
    noremap <PageDown> <C-D>
    " ------- }}}
    " ------- scroll four lines at a time {{{
    nnoremap <C-E> 4<C-E>
    nnoremap <C-Y> 4<C-Y>
    " ------- }}}

  " --- }}}

  " --- lines {{{

    " ------- toggle line wrap {{{
    noremap <silent> <F3> :set nowrap!<CR>
    inoremap <silent> <F3> <C-O>:set nowrap!<CR>
    vnoremap <silent> <F3> <ESC>:set nowrap!<CR>gv
    " ------- }}}
    " ------- toggle line numbers {{{
    nnoremap <silent> <F4> :NumbersToggle<CR>
    inoremap <silent> <F4> <C-O>:NumbersToggle<CR>
    vnoremap <silent> <F4> <ESC>:NumbersToggle<CR>gv
    " ------- }}}

  " --- }}}

  " --- cursor {{{

    " ------- toggle line and column highlighting {{{
    noremap <silent> <F5> :set nocursorline! nocursorcolumn!<CR>
    inoremap <silent> <F5> <C-O>:set nocursorline! nocursorcolumn!<CR>
    vnoremap <silent> <F5> <ESC>:set nocursorline! nocursorcolumn!<CR>gv
    tnoremap <silent> <F5> <C-\><C-N>:set nocursorline! nocursorcolumn!<CR>
    " ------- }}}
    " ------- toggle virtualedit=all {{{
    nnoremap <silent> <leader><leader>v :let &virtualedit=&virtualedit=="block" ? "all" : "block" <Bar> set virtualedit?<CR>
    " ------- }}}

  " --- }}}

  " --- windows {{{

    " ------- navigation and repositioning {{{
    " map alt-[h,j,k,l,=,_,|] to resizing a window split
    " map alt-[s,v] to horizontal and vertical split respectively
    " map alt-[N,P] to moving to next and previous window respectively
    " map alt-[H,J,K,L] to repositioning a window split
    nnoremap <silent> <M-h> :<C-U>ObviousResizeLeft<CR>
    nnoremap <silent> <M-j> :<C-U>ObviousResizeDown<CR>
    nnoremap <silent> <M-k> :<C-U>ObviousResizeUp<CR>
    nnoremap <silent> <M-l> :<C-U>ObviousResizeRight<CR>
    tnoremap <silent> <M-h> <C-\><C-N>:<C-U>ObviousResizeLeft<CR>
    tnoremap <silent> <M-j> <C-\><C-N>:<C-U>ObviousResizeDown<CR>
    tnoremap <silent> <M-k> <C-\><C-N>:<C-U>ObviousResizeUp<CR>
    tnoremap <silent> <M-l> <C-\><C-N>:<C-U>ObviousResizeRight<CR>
    nnoremap <silent> <M-=> <C-W>=
    nnoremap <silent> <M-_> <C-W>_
    nnoremap <silent> <M-\|> <C-W>\|
    tnoremap <silent> <M-=> <C-\><C-N><C-W>=
    tnoremap <silent> <M-_> <C-\><C-N><C-W>_
    tnoremap <silent> <M-\|> <C-\><C-N><C-W>\|
    nnoremap <silent> <M-s> :split<CR>
    nnoremap <silent> <M-v> :vsplit<CR>
    tnoremap <silent> <M-s> <C-\><C-N>:split<CR>
    tnoremap <silent> <M-v> <C-\><C-N>:vsplit<CR>
    nnoremap <silent> <M-N> <C-W><C-W>
    nnoremap <silent> <M-P> <C-W><S-W>
    tnoremap <silent> <M-N> <C-\><C-N><C-W><C-W>
    tnoremap <silent> <M-P> <C-\><C-N><C-W><S-W>
    nnoremap <silent> <M-H> <C-W>H
    nnoremap <silent> <M-J> <C-W>J
    nnoremap <silent> <M-K> <C-W>K
    nnoremap <silent> <M-L> <C-W>L
    tnoremap <silent> <M-H> <C-\><C-N><C-W>H
    tnoremap <silent> <M-J> <C-\><C-N><C-W>J
    tnoremap <silent> <M-K> <C-\><C-N><C-W>K
    tnoremap <silent> <M-L> <C-\><C-N><C-W>L
    " ------- }}}
    " ------- create a split on the given side {{{
    nnoremap <leader>swh :leftabove vsp<CR>
    nnoremap <leader>swl :rightbelow vsp<CR>
    nnoremap <leader>swk :leftabove sp<CR>
    nnoremap <leader>swj :rightbelow sp<CR>
    " ------- }}}
    " ------- scroll specified file simultaneously in vsplit window {{{
    nnoremap <leader>sb :SplitScrollSpecified<space>
    " ------- }}}
    " ------- scroll all windows simultaneously {{{
    nnoremap <silent> <S-F5> :windo set scrollbind!<CR>
    inoremap <silent> <S-F5> <C-O>:windo set scrollbind!<CR>
    tnoremap <silent> <S-F5> <C-\><C-N>:windo set scrollbind!<CR>
    " ------- }}}

  " --- }}}

  " --- buffers {{{

    " ------- buffer navigation {{{
    nnoremap <silent> gd :bdelete<CR>
    nnoremap <silent> gb :bnext<CR>
    nnoremap <silent> gB :bprev<CR>
    nnoremap <silent> <leader>1 :<C-U>buffer 1<CR>
    nnoremap <silent> <leader>2 :<C-U>buffer 2<CR>
    nnoremap <silent> <leader>3 :<C-U>buffer 3<CR>
    nnoremap <silent> <leader>4 :<C-U>buffer 4<CR>
    nnoremap <silent> <leader>5 :<C-U>buffer 5<CR>
    nnoremap <silent> <leader>6 :<C-U>buffer 6<CR>
    nnoremap <silent> <leader>7 :<C-U>buffer 7<CR>
    nnoremap <silent> <leader>8 :<C-U>buffer 8<CR>
    nnoremap <silent> <leader>9 :<C-U>buffer 9<CR>
    " ------- }}}

  " --- }}}

  " --- tabs {{{

    " ------- new tab {{{
    nnoremap <silent> <M-Down> :tabnew<CR>
    tnoremap <silent> <M-Down> <C-\><C-N>:tabnew<CR>
    " ------- }}}
    " ------- close tab {{{
    nnoremap <silent> <M-d> :tabclose<CR>
    tnoremap <silent> <M-d> <C-\><C-N>:tabclose<CR>
    " ------- }}}
    " ------- switch between tabs {{{
    nnoremap <silent> ( @='gT'<CR>
    nnoremap <silent> ) @='gt'<CR>
    tnoremap <silent> ( <C-\><C-N>@='gT'<CR>
    tnoremap <silent> ) <C-\><C-N>@='gt'<CR>
    " ------- }}}
    " ------- move tab adjacent {{{
    nnoremap <silent> g( :<C-U>:execute "tabmove -" . v:count1<CR>
    nnoremap <silent> g) :<C-U>:execute "tabmove +" . v:count1<CR>
    "tnoremap <silent> g( <C-\><C-N>:<C-U>:execute "tabmove -" . v:count1<CR>
    "tnoremap <silent> g) <C-\><C-N>:<C-U>:execute "tabmove +" . v:count1<CR>
    " ------- }}}
    " ------- move tab {{{
    noremap <leader>tm :tabmove<space>
    " ------- }}}
    " ------- open specified file in new tab {{{
    noremap <leader>te :tabedit <C-R>=expand("%:p:h")<CR>/
    " ------- }}}
    " ------- allows typing :tabv myfile.txt to view the specified file in a new read-only tab {{{
    cabbrev tabv tab sview +setlocal\ nomodifiable
    " ------- }}}
    " ------- press Shift-F12 to show all buffers in tabs, or to close all tabs {{{
    let notabs = 0
    nnoremap <silent> <S-F12> :let notabs=!notabs<Bar>:if notabs<Bar>:tabo<Bar>:else<Bar>:tab ball<Bar>:tabn<Bar>:endif<CR>
    tnoremap <silent> <S-F12> <C-\><C-N>:let notabs=!notabs<Bar>:if notabs<Bar>:tabo<Bar>:else<Bar>:tab ball<Bar>:tabn<Bar>:endif<CR>
    " ------- }}}
    " ------- show and hide tabline {{{
    nnoremap <silent> <M-S-Up> :set showtabline=0<CR>
    nnoremap <silent> <M-S-Down> :set showtabline=1<CR>
    " ------- }}}

  " --- }}}

  " --- writing {{{

    " ------- quick write {{{
    nnoremap <silent> <leader>w :w<CR>
    " ------- }}}
    " ------- sudo to write {{{
    cnoremap w!! w !sudo tee % >/dev/null
    " ------- }}}
    " ------- change to directory of file {{{
    nnoremap <silent> <leader>. :cd%:h<CR>
    " ------- }}}
    " ------- prevent accidental writes to buffers that shouldn't be edited {{{
    augroup readonly
      autocmd!
      autocmd BufRead *.orig set readonly
      autocmd BufRead *.pacnew set readonly
    augroup END
    " ------- }}}

  " --- }}}

  " --- deleting {{{

    " ------- delete char adjacent-right without moving cursor over one from the left {{{
    nnoremap <silent> gx @='lxh'<CR>
    " ------- }}}

  " --- }}}

  " --- redoing {{{

    " ------- maintain location in document while redoing {{{
    nnoremap . .`[
    " ------- }}}
    " ------- qq to record, Q to replay {{{
    nnoremap Q @q
    " ------- }}}

  " --- }}}

  " --- formatting {{{

    " ------- format visual selection with spacebar {{{
    vnoremap <space> :!fmt<CR>
    " ------- }}}

  " --- }}}

  " --- spaces and tabs {{{

    " ------- set tabstop, shiftwidth and softtabstop to specified value {{{
    nnoremap <leader>ts :Stab<CR>
    " ------- }}}
    " ------- echo tabstop, shiftwidth, softtabstop and expandtab values {{{
    nnoremap <leader>st :call SummarizeTabs()<CR>
    " ------- }}}
    " ------- convert all tabs into spaces and continue session with spaces {{{
    nnoremap <silent><expr> g<M-t> ':set expandtab<CR>:retab!<CR>:echo "Tabs have been converted to spaces"<CR>'
    " ------- }}}
    " ------- convert all spaces into tabs and continue session with tabs {{{
    nnoremap <silent><expr> g<M-T> ':set noexpandtab<CR>:%retab!<CR>:echo "Spaces have been converted to tabs"<CR>'
    " ------- }}}

  " --- }}}

  " --- split and join {{{

    " ------- keep the cursor in place while joining lines {{{
    nnoremap J mzJ`z
    " ------- }}}
    " ------- split line {{{
    nnoremap <silent> S i<CR><ESC>^mwgk:silent! s/\v +$//<CR>:noh<CR>`w
    " ------- }}}

  " --- }}}

  " --- searching {{{

    " ------- remove search highlights {{{
    nnoremap <silent> <leader><CR> :nohlsearch<CR>
    " ------- }}}

  " --- }}}

  " --- folds {{{

    " ------- toggle folds with g+spacebar {{{
    nnoremap <silent> g<space> :exe ":silent! normal za"<CR>
    " ------- }}}
    " ------- focus just the current line with minimal number of folds open {{{
    nnoremap <silent> <leader><leader><space> :call FocusLine()<CR>
    " ------- }}}
    " ------- make zO recursively open whatever fold we're in, even if it's partially open {{{
    nnoremap zO zczO
    " ------- }}}
    " ------- set fold level {{{
    nnoremap <leader>f0 :set foldlevel=0<CR>
    nnoremap <leader>f1 :set foldlevel=1<CR>
    nnoremap <leader>f2 :set foldlevel=2<CR>
    nnoremap <leader>f3 :set foldlevel=3<CR>
    nnoremap <leader>f4 :set foldlevel=4<CR>
    nnoremap <leader>f5 :set foldlevel=5<CR>
    nnoremap <leader>f6 :set foldlevel=6<CR>
    nnoremap <leader>f7 :set foldlevel=7<CR>
    nnoremap <leader>f8 :set foldlevel=8<CR>
    nnoremap <leader>f9 :set foldlevel=9<CR>
    " ------- }}}

  " --- }}}

  " --- merging {{{

    " ------- jump to next conflict marker {{{
    nnoremap <silent> <leader>jc /^\(<\\|=\\|>\)\{7\}\([^=].\+\)\?$<CR>
    " ------- }}}

  " --- }}}

  " --- proofreading {{{

    " ------- toggle spell checking {{{
    noremap <silent> <F7> :set spell! spelllang=en_us<CR>
    inoremap <silent> <F7> <C-O>:set spell! spelllang=en_us<CR>
    vnoremap <silent> <F7> <ESC>:set spell! spelllang=en_us<CR>gv
    " ------- }}}
    " ------- find lines longer than 78 characters {{{
    nnoremap <leader><leader>l /^.\{-}\zs.\%>79v<CR>
    " ------- }}}
    " ------- find two spaces after a period {{{
    nnoremap <leader><leader>. /\.\s\s\+\w/s+1<CR>
    " ------- }}}
    " ------- find things like 'why ?' and 'now !' {{{
    nnoremap <leader><leader>! /\w\s\+[\?\!\;\.\,]/s+1<CR>
    " ------- }}}
    " ------- find multiple newlines together {{{
    nnoremap <leader><leader>cr /\n\{3,\}/s+1<CR>
    " ------- }}}

  " --- }}}

  " --- syntax {{{

    " ------- print current syntax item {{{
    nnoremap <silent> <leader>sa :call SyntaxAttr()<CR>
    nnoremap <silent> <leader>si :echo SyntaxItem()<CR>
    " ------- }}}

  " --- }}}

  " --- hex {{{

    " ------- toggle between hex and binary, after opening file with `vim -b` {{{
    noremap <silent> <F9> :call HexMe()<CR>
    inoremap <silent> <F9> <C-O>:call HexMe()<CR>
    vnoremap <silent> <F9> <ESC>:call HexMe()<CR>gv
    " ------- }}}

  " --- }}}

  " --- unicode {{{

    " ------- toggle display unicode operators in code without changing the underlying file {{{
    noremap <silent> <leader><leader>cl :call ConcealToggle()<CR>
    " ------- }}}

  " --- }}}

" }}}


" words {{{

  " --- dictionary {{{
    " ------- dictionary {{{
    " set dictionary=/usr/share/dict/words
    " ------- }}}
    " ------- spelling {{{
    " let g:spellfile_URL = '/usr/share/vim/vimfiles/spell'
    " if version >= 700
    "   set spl=en spell
    "   set nospell
    " endif
    " ------- }}}
  " --- }}}

  " --- digraphs {{{

  if has('digraphs')
    " (฿) BTC
    digraph B\| 3647
    " (᚛) ogham feather mark
    digraph >\| 5787
    " (᚜) ogham reversed feather mark
    digraph <\| 5788
    " (–) en dash
    digraph -- 8211
    " (—) em dash
    digraph -= 8212
    " (‘) curly left single quote
    digraph Ql 8216
    " (’) curly right single quote
    digraph Qr 8217
    " (“) curly left double quote
    digraph ql 8220
    " (”) curly right double quote
    digraph qr 8221
    " (…) ellipsis
    digraph ., 8230
    " (⁅) left square bracket with quill
    digraph [- 8261
    " (⁆) right square bracket with quill
    digraph -] 8262
    " (∈) equivalent to `(elem)`: http://doc.perl6.org/routine/%E2%88%88
    digraph (- 8712
    " (∉) equivalent to `!(elem)`: http://doc.perl6.org/routine/%E2%88%89
    digraph (/ 8713
    " (∋) equivalent to `(cont)`: http://doc.perl6.org/routine/%E2%88%8B
    digraph -) 8715
    " (∌) equivalent to `!(cont)`: http://doc.perl6.org/routine/%E2%88%8C
    digraph /) 8716
    " (∖) equivalent to `(-)`: http://doc.perl6.org/routine/%E2%88%96
    digraph \\ 8726
    " (∩) equivalent to `(&)`: http://doc.perl6.org/routine/%E2%88%A9
    digraph (U 8745
    " (∪) equivalent to `(|)`: http://doc.perl6.org/routine/%E2%88%AA
    digraph )U 8746
    " (≅) equivalent to `=~=`
    digraph =~ 8773
    " (≼) equivalent to `(<+)`: http://doc.perl6.org/routine/%E2%89%BC
    digraph <+ 8828
    " (≽) equivalent to `(+>)`: http://doc.perl6.org/routine/%E2%89%BD
    digraph +> 8829
    " (⊂) equivalent to `(<)`: http://doc.perl6.org/routine/%E2%8A%82
    digraph (c 8834
    " (⊃) equivalent to `(>)`: http://doc.perl6.org/routine/%E2%8A%83
    digraph )c 8835
    " (⊄) equivalent to `!(<)`: http://doc.perl6.org/routine/%E2%8A%84
    digraph c/ 8836
    " (⊅) equivalent to `!(>)`: http://doc.perl6.org/routine/%E2%8A%85
    digraph \c 8837
    " (⊆) equivalent to `(<=)`: http://doc.perl6.org/routine/%E2%8A%86
    digraph (_ 8838
    " (⊇) equivalent to `(>=)`: http://doc.perl6.org/routine/%E2%8A%87
    digraph )_ 8839
    " (⊈) equivalent to `!(<=)`: http://doc.perl6.org/routine/%E2%8A%88
    digraph _/ 8840
    " (⊉) equivalent to `!(>=)`: http://doc.perl6.org/routine/%E2%8A%89
    digraph \_ 8841
    " (⊍) equivalent to `(.)`: http://doc.perl6.org/routine/%E2%8A%8D
    digraph U. 8845
    " (⊎) equivalent to `(+)`: http://doc.perl6.org/routine/%E2%8A%8E
    digraph U+ 8846
    " (⊖) equivalent to `(^)`: http://doc.perl6.org/routine/%E2%8A%96
    digraph 0- 8854
    " (⟅) left s-shaped bag delimiter
    digraph s\ 10181
    " (⟆) right s-shaped bag delimiter
    digraph s/ 10182
  endif

  " --- }}}

" }}}


" terminal {{{

" scrollback lines
let g:terminal_scrollback_buffer_size = 10000

" open terminal in lower split
nnoremap <silent> <leader><space> :sp term://bash<CR>

" enter normal mode in terminal mode
tnoremap \\ <C-\><C-N>

" switch windows in terminal mode
tnoremap <C-H> <C-\><C-N><C-W>h
tnoremap <C-J> <C-\><C-N><C-W>j
tnoremap <C-K> <C-\><C-N><C-W>k
tnoremap <C-L> <C-\><C-N><C-W>l

" URxvt-like underline cursor
highlight clear TermCursor
highlight TermCursor ctermfg=red cterm=underline gui=underline
highlight clear TermCursorNC
highlight TermCursorNC ctermfg=red cterm=underline gui=underline

" }}}


" load filetype settings {{{

if filereadable(expand('~/.config/nvim/filetypes.vim'))
  source ~/.config/nvim/filetypes.vim
endif

" }}}


" load plugin settings {{{

if filereadable(expand('~/.config/nvim/settings.vim'))
  source ~/.config/nvim/settings.vim
endif

" }}}
