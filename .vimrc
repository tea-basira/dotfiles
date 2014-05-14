"https://github.com/toorsoo/dotfiles
"---------------------------------
"TODO: 
" - NeobundleInstall
"   - 会社の環境だとなんかできない <- 原因調査の時間がとれない <- 
"---------------------------------

if &t_Co > 2 || has("gui_running")
    syntax on
    set hlsearch
endif
filetype plugin on
if &term=="xterm"
    set t_Co=256
    set t_Sf=[3%dm
endif

if has('multi_byte_ime') || has('xim') 
highlight Cursor guifg=NONE guibg=White
highlight CursorIM guifg=NONE guibg=DarkRed
endif

"help関連 ---------------------------------------------------
set helplang=ja,en
if filereadable(expand('~/.vim/vimdoc-ja/doc/'))
    helptags ~/.vim/vimdoc-ja/doc/
endif

"Windows -------------------------------------------------------
"フォント設定 
"MigMix_2M 要インストール
set guifont=MigMix_2M:h9:cSHIFTJIS
"ツールバー削除
set guioptions-=T
"メニュー削除
set guioptions-=m

"<leader>変更
let mapleader =","

"全角スペース表示設定 -----------------------------------------
"function! ZenkakuSpace()
"highlight ZenkakuSpace cterm=reverse ctermfg=DarkMagenta gui=reverse guifg=DarkMagenta
"endfunction

"カーソル設定 -------------------------------------------------
set cursorline
highlight cursorline term=reverse ctermbg=242
set nocursorline
highlight CursorLine term=reverse cterm=none ctermbg=242
augroup cch
autocmd! cch
autocmd WinLeave * set nocursorline
autocmd WinLeave * set nocursorcolumn
autocmd WinEnter,BufRead * set cursorline
autocmd WinEnter,BufRead * set cursorcolumn
augroup END

set cursorline
":highlight CursorLine ctermfg=222
highlight CursorLine ctermbg=0
highlight CursorColumn ctermbg=2
set diffopt-=filler

"バックスペース設定
set backspace=start,eol,indent
"tab 設定 -----------------------------------------------------
set nu
set expandtab
set ts=4
set autoindent
set shiftwidth=4

"ねおこん 起動
let g:neocomplcache_enable_at_startup = 1
"大文字が入力されるまで大文字小文字の区別を無視する
let g:neocomplcache_enable_smart_case = 1
"表示する候補の数
let g:neocomplcache_max_list = 24
let g:neocomplcache_enable_camel_case_completion = 0

"オムニ補完
augroup SetOmniCompletionSetting
autocmd!
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType ctp setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType twig setlocal omnifunc=htmlcomplete#CompleteTags
"autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP
augroup END

" 単語を新規タブを開いて検索
function! TabGrep(keyword)
    tabedit
    execute 'vimgrep /'.a:keyword.'/ **/*.*'
endfunction
command! -nargs=* Grep :call TabGrep(<f-args>)
nnoremap <space>tg yiw:Grep <c-r><c-w><cr>

"-----------------------------------------------------------------------------
"mapはここに
"-----------------------------------------------------------------------------
"vimrc編集関連 --------------------------------------------------------
nnoremap <silent> <space>tv :tabe $MYVIMRC<cr>:echo "edit my vimrc"<cr>
nnoremap <silent> <space>tV :vs   $MYVIMRC<cr>
nnoremap <silent> <space>ev :edit $MYVIMRC<cr>
nnoremap <silent> <space>rv :source $MYVIMRC<cr>:echo "VIMRC reloaded."<cr>

"VimFiler関連 ---------------------------------------------------------
nnoremap <silent><space>ef :VimFilerCurrentDir<cr>
nnoremap <silent><space>te :tabe<cr>:VimFilerCurrentDir<cr>
nnoremap <silent><space>ee :tabe %<cr>

"危険なキーを無効化 ---------------------------------------------------
nnoremap ZZ <Nop>
nnoremap ZQ <Nop>

"検索時, 結果を真ん中に表示する
nmap n nzz
nmap N Nzz

"カラー表示map --------------------------------------------------------
nnoremap <silent> <space>color :so $VIMRUNTIME/syntax/colortest.vim<cr>
"vimgrep短縮 ----------------------------------------------------------
nnoremap <space>grep :vimgrep /<C-R><C-W>/ **/*.*
nnoremap <space>vg :vs<cr> :vimgrep /<C-R><C-W>/ **/*.*
" 検索関連 ------------------------------------------------------------
nnoremap <silent> <space>n :cn<cr>
nnoremap <silent> <space>N :cN<cr>
vnoremap <space>grep y:vimgrep /<C-R>"/ **/*.*
vnoremap <space>vg :vs<cr> y:vimgrep /<C-R>"/ **/*.*
vnoremap <space>tg y:tabe<cr>p:vimgrep! /<C-R>"/ **/*.*
"現在のファイル内でvimgrep (*キーのvimgrep
nnoremap <silent> <space>* *n :vimgrep /<C-R><C-W>/ %<cr>
vnoremap <silent> <space>* *n y:vimgrep /<C-R>"/ %<cr>
"T.ODO リスト表示 
nnoremap <silent> <space>todo :vimgrep /TODO/ **/*.*<cr>
" spaceで置き換え
nnoremap <leader><space> s <esc>
"VisualStudio っぽく
nnoremap <s-w> viw
"ファイル末尾移動時, カーソル位置を画面中央へ
nnoremap G Gzz
"前回作業位置へ移動時, カーソル位置を画面中央へ
nnoremap <C-o> <C-o>zz
nnoremap <C-i> <C-i>zz
"タブ移動関連 ----------------------------------------------
nnoremap L gt
nnoremap H gT
"ウィンドウ移動関連 ----------------------------------------
nnoremap <silent><space>h <c-w>h
nnoremap <silent><space>l <c-w>l
nnoremap <silent><space>j <c-w>j
nnoremap <silent><space>k <c-w>k
"押しにくいキーの簡略化 ------------------------------------
nnoremap <c-h> ^
nnoremap <c-l> $
vnoremap <c-h> ^
vnoremap <c-l> $
nnoremap y<c-h> y^
nnoremap y<c-l> y$
nnoremap d<c-h> d^
nnoremap d<c-l> d$
vnoremap <s-h> <
vnoremap <s-l> >
" K （もっと使い勝手のいいコマンドあるやも
nnoremap K f(
"現在のファイルをカレントディレクトリに
"TODO: functionでまとめる
nnoremap <space>cd :cd %:h<cr>:echo "MOVE DIRECTORY. -> ". expand("%:p")<cr>
nnoremap <space>CD :lcd %:h<cr>:echo "MOVE LOCAL DIRECTORY. -> ". expand("%:p")<cr>
"パス表示短縮
nnoremap <silent> <space>pwd  :echo expand("%:p")<cr>
"フルパスを無名レジスタへ
nnoremap <silent> <space>yp :let @" = expand("%:p")<cr>:echo @"<cr>
"無名レジスタに格納されている文字列をパスとしてファイルを開く
nnoremap <silent> <space>ep :e <C-r>"<cr>:echo "Opened the file from yank register."<cr>
"yankレジスタの内容と, カーソル上の単語を入れ替え
nnoremap <silent> <space>p :let @z=@"<cr>diwh"zp:let @"=@z<cr>
" plugin関連
inoremap <expr><C-n> neocomplcache#manual_keyword_complete()
inoremap <expr><CR> neocomplcache#smart_close_popup() . "\<CR>"
"tabで補完候補の選択を行う
inoremap <expr><TAB> pumvisible() ? "\<Down>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<Up>" : "\<S-TAB>"
"surround -----------------------------------------------------------------
vmap " S"
vmap { S{
vmap ' S'
"vmap < S<
vmap < <
vmap [ S[
vmap ( S(
"多めに上下移動------------------------------------------------------------
vnoremap <C-j> 3j
vnoremap <C-k> 3k
nnoremap <C-j> 3j
nnoremap <C-k> 3k

"にやんぱす
noremap np aにゃんぱすー<esc>

"ハイライト
"全角スペース
"highlight ZenkakuSpace ctermbg=lightblue guibg=white
"match ZenkakuSpace /　/ 

"検索 -----------------------------------------------
set ignorecase  "小文字検索で大文字もヒットさせる
set smartcase   "大文字も含めた検索の場合はその通りに検索を行う

"IME系
"set noimdisabe "INSERTモードから抜けた際に自動でIME入力をOFFにする
"inoremap <silent> <esc> <esc>:set iminsert=0<cr>


"quickfix 自動表示-----------------------------------------------
function! OpenModifiableQF()
cw
set modifiable
set nowrap
endfunction
autocmd QuickfixCmdPost vimgrep call OpenModifiableQF()

"scroll開始行
set scrolloff=4
"カレントファイル関連 ---------------------------------------
"現在のファイルをそのまま読み直す
nnoremap <silent> <space>rr :e %<cr>

"TODO syntax
syntax keyword javaScriptCommentTodo    TODO FIXME XXX TBD contained

"*を選択中の文字列に対してはその検索を行う
vnoremap * y/<C-r>"<cr>
 
let g:debugTraceMessageCount = 0
function! WriteDebugTraceMessage()
    let g:debugTraceMessageCount = g:debugTraceMessageCount + 1
    let @c = g:debugTraceMessageCount
    normal oconsole.log( '\u001b[04m'+'          DebugTrace[
    normal "cp
    normal a]' + __filename +'\u001b[0m'
    normal A ); // [DBGTAG]
    normal ==w
endfunction

nnoremap <silent> <leader>tr oconsole.log( '\u001b[31m'++'\u001b[0m' );<esc>0f+
nnoremap <silent> <space>d :call WriteDebugTraceMessage()<cr>
nnoremap <silent> <space>dj :call WriteDebugTraceMessage()<cr>
"nnoremap <silent> <space> a// CODINGTAG

nnoremap <silent> <s-q> call WriteDebugTraceMessage()<cr>

let @c = 0
let @d = 0
nnoremap <silent> <space>x jOconsole.log('@+@+@+@+@+@+@+@+@+@+@+@+@+@+@+@+@+@+@+@+@+@@+@+@+@+@+@+@+@+@+@+@+@+@+@+@+@+@+@+@+@+@+@');<esc>
"console.log('#*#*#*#*#*#*# DebugTrace[2] --------------------- ' + "__filename);
nnoremap <silent> <space>D :let @c = 0<cr>
nnoremap <silent> <space>[1 :let @d = 0<cr>
nnoremap <silent> [1 :let @c = @c+1<cr>a[ <esc>"cpA ]<esc>
nnoremap <silent> <space>dd :let @c = @c+1<cr>ovar_dump('###### DEBUG CHECK [ <esc>"cpA ] ######<br>');<esc>
"foreach snipet
nnoremap <leader>fore yiwea.forEach(function(o){});<esc>T{i
"comment(仮実装
nnoremap <leader>" I"<esc>j

"js関連 code snipet *******************************************************
inoremap forin for( var i in  ){<cr>}<esc>bh
" ヤンクレジスタ内をconsole.log
"vnoremap <space><space> Iconsole.log( <esc>pi );<esc>

"------------------------------------------------------------------------
"  C++ 関連はここから
"------------------------------------------------------------------------
"コードスニペット的な物
"TODO: mapよりももっといい方法あるのでは？ -> ぐぐる
"C++ コード追跡用
nnoremap <silent> <space>dc jOstd::cout << "@+@+@+@+@+@+@+@+@+@+@+@+@+@+@+@+@+@+@+@+@+@+@+@+@+@+@+@+@+@+@+@+@+@+@+@+@+@+@+@+@+@" << std::endl;<esc>
"C++ singleton class 自動生成
nnoremap <leader>csingle diwo class <esc>pa{<cr>public:<cr>    static <esc>pA& GetInstance(){    <cr>static <esc>pA instance;<cr>return instance;<cr>}<esc>
"std::for_each自動設定
nnoremap <leader>fe diw istd::for_each(<esc>pa.begin(),<esc>pa.end(),[&](){<cr>});<cr><esc>3kdd$T]
"定義した変数の型を無名バッファへ(正しい結果が得られるとは限らない)
nnoremap <silent><leader>o gdD^y$u<C-o><C-o><esc>

" PHP関連
"nnoremap <c-x> <c-x>
inoremap <c-x> <esc>bi$<esc>ea
nnoremap <space>vd Ivar_dump();<esc>==f(

"括弧入れた後に移動とか
inoremap <c-l> <esc>ea
"括弧内のテキストにスペースを入れる
nnoremap <space>(<space> T(i <esc>t)a <esc>

"キーワード入力補助
imap =<space> = 
imap == == 
imap , , 

"over.vim {{{
"over.vimの起動
nnoremap <silent> <Leader>m :OverCommandLine<CR>
"カーソル下の単語をハイライト付きで置換
nnoremap sub :OverCommandLine<CR>%s/<C-r><C-w>//g<Left><Left>
"コピーした文字列をハイライト付きで置換
nnoremap subp y:OverCommandLine<CR>%s!<C-r>=substitute(@0,  '!',  '\\!', " 'g')<CR>!!gI<Left><Left><Left>
" }}}

map <leader>c <Plug>(operator-camelize)
map <leader>C <Plug>(operator-decamelize))

vnoremap <leader>fi dafor(var i in <esc>p){}h

function! CSVH(x)
    execute 'match Keyword /^\([^, ]*, \)\{'.a:x.'}\zs[^, ]*/'
    execute 'normal ^'.a:x.'f, '
    endfunction
command! -nargs=1 Csv :call CSVH(<args>)

"ctrl+qって何か使ったっけ
nnoremap <c-q> :tabe<cr>:VimFilerCurrentDir<cr>
"noremap <silent><s-q> :cd %:h<cr>:tabe<cr>:VimFilerCurrentDir<cr>

" ( から : までの間にある文字列をパス, : 以降にある最初の数値が行数として 新しいタブで開く
nnoremap <space>tgf "fyylT("pyt:t:<c-a><c-x>"lyiw:tabe! <c-r>p<cr>:<c-r>l<esc>:echo "<c-r>f"<cr>

"COLOR
"TODO: 環境によって変えたい
"LINUX
"WINDOWS
colorscheme default
"WINDOWS
"
" 処理の関数化テスト
" w: (ウィンドウにローカルな変数)
" g: (タブ変数)
" g: (グローバル変数)
" t: (グローバル変数)
" g: (グローバル変数)
let g:hoge = 0
function! TestHoge()
    if g:hoge == 1
        echo "aaa"
        let g:hoge = 0
    else
        let g:hoge = 1
        echo g:hoge 
    endif
endfunction
command! HOGE :call TestHoge()

function! CsvColumn()
    let @" = expand("%:p")
    set modifiable
    3new
    normal p
    normal <c-w><c-w>
"    set nomodifiable
endfunction

command! CSV :call CsvColumn()

"nodejsを使って現在のunixtime取得
nnoremap <space>uni o<esc>!! node ~/nodetest/unixtime.js<cr>yiwu
"annoremap <space>uwp o<esc>v:! node ~/nodetest/unixtime.js<cr>yiwuyiwp

"UNIXTIME を 時刻に変換して echo する
if filereadable(expand('~/nodetest/unixtime_to_time.js'))
    let g:display_date_from_unixtime = 0
    function! DisplayDateFromUnixtime()
        if g:display_date_from_unixtime == 1
            let g:display_date_from_unixtime = 0
            echo 'Non-Display dateTime from unixtime setting.'
        else
            let g:display_date_from_unixtime = 1
            echo 'Display dateTime from unixtime setting.'
        endif
    endfunction

    function! DateTimeFromTimeStamp()
        if g:display_date_from_unixtime
            "カーソル元をコピー
            let l:res = expand('<cword>')
            "Nodeを利用して UnixTime の表示を変換する
            silent let l:res = system("node ~/nodetest/unixtime_to_time.js ". l:res)
            "TODO: Node依存解消

            "改行を削除して表示
            echo substitute(l:res, "\n", "", "g")
        endif
    endfunction

    command! UnixTime :call DateTimeFromTimeStamp()
    nnoremap tt :UnixTime<cr>

    "十字キー活用
    nnoremap <silent><up> gk:UnixTime<cr>
    nnoremap <silent><down> gj:UnixTime<cr>
    nnoremap <silent><left> h:UnixTime<cr>
    nnoremap <silent><right> l:UnixTime<cr>
    "UnixTime表示 ON/OFF
    nnoremap <silent><space>ut :call DisplayDateFromUnixtime()<cr>
endif

"lightline関連 ------------------------------------------------------
command! Tail :!%tail -fn 1000 %<cr>
set laststatus=2 
set t_Co=256
colorscheme peachpuff
let g:lightline = {
\ 'colorscheme': 'landscape', 
\ 'mode_map': {'c': 'NORMAL'}, 
\ 'active': {
\   'left': [ [ 'mode',  'paste' ],  [ 'fugitive',  'filename' ] ]
\ }, 
\ 'component_function': {
\   'modified': 'MyModified', 
\   'readonly': 'MyReadonly', 
\   'fugitive': 'MyFugitive', 
\   'filename': 'MyFilename', 
\   'fileformat': 'MyFileformat', 
\   'filetype': 'MyFiletype', 
\   'fileencoding': 'MyFileencoding', 
\   'mode': 'MyMode'
\ }
\ }

function! MyModified()
    return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! MyReadonly()
    return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? 'x' : ''
endfunction

function! MyFilename()
return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
\ (&ft ==  'vimfiler' ? vimfiler#get_status_string() :
\  &ft ==  'unite' ? unite#get_status_string() :
\  &ft ==  'vimshell' ? vimshell#get_status_string() :
\ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
\ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

function! MyFugitive()
    try
        if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head')
            return fugitive#head()
        endif
    catch
        endtry
        return ''
endfunction

function! MyFileformat()
    return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! MyFiletype()
    return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! MyFileencoding()
    return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! MyMode()
    return winwidth(0) > 60 ? lightline#mode() : ''
endfunction')')')')')
"----------------------------------------------------------------

