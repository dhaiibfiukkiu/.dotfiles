"起動時にカーソル形状を問い合わせるシーケンスが出ないようにする（for mac "iterm2）
set t_RC=

"tab間の移動
nmap <silent><Space>t :tabe<CR>
nmap <silent><Space>j :-tabmove<CR>
nmap <silent><Space>k :+tabmove<CR>
nmap <silent><C-k> :tabnext<CR>
nmap <silent><C-j> :tabprevious<CR>

"行番号のハイライト
set cursorline

"横のスクロールを細かく
set sidescroll=1

"nomalに戻る時の遅延をなくす
"set ttimeoutlen=50

" 編集箇所のカーソルを記憶
if has("autocmd")
    augroup redhat
        " In text files, always limit the width of text to 78 characters
        autocmd BufRead *.txt set tw=78
        " When editing a file, always jump to the last cursor position
        autocmd BufReadPost *
                    \ if line("'\"") > 0 && line ("'\"") <= line("$") |
                    \   exe "normal! g'\"" |
                    \ endif
    augroup END
endif

" ファイルタイプ検出を有効にする
filetype on
filetype plugin indent on

"行番号表示
" set number
set relativenumber

set fileencoding=utf-8 " 保存時の文字コード
set fileencodings=ucs-boms,utf-8,euc-jp,cp932 " 読み込み時の文字コードの自動判別. 左側が優先される
set fileformats=unix,dos,mac " 改行コードの自動判別. 左側が優先される
"set ambiwidth=double " □や○文字が崩れる問題を解決

set incsearch " インクリメンタルサーチ. １文字入力毎に検索を行う
set ignorecase
set smartcase
"set noignorecase " 検索パターンに大文字小文字を区別する
"set smartcase " 検索パターンに大文字を含んでいたら大文字小文字を区別する
set hlsearch " 検索結果をハイライト

set whichwrap=b,s,h,l,<,>,[,],~ " カーソルの左右移動で行末から次の行の行頭への移動が可能になる
set number " 行番号を表示

" 行が折り返し表示されていた場合、行単位ではなく表示行単位でカーソルを移動する
nnoremap j gj
nnoremap k gk
nnoremap <down> gj
nnoremap <up> gk

set showmatch " 括弧の対応関係を一瞬表示する
source $VIMRUNTIME/macros/matchit.vim " Vimの「%」を拡張する(タグジャンプ)

set wildmenu "コマンドモードのタブ補完

