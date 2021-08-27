# 
#
alias cp='cp -v'
alias links='links2'
alias reboot='/sbin/reboot'     #reboot
alias poweroff='/sbin/poweroff'  #halt
alias news='echo -n "  Запуск Newsbeuter RSS Reader  " | pv -qL 20 && newsbeuter'
alias clbin='curl -v -F "clbin=<-" https://clbin.com '
alias nstato="netstat -tuael --numeric-hosts --numeric-ports"   #netstat
alias mount='mount |column -t'
alias uuid='echo -n "Listing UUID  " | pv -qL 10 && ls /dev/disk/by-uuid/ -alh'
alias toprun="ps axo %cpu,%mem,comm | sort -ur | head -n 9" #top processes
alias www='links2'
alias grep='grep --color'
alias egrep='egrep --color'
alias i3help='less ~/.config/i3/README'
alias ytdl="youtube-viewer -d"                  #youtube-viewer download -[URL]
alias menu='cd "$(ls | dmenu -nb "#100" -nf "#b9c0af" -sb "#000" -sf "#cb4b16" -i)"'
alias open='xdg-open'
alias mountpi="sshfs -p 22 andrey@192.168.67.1:/home/andrey /mnt/rpi"
alias umountpi="sudo umount /mnt/rpi"
alias vih='less ~/.vim/MyFAQ.txt'
alias yandex='mutt -F ~/.mutt/admin'
alias mouse_on='setxkbmap -option keypad:pointerkeys'
alias myip='links -source http://www.formyip.com/ | grep "Your IP" | grep -oP "(\d{1,3}\.){3}\d{1,3}"'
alias man='man -P most'