syntax enable
set background=dark
let g:solarized_termcolors=256
let g:solarized_degrade=1
"colorscheme solarized
colorscheme molokai

"入力待ち時間を短縮
set timeout timeoutlen=250 ttimeoutlen=25
noremap <leader>c o/**<cr>*<cr>*/<esc>kA<esc>
noremap <leader>p A @param <esc>

function! Tabee()
    normal <space>yp
    normal :tabe
    normal <space>ep
endfunction
command! Tabee :call Tabee()

if filereadable(expand('~/.tags'))
    "設定ファイル
    set tags=~/.tags
endif

" vimsound
"let s:se_path = "~/vimsound/wav/"
"let s:se_ext = ".wav"
"function! s:change_sound_name(base_name)
   "return expand(s:se_path . a:base_name . s:se_ext)
"endfunction
"function! PlaySE(name)
 "call sound#play_wav(s:change_sound_name(a:name))
"endfunction
"
"autocmd TabEnter * call PlaySE("PlayGetKey")

"環境毎の個別設定 ----------------------------------
"業務用
if filereadable(expand('~/vim_peculiar_setting/project_1.vim'))
    "設定ファイル
    source ~/vim_peculiar_setting/project_1.vim
    "edit 短縮キー
    nnoremap <space>ttv :tabe ~/vim_peculiar_setting/project_1.vim<cr>
    nnoremap <space>eev :vs ~/vim_peculiar_setting/project_1.vim<cr>
endif