"ペースト時、インデントが崩れないようにする    let &t_SI .=
if &term =~ "xterm"
    let &t_ti .= "\e[?2004h"
    let &t_te .= "\e[?2004l"
    let &pastetoggle = "\e[201~"

    function XTermPasteBegin(ret)
        set paste
        return a:ret
    endfunction

    noremap <special> <expr> <Esc>[200~ XTermPasteBegin("0i")
    inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
    cnoremap <special> <Esc>[200~ <nop>
    cnoremap <special> <Esc>[201~ <nop>
endif

"----------------------------------------------------------
" タブ・インデント
"----------------------------------------------------------
set expandtab " タブ入力を複数の空白入力に置き換える
set tabstop=4 " 画面上でタブ文字が占める幅
set softtabstop=4 " 連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅
set cindent
set shiftwidth=4 " smartindentで増減する幅

"インデント幅デフォルト2
augroup c
    autocmd!
    autocmd BufNewFile,BufRead *.c,*.cpp,*.md setl softtabstop=2
    autocmd BufNewFile,BufRead *.c,*.cpp,*.md setl shiftwidth=2
    autocmd FileType dbui setlocal shiftwidth=2
augroup END

".s拡張子をnasmとして読み込み
autocmd BufNewFile,BufRead *.s set filetype=nasm

"goのときはハードタブに
au BufNewFile,BufRead *.go set noexpandtab

"数行余裕を持たせてスクロールする
:set scrolloff=7

"クリップボードをつかえるようにする
set clipboard+=unnamedplus

"backspaceを有効に
set backspace=indent,eol,start

set termguicolors

"plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'itchyny/lightline.vim'
"Plug 'cohama/lexima.vim'
Plug 'embear/vim-localvimrc'
Plug 'w0rp/ale'
"Plug 'scrooloose/nerdtree'
"Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ryanoasis/vim-devicons'
Plug 'airblade/vim-gitgutter'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-fugitive'
"Plug 'gorodinskiy/vim-coloresque'
Plug 'mattn/emmet-vim'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'liuchengxu/vista.vim'
Plug 'dhaiibfiukkiu/previm'
Plug 'dhruvasagar/vim-table-mode'
"Plug 'Yggdroot/indentLine'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'dhaiibfiukkiu/iceberg.vim'
Plug 'ghifarit53/tokyonight-vim'
Plug 'pbondoer/vim-42header'
"Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-dadbod'
Plug 'kristijanhusak/vim-dadbod-ui'
Plug 'kristijanhusak/vim-dadbod-completion'
Plug 'antoinemadec/coc-fzf'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'honza/vim-snippets'

" Initialize plugin system
call plug#end()

let g:tokyonight_style = 'storm'
colorscheme iceberg
syntax on
let &t_8f = "\<Esc>[38:2:%lu:%lu:%lum"
let &t_8b = "\<Esc>[48:2:%lu:%lu:%lum"

"popup透過
if has('nvim')
    "透過すると補完のアイコン右半分にに文字が被る
    set pumblend=0
endif

"'gitbranch'は長くなるので非推奨
"lightLineの設定
let g:lightline = {
      \ 'colorscheme': 'iceberg',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'gitstatus', 'filename', 'method', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead',
      \   'gitstatus': 'MyGitGutter',
      \   'filetype' : 'MyFiletype',
      \   'fileformtat' : 'MyFileformat',
      \   'method' : 'NearestMethodOrFunction',
      \ },
      \ 'tab_component_function': {
      \   'tabnum': 'LightlineWebDevIcons',
      \ }
      \ }

function! NearestMethodOrFunction() abort
  return winwidth('.') > 90 ? get(b:, 'vista_nearest_method_or_function', '') : ''
endfunction
"set statusline+=%{NearestMethodOrFunction()}

" By default vista.vim never run if you don't call it explicitly.
"
" If you want to show the nearest function in your statusline automatically,
" you can add the following line to your vimrc
autocmd VimEnter * call vista#RunForNearestMethodOrFunction()

function! LightlineWebDevIcons(n)
  let l:bufnr = tabpagebuflist(a:n)[tabpagewinnr(a:n) - 1]
  return WebDevIconsGetFileTypeSymbol(bufname(l:bufnr))
endfunction

function! MyGitGutter()
  if ! exists('*GitGutterGetHunkSummary')
        \ || ! get(g:, 'gitgutter_enabled', 0)
        \ || winwidth('.') <= 90
    return ''
  endif
  let symbols = [
        \ g:gitgutter_sign_added . '',
        \ g:gitgutter_sign_modified . '',
        \ g:gitgutter_sign_removed . ''
        \ ]
  let hunks = GitGutterGetHunkSummary()
  let ret = []
  for i in [0, 1, 2]
    if hunks[i] > 0
      call add(ret, symbols[i] . hunks[i])
    endif
  endfor
  return join(ret, ' ')
endfunction

function! MyFiletype()
    return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endfunction

function! MyFileformat()
    return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
endfunction

"ステータスラインの設定
set laststatus=2 " ステータスラインを常に表示
set showmode " 現在のモードを表示
set showcmd " 打ったコマンドをステータスラインの下に表示
set ruler " ステータスラインの右側にカーソルの現在位置を表示する

"git-gutter
set updatetime=100

"ale
let g:ale_linters = {
    \ 'html': ['eslint'],
    \ 'c': ['gcc'],
    \ 'cpp': [],
    \ 'php': ['phpcs', 'php', 'phpstan'],
    \ 'ruby': [],
    \ 'go': ['golangci-lint'],
    \ }
let g:ale_fix_on_save = 0
let g:ale_fixers = {
    \ 'go': ['gofmt', 'goimports'],
    \ 'php': ['php_cs_fixer'],
    \ 'python': ['autopep8', 'black', 'isort'],
    \ 'javascript': ['eslint'],
    \ 'sql': ['sqlfmt'],
    \ }
" virtualtextにエラー表示
let g:ale_virtualtext_cursor = 1
let g:ale_virtualtext_prefix = '>'
let g:ale_sign_error = ''
let g:ale_sign_warning = ''
let g:ale_sign_info = ''
let g:ale_sign_style_error = ''
let g:ale_sign_style_warning = ''
let g:ale_php_phpcs_standard = 'PSR12'
let g:ale_c_clang_options = "-std=c11 -Wall -Werror -Wextra"
let g:ale_c_gcc_options = "-std=c11 -Wall -Werror -Wextra"
let g:ale_cpp_clang_options = "-std=c++14 -Wall -Werror -Wextra"
let g:ale_cpp_gcc_options = "-std=c++14 -Wall -Werror -Wextra"
let g:ale_sql_sqlfmt_options = '-u'
"eslint,phpcsは特に設定しなくてもローカルのものが動く
".gitが存在すればphpstanはローカルで動く
let g:ale_php_phpstan_executable = system('if ! type git &> /dev/null; then echo -n phpstan; else PSE=`git rev-parse --show-toplevel 2> /dev/null`/vendor/bin/phpstan; if [ -x "$PSE" ]; then echo -n $PSE; else echo -n phpstan; fi; fi')
"let g:ale_php_phpstan_level = 4
"エラー間の移動
nmap <silent> [a <Plug>(ale_previous_wrap)
nmap <silent> ]a <Plug>(ale_next_wrap)
nmap <silent> <Space>F :ALEFix<CR>

" coc
let g:coc_global_extensions = ['coc-db', 'coc-json', 'coc-texlab', 'coc-sql', 'coc-sh', 'coc-pyright', 'coc-phpls', 'coc-html', 'coc-htmlhint', 'coc-css', 'coc-cssmodules', 'coc-go', 'coc-clangd', 'coc-pairs', 'coc-emoji', 'coc-vimlsp', 'coc-spell-checker', 'coc-yaml', 'coc-yank', 'coc-markdownlint', 'coc-snippets', 'coc-highlight', 'coc-explorer', 'coc-tsserver', 'coc-vetur']
"'coc-word', 'coc-translator', 'coc-xml', 'coc-graphql'

"coc-explorer
let g:coc_explorer_global_presets = {
\   '.vim': {
\     'root-uri': '~/.vim',
\   },
\   'cocConfig': {
\      'root-uri': '~/.config/coc',
\   },
\   'tab': {
\     'position': 'tab',
\     'quit-on-open': v:true,
\   },
\   'floating': {
\     'position': 'floating',
\     'open-action-strategy': 'sourceWindow',
\   },
\   'floatingTop': {
\     'position': 'floating',
\     'floating-position': 'center-top',
\     'open-action-strategy': 'sourceWindow',
\   },
\   'floatingLeftside': {
\     'position': 'floating',
\     'floating-position': 'left-center',
\     'floating-width': 60,
\     'open-action-strategy': 'sourceWindow',
\   },
\   'floatingRightside': {
\     'position': 'floating',
\     'floating-position': 'right-center',
\     'floating-width': 50,
\     'open-action-strategy': 'sourceWindow',
\   },
\   'simplify': {
\     'file-child-template': '[selection | clip | 1] [indent][icon | 1] [filename omitCenter 1]'
\   },
\   'buffer': {
\     'sources': [{'name': 'buffer', 'expand': v:true}]
\   },
\ }

" Use preset argument to open it
"nmap <space>ed :CocCommand explorer --preset .vim<CR>
"nmap <space>ef :CocCommand explorer --preset floating<CR>
"nmap <space>ec :CocCommand explorer --preset cocConfig<CR>
"nmap <space>eb :CocCommand explorer --preset buffer<CR>
nmap <silent><c-n> :CocCommand explorer
    \ --toggle
    \ --sources=buffer-,file+
    \ --width 40
    \ --preset floatingLeftside
    \ <CR>

" List all presets
"nmap <space>el :CocList explPresets

"coc-highlight
nnoremap <silent><Space>p :call CocAction('pickColor')<CR>

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=100

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <C-n>
      \ pumvisible() ? "\<C-n>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion. "上のTABの設定で十分 
"if has('nvim')
"    inoremap <silent><expr> <c-space> coc#refresh()
"else
"    inoremap <silent><expr> <c-r> coc#refresh()
"endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
"inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
"                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [e <Plug>(coc-diagnostic-prev)
nmap <silent> ]e <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> ]dd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> <Space>r <Plug>(coc-references)
nmap <silent><C-h> :call CocActionAsync('doHover')<CR>

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <Space>n <Plug>(coc-rename)

