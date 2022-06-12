"Расширения включаются и отключаются с помощью vim-addons из пакета vim-addons-manager:
" $ vim-addons list # показать список доступных расширений
" $ vim-addons install latex-suite # установить/включить расширение
" $ vim-addons disable latex-suite # отключаем расширение latex-suite
" $ vim-addons remove latex-suite # удаляем расширение latex-suite (из ~/.vim)

colorscheme koehler

" Определять тип файла
filetype plugin indent on

" установка клавиши лидер
let mapleader=","

" Список кодировок файлов для автоопределения
set fileencodings=utf-8,cp1251,koi8-r,cp866

" настройка для работы с рус.словами (чтобы w, b, * понимали русские слова)
set iskeyword=@,48-57,_,192-255

:ab #b /************************************************
:ab #e ************************************************/
" SetGuiFont()
"   Выставляет опцию 'guifont' согласно текущему состоянию локали или
"   переменной RESOURCE_NAME
function! SetGuiFont ()
    if has('x11') && has('gui_running')
        let resource_name = $RESOURCE_NAME
        if resource_name == ''
            if &encoding == 'koi8-r'
                let resource_name = 'KOI'
            elseif &encoding == '8bit-cp1251'
                let resource_name = 'WIN'
            elseif &encoding == 'utf-8'
                let resource_name = 'UTF-8'
            elseif &encoding == 'iso-8859-5'
                let resource_name = 'ISO'
            elseif &encoding == 'latin1'
                let resource_name = 'LAT'
            endif
        endif
        let v:errmsg = ''
        silent! new +r\ !xrdb\ -query
        exe 'silent! /^' . resource_name . '\*font:'
        if v:errmsg == ''
            s/\s*$//
            let fontname = matchstr(getline('.'), '\S\+$')
            if fontname != ''
                let &guifont = fontname
            endif
        endif
        q!
    endif
endfunction

set wildmenu
set wcm=<Tab>
menu Encoding.koi8-r       :e ++enc=koi8-r<CR>
menu Encoding.windows-1251 :e ++enc=cp1251<CR>
menu Encoding.ibm-866      :e ++enc=ibm866<CR>
menu Encoding.utf-8        :e ++enc=utf-8<CR>
menu Encoding.utf-16       :e ++enc=utf-16<CR>
map <F8> :emenu Encoding.<TAB>

if version >= 700
"   По умолчанию проверка орфографии выключена.
    setlocal spell spelllang=
    setlocal nospell
    function ChangeSpellLang()
        if &spelllang =~ "en_us"
            setlocal spell spelllang=ru_yo
            echo "spelllang: ru_yo"
        elseif &spelllang =~ "ru_yo"
            setlocal spell spelllang=
            setlocal nospell
            echo "spelllang: off"
        else
            setlocal spell spelllang=en_us
            echo "spelllang: en"
        endif
    endfunc

    " map spell on/off for English/Russian
    map <F10> <Esc>:call ChangeSpellLang()<CR>
endif

:menu Tools.Bo&x\ Draw :so ~/.vim/boxdraw.vim<CR>

"Устанавливаем русскую раскладку
set keymap=russian-jcukenwin

"Настройка переключения раскладки
set iminsert=0
set imsearch=0

noremap  <S-Tab> :let &iminsert = ! &iminsert<CR>
inoremap <S-Tab> <C-^>
noremap! <S-Tab> <C-^>

"Всегда показывать у курсора n строк и n столбцов
set scrolloff=2
set sidescrolloff=2

"Подсвечивать табы и ведомые пробелы
set listchars=tab:>-,trail:_,precedes:<,extends:>

"Переносить после n символов
set textwidth=78

"Переносить целые слова
set linebreak

"Нумерация строк
map <F9> :let &number = ! &number<CR>
"Перенос строк
map <F3> :let &wrap = ! &wrap<CR>

"Научить сохранять оригинальные файлы
"set patchmode=.old

autocmd BufReadPost *.p e ++enc=cp866
autocmd BufReadPost *.i e ++enc=cp866

set hlsearch
set incsearch
nmap <F4> :w!<CR>:!aspell -e -c -d ru %<CR>:e! %<CR>

"Включение режима вклейки
set pastetoggle=<F7>

"Подсветка текущей строки
" set cursorline

