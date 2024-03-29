## ФУНКЦИЯ ПОИСКА ПО ВИКЕПЕДИИ  ##
wikipediaSearch() {
echo -n -e "\n============================================\n\tПриветствую в поиске Wikipedia"; echo ""; i=1 ; for line in $(lynx --dump "https://ru.wikipedia.org/w/index.php?title=Special%3ASearch&profile=default&search=$1&fulltext=Search" | grep https://ru.wikipedia.org/wiki | cut -c7-); do echo $i $line; lines[$i]=$line ;  i=$(($i+1)); done ; echo -n -e "\n============================================\n\tВыбири ссылку по номеру для открытия № "; read answer; lynx ${lines[$answer]}
}

function ddg() {
        lynx "https://www.duckduckgo.com/?q=$(<<<"$*" tr ' ' '+')"
}


## Dict
mydict () {
 dictl -h dict.dvo.ru -d ! "$@" 2>&1 | colorit | fmt -w 95 | less -R ;
}

## бЫСТРЫЕ ЗАМЕТКИ : Использование: note ( note -c очистка)
note () {
    # if file doesn't exist, create it
    if [[ ! -f $HOME/.notes ]]; then
        touch "$HOME/.notes"
    fi

    if ! (($#)); then
        # нет аргументов, показать файл
        cat "$HOME/.notes"
    elif [[ "$1" == "-c" ]]; then
        # clear file
        printf "%s" > "$HOME/.notes"
    else
        # Добавит все аргументы в качестве заметки в файл
        printf "%s\n" "$*" >> "$HOME/.notes"
    fi
}

## РАЗАРХИВИРОВАНИЕ ## | Используй: extract <файл>
extract () {
  if [ -f $1 ] ; then
      case $1 in
          *.tar.bz2)   tar xvjf $1    ;;
          *.tar.gz)    tar xvzf $1    ;;
          *.tar.xz)    tar -xJvf $1   ;;
          *.bz2)       bunzip2 $1     ;;
          *.rar)       rar x $1       ;;
          *.gz)        gunzip $1      ;;
          *.tar)       tar xvf $1     ;;
          *.tbz2)      tar xvjf $1    ;;
          *.tgz)       tar xvzf $1    ;;
          *.tar.xz)     tar xvJf $1   ;;
          *.zip)       unzip $1       ;;
          *.Z)         uncompress $1  ;;
          *.7z)        7z x $1        ;;
          *)           echo "файл '$1' не похож на архив..." ;;
      esac
  else
      echo "'$1' нет файла для распаковки!"
  fi
}

## ПЕРЕХОД В КАТАЛОГ И ПОКАЗ СОДЕРЖИМОГО ## | Используй: cdf <каталог>
cdf () {
  cd "$(dirname "$(locate -i "$*" | head -n 1)")" ;
}

## ПРОГНОЗ ПОГОДЫ ## | Используй: prognoz `Город`
prognoz () {
curl -H "Accept-Language: ru" http://wttr.in/$1
}

## ПОИСК В GOOGLE | Использцй: gsearch <значение>
function gsearch {
Q="$@";
GOOG_URL='https://encrypted.google.com/search?&q=';
AGENT="Mozilla/51.0";
stream=$(curl -A "$AGENT" -skLm 50 "${GOOG_URL}${Q//\ /+}" | grep -oP '\/url\?q=.+?&amp' | sed 's|/url?q=||; s|&amp||');
echo -e "${stream//\%/\x}";
}

# mkdir & cd into it | Usage: mkcd
mkcd() {
  if [ ! -n "$1" ]; then
    echo "Enter a name for this folder"
  elif [ -d $1 ]; then
    echo "\`$1' already exists"
  else
    mkdir $1 && cd $1
  fi
}

#Search files & directories | Usage: search <file/dirs>
search() {
find . -iname "*$@*" | less;
}

#Grep process | Usage: psgrep <process>
psgrep() { ps axuf | grep -v grep | grep "$@" -i --color=auto;
}


#encrypt <file> | Usage encrypt <file>
function encrypt() {
        [ -e "$1" ] || return 1
        openssl des3 -pbkdf2 -iter 3 -salt -in "$1" -out "$1.$CRYPT_EXT"
        [ -e "$1.$CRYPT_EXT" ] && shred -u "$1"
}

#decrypt <file.> | Usage decrypt <file.>
function decrypt() {
        [ -e "$1" ] || return 1
        [ "${1%.$CRYPT_EXT}" != "$1" ] || return 2
        openssl des3 -d -pbkdf2 -iter 3 -salt -in $1 -out ${1%.$CRYPT_EXT}
        [ -e "${1%.$CRYPT_EXT}" ] && rm -f "$1"
}