" Formatting selected code.
nmap <Space>f  <Plug>(coc-format)
vmap <Space>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <silent><Space>a  <Plug>(coc-codeaction-selected)
nmap <silent><Space>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <silent><Space>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <Space>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-j> and <C-k> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-j> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-k> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-j> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-k> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-j> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-k> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
"nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
"nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
"nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
"nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
"nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
"nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
"nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
"nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

"coc-markdownlint
autocmd BufNewFile,BufRead *.md nnoremap <buffer><silent> <Space>f :call CocAction('runCommand', 'markdownlint.fixAll')<CR>

"coc-fzf
nnoremap <silent><nowait> <space>s :<C-u>CocFzfList symbols<CR>
nnoremap <silent><nowait> <space>d :<C-u>CocFzfList diagnostics --current-buf<CR>

"git-fugitive
nnoremap <Space>gs :tab sp<CR>:Gstatus<CR>:only<CR>
nnoremap <Space>ga :Gwrite<CR>
nnoremap <Space>gc :Gcommit<CR>
nnoremap <Space>gb :Gblame<CR>
nnoremap <Space>gl :Git log<CR>
nnoremap <Space>gh :tab sp<CR>:0Glog<CR>
nnoremap <Space>gp :Gpush<CR>
nnoremap <Space>gf :Gfetch<CR>
nnoremap <Space>gd :Gvdiff<CR>
nnoremap <Space>gr :Grebase -i<CR>
nnoremap <Space>gg :Ggrep
nnoremap <Space>gm :Gmerge