" Перевод
function! TranslateWord()
  let s:dict    = "trans en:ru -no-ansi"
  let s:phrase  = expand("<cword>")
  let s:tmpfile = tempname()
  silent execute "!" . s:dict . " " . s:phrase . " > " . s:tmpfile
  execute "botright sp " . s:tmpfile
  g/^\s*$/de
  normal ggVG<.dd.J
endfunction

map <F2> :call TranslateWord()<CR>

execute pathogen#infect()
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_python_checkers = ['pylint']
let g:syntastic_tex_checkers = ['lacheck', 'text/language_check']
let g:syntastic_c_checkers = ['gcc']
let g:syntastic_cpp_checkers = ['gcc']

" Выход
map <C-F6> :q<CR>

" Выход без изменений
map <S-F6> :q!<CR>

"-------------------------
" Базовые настройки
"-------------------------
" Включаем несовместимость настроек с Vi (ибо Vi нам и не понадобится).
set nocompatible

" Показывать положение курсора всё время.
set ruler

" Показывать незавершённые команды в статусбаре
set showcmd
set mps+=<:> " показывать совпадающие скобки для HTML-тегов
set autoread " перечитывать изменённые файлы автоматически

" Включаем нумерацию строк
set nu

" Фолдинг по отсупам
"set foldmethod=indent

" Включить нормальную работу Backspace
set backspace=indent,eol,start

" Показывать режим работы
set showmode

" Вставка из буфера мыши
map <S-Insert> <Middlemouse>

" При вводе открывающей фигурной скобки автоматом вводится и закрывающая.
"inoremap { {<CR>}<Esc>O

" Поиск по набору текста (очень полезная функция)
set incsearch

" Отключаем подстветку найденных вариантов, и так всё видно.
set nohlsearch

" Теперь нет необходимости передвигать курсор к краю экрана, чтобы подняться в режиме редактирования
set scrolljump=7

" Теперь нет необходимости передвигать курсор к краю экрана, чтобы опуститься в режиме редактирования
set scrolloff=7

" Выключаем надоедливый "звонок"
set novisualbell
set t_vb=

" Поддержка мыши
set mouse=a
set mousemodel=popup

if &term =~ "^tmux"
        set ttymouse=sgr
endif

" Кодировка текста по умолчанию
set termencoding=utf-8

" Не выгружать буфер, когда переключаемся на другой
" Это позволяет редактировать несколько файлов в один и тот же момент без необходимости сохранения каждый раз
" когда переключаешься между ними
set hidden

" Скрыть панель в gui версии ибо она не нужна
set guioptions-=T

" Сделать строку команд высотой в одну строку
set ch=2

" Включить автоотступы
set autoindent

" Влючить подстветку синтаксиса
syntax on

" allow to use backspace instead of "x"
set backspace=indent,eol,start whichwrap+=<,>,[,]

" Преобразование Таба в пробелы
"set expandtab

"" Формат строки состояния
 " fileformat - формат файла (unix, dos); fileencoding - кодировка файла;
 " encoding - кодировка терминала; TYPE - тип файла, затем коды символа под курсором;
 " позиция курсора (строка, символ в строке); процент прочитанного в файле;
 " кол-во строк в файле;
 set statusline=%F%m%r%h%w\ [FF,FE,TE=%{&fileformat},%{&fileencoding},%{&encoding}\]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
 "Изменяет шрифт строки статуса (делает его не жирным)
 hi StatusLine gui=reverse cterm=reverse
set laststatus=2
"Проблема красного на красном при spellchecking-е решается такой строкой в .vimrc
 highlight SpellBad ctermfg=Black ctermbg=Red

" Fix <Enter> for comment
set fo+=cr

" Опции сесссий
set sessionoptions=curdir,buffers,tabpages

set showmatch " показывать парные скобки
set history=500 "длинна истории комманд
set undolevels=100 "память отмен
set background=dark "чтобы подсветка работала так как надо :-)
set mousemodel=popup
set nowrap "не рвать строки
set listchars+=precedes:<,extends:> "показывать, что строка уходит за экран
filetype plugin on
set grepprg=grep\ -nH\ $*
filetype indent on

" Переход к месту последнего редактирования
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif

" Копирование в буфер обмена иксов
set clipboard=unnamed,exclude:cons\\\|linux