#wallpaper changer
fehpap() {
        zenity --file-selection | xargs feh --bg-scale
 }

unspacer() #remove spaces from files in current dir
{          #replaces spaces with underscores
 for i in *
  do
   mv ./"$i" ./$(echo $i | tr '\ ' '_')
  done
}



#youtube pvideo/audio | Usage ytdlhd <url>
ytdlhd() {
    youtube-dl "$1" -f 18
}

#extract audio in mp3 format | Usage ytdlmp3 <url>
ytdlmp3() {
    #   youtube-dl -v --no-mtime -o '%(stitle)s.%(ext)s' --extract-audio --audio-format mp3  "$1"
        youtube-dl --extract-audio --audio-format mp3 -v --no-mtime -o "%(title)s.%(ext)s" "$1"
}

ytconvert() {
        ffmpeg -i "$1" -c:v libx264 -crf 18 -preset slow -pix_fmt yuv420p -c:a copy "$2.mkv"
}

stopwatch(){
    date1=`date +%s`;
    while true; do
    days=$(( $(($(date +%s) - date1)) / 86400 ))
    echo -ne "$days day(s) and $(date -u --date @$((`date +%s` - $date1)) +%H:%M:%S)\r";
    sleep 0.1
    done
}

## РАСКРАСИТЬ ВЫВОД MAN СТРАНИЦ ##
#man() {
#    LESS_TERMCAP_md=$'\e[01;31m' \
#    LESS_TERMCAP_me=$'\e[0m' \
#    LESS_TERMCAP_se=$'\e[0m' \
#    LESS_TERMCAP_so=$'\e[01;44;33m' \
#    LESS_TERMCAP_ue=$'\e[0m' \
#    LESS_TERMCAP_us=$'\e[01;32m' \
#    command man "$@"
#}

#Fill screen with colours | Usage: colours
colours()
{
  _I=1
  _J=0
  _K=0
  _WIDTH=$COLUMNS
  _MARGIN=0
  while true; do
  _A=$(($RANDOM % 3))
  _B=$(($RANDOM % 2))
  _C=$(($RANDOM % 3))
  case $_A in
  0)
    case $_B in
    0)
      [ $_I -gt 1 ] && _I=$(($_I - 1))
    ;;
    1)
      [ $_I -lt 6 ] && _I=$(($_I + 1))
    ;;
    esac
  ;;
  1)
    case $_B in
    0)
      [ $_J -gt 0 ] && _J=$(($_J - 1))
    ;;
    1)
      [ $_J -lt 5 ] && _J=$(($_J + 1))
    ;;
    esac
  ;;
  2)
    case $_B in
    0)
      [ $_K -gt 0 ] && _K=$(($_K - 1))
    ;;
    1)
      [ $_K -lt 5 ] && _K=$(($_K + 1))
    ;;
    esac
  ;;
  esac
  case $1 in
    1)
      _DELTA=$2
      case $_C in
        0)
          [ $_WIDTH -lt $(($COLUMNS - 2*$_DELTA)) ] && _WIDTH=$(($_WIDTH + 2*$_DELTA))
        ;;
        1)
          [ $_WIDTH -gt $((1 + 2*$_DELTA)) ] && _WIDTH=$(($_WIDTH - 2*$_DELTA))
        ;;
      esac
      _MARGIN=$((($COLUMNS-$_WIDTH)/2))
    ;;
    2)
      _WIDTH=$2
      _DELTA=$3
      case $_C in
        0)
          [ $_MARGIN -le $(($COLUMNS - $_WIDTH - $_DELTA)) ] && _MARGIN=$(($_MARGIN + $_DELTA))
        ;;
        1)
          [ $_MARGIN -ge $_DELTA ] && _MARGIN=$(($_MARGIN - $_DELTA))
        ;;
      esac
    ;;
    *)
      _WIDTH=$COLUMNS
      _MARGIN=0
    ;;
  esac
  _NUMBER=$((15 + $_I + 6*$_J + 36*$_K))

  echo -en "\e[0;49m"
  if [ $_MARGIN -gt 0 ]; then
    for _FOO in $(seq $_MARGIN); do
      echo -en " "
    done
  fi

  printf "\e[0;48;5;${_NUMBER}m"
  for _FOO in $(seq $_WIDTH); do
    echo -en " "
  done

  echo -e "\e[0;49m"
  done
}

