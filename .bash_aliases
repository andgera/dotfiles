alias cp='cp -v'
alias links='links2'
alias reboot='/sbin/reboot'     #reboot
alias poweroff='/sbin/poweroff'  #halt
alias news='echo -n "  Запуск Newsboat RSS Reader  " | pv -qL 20 && newsboat'
alias clbin='curl -v -F "clbin=<-" https://clbin.com '
alias nstato="netstat -tuael --numeric-hosts --numeric-ports"   #netstat
alias uuid='echo -n "Listing UUID  " | pv -qL 10 && ls /dev/disk/by-uuid/ -alh'
alias toprun="ps axo %cpu,%mem,comm | sort -ur | head -n 9" #top processes
alias www='lynx'
alias wwwl='links2'
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
alias less='less -SR'
alias man='man -P /bin/most'
## Ordinary aliases:
alias egrep='egrep --color=auto'
alias cp='nocorrect cp'
alias ln='nocorrect ln'
alias mkdir='nocorrect mkdir'
alias mv='nocorrect mv'
alias rm='nocorrect rm'

## Parenting changing permissions on root
alias chown='chown --preserve-root '
alias chmod='chmod --preserve-root '
alias chgrp='chgrp --preserve-root '
alias fim='fim "@" >/dev/null 2>&1'
alias keyen='LANG=us_US.UTF-8 gtypist'
alias keyru='gtypist ru.typ'
alias batstat='upower -i /org/freedesktop/UPower/devices/battery_BAT1'