"GitGutter
nnoremap <Space>gu :GitGutterUndoHunk<CR>

"fzf
nnoremap <silent> <C-f> :Files<CR>
autocmd! FileType fzf tnoremap <buffer> <C-f> <c-c>
"ファイル名が指定されなかったらfzf起動できるようにしたい
"escでタブが閉じるのが遅いので追加
autocmd FileType fzf tnoremap <buffer> <Esc> <Esc>

"vista
let g:vista_default_executive = 'coc'
let g:vista_sidebar_width = 40
let g:vista_echo_cursor = 0
nnoremap <silent> <Space>v :Vista!!<CR>

"modifyOtherKeysの問題で制御文字4;2mが出るのを抑制
let &t_TI = ""
let &t_TE = ""

"markdown
"Tex記法のみconcealする場合→微妙にうまくいかない
"let g:vim_markdown_conceal_code_blocks = 0
let g:vim_markdown_math = 1
"全てconcealしない場合
let g:vim_markdown_conceal=0
let g:vim_markdown_conceal_code_blocks = 0
let g:tex_conceal=''

"previm
if has('macunix')
    let g:previm_open_cmd="open -a safari"
elseif has('unix')
    let g:previm_open_cmd="google-chrome"
endif
let g:previm_enable_realtime=1

"vim-table-mode
function! s:isAtStartOfLine(mapping)
  let text_before_cursor = getline('.')[0 : col('.')-1]
  let mapping_pattern = '\V' . escape(a:mapping, '\')
  let comment_pattern = '\V' . escape(substitute(&l:commentstring, '%s.*$', '', ''), '\')
  return (text_before_cursor =~? '^' . ('\v(' . comment_pattern . '\v)?') . '\s*\v' . mapping_pattern . '\v$')
endfunction

inoreabbrev <expr> <bar><bar>
          \ <SID>isAtStartOfLine('\|\|') ?
          \ '<c-o>:TableModeEnable<cr><bar><space><bar><left><left>' : '<bar><bar>'
inoreabbrev <expr> __
          \ <SID>isAtStartOfLine('__') ?
          \ '<c-o>:silent! TableModeDisable<cr>' : '__'

"localvimrc
let g:localvimrc_ask=0

"起動時メッセージ出さない
set shortmess+=I

"時刻によってbackground colorを変更
"let g:time_to_set_background = str2nr(strftime("%H%M%S"))
"if (g:time_to_set_background >= 70000 && g:time_to_set_background < 160000)
"    set background=light
"else
"    set background=dark
"endif

"自動改行させない
autocmd FileType * setlocal textwidth=0

"indentLine
let g:indent_blankline_space_char=' '
let g:indent_blankline_char='▏'
let g:indent_blankline_filetype_exclude = ['help', 'coc-explorer', 'fzf']
let g:indent_blankline_char_highlight_list = ['Comment']
"let g:indentLine_showFirstIndentLevel=1 "現時点で機能しない

"coc-snippets
" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet. 選択したテキストをスニペットに埋め込み
"vmap <C-j> <Plug>(coc-snippets-select)

" Use <leader>x for convert visual selected code to snippet
xmap <C-x>  <Plug>(coc-convert-snippet)

" C-lで確定(enter一発で改行したい)←tabだと副作用が大きい
inoremap <silent><expr> <C-l>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ "\<C-l>"
"      \ <SID>check_back_space() ? "\<TAB>" :
"      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'
let g:coc_snippet_prev = '<S-tab>'

lua <<EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    disable = {
      'php',
    }
  },
  indent = {
    enable = false,
  },
  ensure_installed = 'maintained',
}
EOF