set helplang=ru

" Tell the GnuPG plugin to armor new files.
let g:GPGPreferArmor=1

" Tell the GnuPG plugin to sign new files.
let g:GPGPreferSign=1

augroup GnuPGExtra
" Set extra file options.
autocmd BufReadCmd,FileReadCmd *.\(gpg\|asc\|pgp\) call SetGPGOptions()
" Automatically close unmodified files after inactivity.
autocmd CursorHold *.\(gpg\|asc\|pgp\) quit
augroup END

function SetGPGOptions()
" Set updatetime to 1 minute.
set updatetime=60000
" Fold at markers.
set foldmethod=marker
" Remove comment symbols.
set commentstring=%s
" Automaticall close all folds.
set foldclose=all
" Only open folds with insert commands.
set foldopen=insert
endfunction

" Map ctrl-movement keys to window switching
map <C-k> <C-w><Up>
map <C-j> <C-w><Down>
map <C-l> <C-w><Right>
map <C-h> <C-w><Left>

nmap <C-\> :NERDTreeFind<CR>
nmap <silent> <leader><leader> :NERDTreeToggle<CR>

" enhanced command completion
set wildmenu

" Allows you to enter sudo pass and save the file
" " when you forgot to open your file with sudo
cmap w!! %!sudo tee > /dev/null %

" Toggle paste mode
nmap <silent> <F5> :set invpaste<CR>:set paste?<CR>
imap <silent> <F5> <ESC>:set invpaste<CR>:set paste?<CR>

" Allow to copy/paste between VIM instances
" "copy the current visual selection to ~/.vbuf
vmap <Leader>y :w! ~/.vim/vbuf<CR>
" "copy the current line to the buffer file if no visual selection
nmap <Leader>y :.w! ~/.vim/vbuf<CR>
" "paste the contents of the buffer file
nmap <Leader>p :r ~/.vim/vbuf<CR>

" показывать строку вкладок всегда
set showtabline=2

" показывать имя буфера в заголовке терминала
set title

" включение подсветки невидимых символов
set list
set t_Co=256
"set confirm " использовать диалоги вместо сообщений об ошибках

" Опции авто-дополнения
set completeopt=longest,menuone

" предлагать авто-дополнение на основе уже введённого регистра
set infercase

function! ChangeBuf(cmd)
    if (&modified && &modifiable)
        execute ":w"
    endif
    execute a:cmd
endfunction
nnoremap <silent> <C-o> :call ChangeBuf(":b#")<CR>
nnoremap <silent> <C-n> :call ChangeBuf(":bn")<CR>
nnoremap <silent> <C-p> :call ChangeBuf(":bp")<CR>

call plug#begin('~/.vim/plugged')
Plug 'pearofducks/ansible-vim'
" install and use neomake linting
Plug 'neomake/neomake'
" install and use vim-markdown
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
call plug#end()

" When writing a buffer.
call neomake#configure#automake('w')
" When writing a buffer, and on normal mode changes (after 750ms).
call neomake#configure#automake('nw', 750)
" When reading a buffer (after 1s), and when writing.
call neomake#configure#automake('rw', 1000)

" для печати русскими буквами из редактора по hardcopy
set printencoding=koi8-r

" поддержка ctags
set tags=./tags,tags;$HOME

command! MarkdownPreview !python3 -m markdown % -f ~/tmp/t.html &&
 \ lynx ~/tmp/t.html
command! MarkdownUpdate !python3 -m markdown % -f ~/tmp/t.html

set colorcolumn=80
au BufRead *.md set wrap tw=80
if exists('+colorcolumn')
    highlight ColorColumn ctermbg=235 guibg=#2c2d27
    highlight CursorLine ctermbg=235 guibg=#2c2d27
    highlight CursorColumn ctermbg=235 guibg=#2c2d27
    let &colorcolumn=join(range(81,999),",")
else
    autocmd BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
end

" Поддержка отмен
silent !mkdir -p $HOME/.cache/vim/{backup,swap,undo}
set backup
set backupdir=~/.cache/vim/backup/
set swapfile
set directory=~/.cache/vim/swap/
set undofile
set undodir=~/.cache/vim/undo/

" шаблоны файлов по расширению
autocmd BufNewFile * silent! 0r $HOME/.vim/templates/templates.%:e
