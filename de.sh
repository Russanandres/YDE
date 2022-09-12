#!/bin/bash
VER="1.0"
startuptime=$(date)
userdata="~/.config/YDE"
int=/usr/bin/runui
source ~/.config/YDE/settings.conf

function pause(){ read -p "Press ENTER to continue...."
}
function exitscr(){
 kill "$!"
 clear
 echo Your Desktop Environment $VER - 2022-2022. Russanandres
 date
 exit
}
function loading() {
    local i sp n
    sp='/-\|'
    n=${#sp}
    printf ' '
    while sleep 0.1; do
        printf "%s\b" "${sp:i++%n:1}"
    done
}
trap "exitscr" SIGINT
if [ -f "$int" ]; then
 inst="true "
else
 inst=false
fi

if [ "$1" == "-v" ]; then echo $VER; exit
elif [ "$1" == "--version" ]; then
 echo Your Desktop Environment $VER by Russanandres.
 echo Thanks for using!
 exit
elif [ "$1" == "--help" ] || [ "$1" == "-h" ]; then
 echo Your Desktop Environment
 echo Shell TTY DE
 echo
 echo Avialible commands:
 echo To try YDE without installion run with -p or --portable
 echo To check version run with -v or --version
 echo To backup your YDE folder run with --backup
 echo To check YDE files and repair it run with --check
 echo To force quit run with -fq or --force-quit
 echo To erase all settings run with --erase-all-content
 echo To install in other directory run with --target /path/exitfile
#  echo To install in other userdata run with --userdata /path
 echo To run compatibility mode run with -com or --compatibility-mode
 echo To see all arguments run with -p or --help
 exit
elif [ "$1" == "--backup" ]; then
 cp -r ~/.config/YDE ~/.config/YDE/old/$(date +%d-%m-%y)
 cp $int ~/.config/YDE/old/$(date +%d-%m-%y)
elif [ "$1" == "--check" ]; then
function check(){
sudo mkdir /usr/share/YDE
mkdir ~/.config/YDE/
mkdir ~/.config/YDE/themes
mkdir ~/.config/YDE/languages
mkdir ~/.config/YDE/old
mkdir ~/.config/YDE/apps
touch ~/.config/YDE/settings.conf
sudo touch /usr/share/YDE/settings.conf
echo All files has been created or checked
echo
echo -e "Press any button.\c"
read -sn1 ch
}
check
elif [ "$1" == "--force-quit" ] || [ "$1" == "-fq" ]; then exitscr
elif [ "$1" == "--compatibility-mode" ] || [ "$1" == "-com" ]; then
 curl -s https://raw.githubusercontent.com/Russanandres/YDE/main/YDE_fallback.sh | bash
elif [ "$1" == "--erase-all-content" ]; then
 rm /tmp/updatingYDE.tmp
 rm ~/.config/YDE/settings.conf
 sudo rm /usr/share/YDE/settings.conf
 touch ~/.config/YDE/settings.conf
 sudo touch /usr/share/YDE/settings.conf
 if [ "$?" == "1" ]; then check; fi
elif [ "$1" == "--target" ]; then
 if [ -z "$2" ]; then
 echo Please type path and exit file after --target
 echo like --target /usr/bin/yde
 echo
 echo Your Desktop Environment $VER - 2021-2022. Russanandres
 date
 exit
 else int=$2
 fi
elif [ "$1" == "--userdata" ]; then
  if [ -z "$2" ]; then
 echo a >> /dev/null
 else
 userdatanew=$2
 echo userdata=$userdatanew >> $userdata/settings.conf
 fi
elif [ "$3" == "--userdata" ]; then
  if [ -z "$4" ]; then
 echo a >> /dev/null
 else
 userdatanew=$2
 echo userdata=$userdatanew >> $userdata/settings.conf
 fi
elif [ "$1" == "-p" ] || [ "$1" == "--portable" ]; then portable=true
elif [ "$@" != "--run" ]; then
 echo This run argument is not exist! Use --help to see all avialible arguments.
 echo YDE $VER
 exit
fi
clear

if [ "$startupcheckupdate" == "enable" ]; then
loading &
 gitver=$(curl -f -# https://raw.githubusercontent.com/Russanandres/YDE/main/lastversion)
 if [ "$VER" == "$gitver" ]; then
  echo all ok
  sleep 0.5
 elif [ "$gitver" -gt "$VER" ]; then
  echo You have old version of script! Please update it!
  pause
 elif [ "$gitver" -lt "$VER" ]; then
  echo You have newer version, than repository! Please create issue in github!
  pause
 fi
kill "$!"
fi

if [ -f "/tmp/updatingYDE.tmp" ]; then
loading &
sudo rm $int
sudo cp ./de.sh $int
sudo chmod +x $int
sleep 2
kill "$!"
clear
fi

if [ ! -f "$HOME/.config/YDE/settings.conf" ]; then
echo "Your data folder is corrupted!"
echo
echo "Recreate? [Y/n]"
read -sn1 rec
case "$rec" in
"Y"|"y" )
mkdir ~/.config/YDE/
mkdir ~/.config/YDE/themes
mkdir ~/.config/YDE/languages
mkdir ~/.config/YDE/old
mkdir ~/.config/YDE/apps
touch ~/.config/YDE/settings.conf
touch ~/.config/YDE/apps/list
echo THEME=classic >> ~/.config/YDE/settings.conf
echo int=$int >> ~/.config/YDE/settings.conf;;
esac
elif [ "$1" == "-p" ] || [ "$1" == "--portable" ]; then echo a
fi

if [ -f "$int" ] || [ "$1" == "-p" ] || [ "$1" == "--portable" ]; then
clear
echo Loading Your Desktop Environment...
echo
loading &
screen=startingup
source /usr/share/YDE/settings.conf
if [ "$fastboot" == "true" ]; then
echo
else
sleep 1
fi
printf '\033[8;27;104t'
kill "$!"
while true; do
function start(){
screen=start
clear
echo "┌───────────────────────────────────────────── Homescreen ─────────────────────────────────────────────┐"
echo "│                                                                                                      │"
echo "│  ┌───┐            ┌───┐               ┌───┐                                                          │"
echo "│  │ A │ About YDE  │ M │ Misc          │ X │ Clock                                                    │"
echo "│  └───┘            └───┘               └───┘                                                          │"
echo "│  ┌───┐            ┌───┐                                                                              │"
echo "│  │ E │ Exit YDE   │ C │ Configurator                                                                 │"
echo "│  └───┘            └───┘                                                                              │"
echo "│  ┌───┐                                                                                               │"
echo "│  │ P │ Poweroff                                                                                      │"
echo "│  └───┘                                                                                               │"
echo "│  ┌───┐                                                                                               │"
echo "│  │ D │ Desktop                                                                                       │"
echo "│  └───┘                                                                                               │"
echo "│                                                                                                      │"
echo "│                                                                                                      │"
echo "│                                                                                                      │"
echo "│                                                                                                      │"
echo "│                                                                                     ┌───┐            │"
echo "│                                                                                     │ Q │ Your apps  │"
echo "│  [W] All apps                                                                       └───┘            │"
echo "│                                                                                                      │"
echo "├──────────────────────────────────────────────────────────────────────────────────────────────────────┤"
echo "│ [YDE] $VER                                                                         [$(date +%D)] [$(date +%H:%M)] │"
echo "└──────────────────────────────────────────────────────────────────────────────────────────────────────┘"
read -sn1 ch
case "$ch" in
"S"|"s" ) desktop;;
"Y"|"y" ) about;;
"A"|"a" ) about;;
"E"|"e" ) exitscr;;
"P"|"p" ) clear; echo "Shut Down? [Y/n]"; read -sn1 ch; case "$ch" in "Y"|"y") sudo poweroff; esac;;
"D"|"d" ) desktop;;
"W"|"w" ) apps;;

"M"|"m" ) settings;;
"C"|"c" ) configurator;;
"Q"|"q" ) yourapps;;

"X"|"x" ) clock;;
"="|"+" ) scrsvr;;
esac
}

function apps(){
screen=apps
clear
echo "┌─────────────────────────────────────────── Homescreen apps ──────────────────────────────────────────┐"
echo "│                                                                                                      │"
echo "│  ┌───┐                                                                                               │"
echo "│  │ H │ Homescreen                                                                                    │"
echo "│  └───┘                                                                                               │"
echo "│  ┌───┐                                                                                               │"
echo "│  │ D │ Desktop                                                                                       │"
echo "│  └───┘                                                                                               │"
echo "│  ┌───┐                                                                                               │"
echo "│  │ F │ MC FM                                                                                         │"
echo "│  └───┘                                                                                               │"
echo "│  ┌───┐                                                                                               │"
echo "│  │ B │ Browser                                                                                       │"
echo "│  └───┘                                                                                               │"
echo "│                                                                                                      │"
echo "│                                                                                                      │"
echo "│                                                                                                      │"
echo "│                                                                                                      │"
echo "│                                                                                     ┌───┐            │"
echo "│                                                                                     │ Y │ Your apps  │"
echo "│                                                                                     └───┘            │"
echo "│                                                                                                      │"
echo "├──────────────────────────────────────────────────────────────────────────────────────────────────────┤"
echo "│ [S] Back to Homescreen                                                            [$(date +%D)] [$(date +%H:%M)] │"
echo "└──────────────────────────────────────────────────────────────────────────────────────────────────────┘"
# echo Battery - [$(cat /sys/class/power_supply/BAT1/capacity)%]
read -sn1 ch
case "$ch" in
"H"|"h" ) start;;
"W"|"w" ) start;;
"D"|"d" ) desktop;;
"S"|"s" ) start;;
"B"|"b" ) w3m google.com;;
"F"|"f" ) mc;;

"Y"|"y" ) yourapps;;
esac
}

function scrsvr(){
# desktop &
while sleep 1; do
desktop &
done
}



########################################################################## Comment debug menu before release



function desktop(){
screen=desktop
clear
echo "┌──────────────────────────────────────────── Your Desktop ────────────────────────────────────────────┐"
echo "│                                                                             Now is:                  │"
echo "│ [1] - Back to Command line                                              $(date +%D) $(date +%H:%M:%S)            │"
echo "│                                                                                $(date +%a)                    │"
echo "│                                                                                                      │"
echo "│                                                                                                      │"
echo "│                                                                                                      │"
echo "│                  \`8.\`8888.      ,8' 8 888888888o.      8 8888888888                                  │"
echo "│                   \`8.\`8888.    ,8'  8 8888    \`^888.   8 8888                                        │"
echo "│                    \`8.\`8888.  ,8'   8 8888        \`88. 8 8888                                        │"
echo "│                     \`8.\`8888.,8'    8 8888         \`88 8 8888                                        │"
echo "│                      \`8.\`88888'     8 8888          88 8 888888888888                                │"
echo "│                       \`8. 8888      8 8888          88 8 8888                                        │"
echo "│                        \`8 8888      8 8888         ,88 8 8888                                        │"
echo "│                         8 8888      8 8888        ,88' 8 8888                                        │"
echo "│                         8 8888      8 8888    ,o88P'   8 8888                                        │"
echo "│                         8 8888      8 888888888P'      8 888888888888                                │"
echo "│                                                                                                      │"
echo "│                                                                                                      │"
echo "│                                                                                                      │"
echo "│                                                                                                      │"
echo "│                                                                                                      │"
echo "├──────────────────────────────────────────────────────────────────────────────────────────────────────┤"
echo "│ [S] Homescreen                                                                 [$(date +%D)] [$(date +%H:%M:%S)] │"
echo "└──────────────────────────────────────────────────────────────────────────────────────────────────────┘"
read -sn1 ch
case "$ch" in
"S"|"s" ) start;;
"1" ) exitscr;;
"=" ) debug;;
esac
}

function yourapps(){
screen=yourapps
if ! [ -d ~/.config/YDE/apps ]; then
clear
echo "I'm a teapot!"
mkdir ~/.config/YDE/apps
sleep 1
exit 418
fi
clear
echo "──────────── Your Apps ────────────"
echo "- Type yahelp to see wiki"
echo "- Type edesk to exit to desktop"
echo "- Apps list:"
echo
ls -xX1 ~/.config/YDE/apps/
# cat ~/.config/YDE/apps/list
echo
read selapp
if [ "$selapp" == "yahelp" ]; then
clear
echo "- Type app name to start it"
echo "- We are tested only shell scripts now"
echo "- Then you are started app, YDE keeps running in background"
echo "- To add your app in list, see instruction on github."
pause
elif [ "$selapp" == "edesk" ]; then
desktop
fi
source ~/.config/YDE/apps/$selapp
if [ "$sudo" == "1" ]; then
sudo bash $run
elif [ "$sudo" == "0" ]; then
bash $run
fi
}


function about(){
screen=about
clear
echo "┌──────────────────────────────────────────── About Desktop ───────────────────────────────────────────┐"
echo "│ Your Desktop Environment                                                                             │"
echo "│ Version $VER                                                                                          │"
echo "│                                                                                                      │"
echo "│                                                                                                      │"
echo "│                                                                                                      │"
echo "│                                                                                                      │"
echo "│                  \`8.\`8888.      ,8' 8 888888888o.      8 8888888888                                  │"
echo "│                   \`8.\`8888.    ,8'  8 8888    \`^888.   8 8888                                        │"
echo "│                    \`8.\`8888.  ,8'   8 8888        \`88. 8 8888                                        │"
echo "│                     \`8.\`8888.,8'    8 8888         \`88 8 8888                                        │"
echo "│                      \`8.\`88888'     8 8888          88 8 888888888888                                │"
echo "│                       \`8. 8888      8 8888          88 8 8888                                        │"
echo "│                        \`8 8888      8 8888         ,88 8 8888                                        │"
echo "│                         8 8888      8 8888        ,88' 8 8888                                        │"
echo "│                         8 8888      8 8888    ,o88P'   8 8888                                        │"
echo "│                         8 8888      8 888888888P'      8 888888888888                                │"
echo "│                                                                                                      │"
echo "│                                                                                                      │"
echo "│                                                                                                      │"
echo "│                                                                                                      │"
echo "│                                                                                by Russanandres 2022  │"
echo "├──────────────────────────────────────────────────────────────────────────────────────────────────────┤"
echo "│ [S] Homescreen                                                                    [$(date +%D)] [$(date +%H:%M)] │"
echo "└──────────────────────────────────────────────────────────────────────────────────────────────────────┘"
read -sn1 ch
case "$ch" in
"S"|"s" ) start;;
"D"|"d" ) desktop;;
esac
}

function settings(){
screen=settings
clear
echo "┌────────────────────────────────────────── Desktop Settings ──────────────────────────────────────────┐"
echo "│                                                                                                      │"
echo "│ [T] Theme - $THEME                                                                                  │"
echo "│ [-] Installed - $inst                                                                                │"
echo "│                                                                                                      │"
echo "│ [U] Check Update                                                                                     │"
echo "│ [Q] Reinstall from de.sh                                                                             │"
echo "│ [R] Remove YDE                                                                                       │"
echo "│                                                                                                      │"
echo "│ [C] Compatibility mode                                                                               │"
echo "│                                                                                                      │"
echo "│                                                                                                      │"
echo "│                                                                                                      │"
echo "│                                                                                                      │"
echo "│                                                                                                      │"
echo "│                                                                                                      │"
echo "│                                                                                                      │"
echo "│                                                                                                      │"
echo "│                                                                                                      │"
echo "│  [F] Enable Fast boot [o] - disable                                                                  │"
echo "│  [L] Turn-on loading animation [k] - Turn off                                                        │"
echo "│                                                                                                      │"
echo "├──────────────────────────────────────────────────────────────────────────────────────────────────────┤"
echo "│ [S] Homescreen                                                                    [$(date +%D)] [$(date +%H:%M)] │"
echo "└──────────────────────────────────────────────────────────────────────────────────────────────────────┘"
read -sn1 ch
case "$ch" in
# "T" )
# themes;;
"U"|"u" ) update;;
"R"|"r" ) remove;;
"Q"|"q" ) reinstall;;
# "T"|"t" ) themes;;
"C"|"c" ) curl -s https://raw.githubusercontent.com/Russanandres/YDE/main/YDE_fallback.sh | bash;;
"S"|"s" ) start;;
"D"|"d" ) desktop;;
"l" ) loading &;;
"k" ) kill "$!";;
"f" ) echo fastboot=true >> ~/.config/YDE/settings.conf;;
"o" ) echo fastboot=false >> ~/.config/YDE/settings.conf;;
esac
}

function clock(){
clear
while sleep 1; do
clear
echo "┌──────────────────────────────────────────── Screen clock ────────────────────────────────────────────┐"
echo "│                                                                                                      │"
echo "│                                                                                                      │"
echo "│                                                                                                      │"
echo "│                                                                                                      │"
echo "│                                                                                                      │"
echo "│              ┌Clock────────────────┐                                                                 │"
echo "│              │                     │                                                                 │"
echo "│              │      Now is:        │                                                                 │"
echo "│              │  $(date +%D) $(date +%H:%M:%S)  │                                                                 │"
echo "│              │         $(date +%a)          │                                                                 │"
echo "│              │                     │                                                                 │"
echo "│              └─────────────────────┘                                                                 │"
echo "│                                                                   ___  _ ____  _____                 │"
echo "│                                                                   \  \///  _ \/  __/                 │"
echo "│                                                                    \  / | | \||  \                   │"
echo "│                                                                    / /  | |_/||  /_                  │"
echo "│                                                                   /_/   \____/\____\                 │"
echo "│                                                                                                      │"
echo "│                                                                                                      │"
echo "│                                                                                                      │"
echo "│                                                                                                      │"
echo "├──────────────────────────────────────────────────────────────────────────────────────────────────────┤"
echo "│ Press CTRL + C to exit to desktop                                                                    │"
echo "└──────────────────────────────────────────────────────────────────────────────────────────────────────┘"
trap "desktop" EXIT
done
}


### Under construction things
function resscr(){
rm -f ~/.config/YDE/restartyde.sh
touch ~/.config/YDE/restartyde.sh
echo "#!/bin/bash
while sleep 1; do
ps -ax | grep runui | grep -v grep >> /dev/null
if [ "\$?" == "1" ]; then
/usr/bin/runui
fi
done
" >> ~/.config/YDE/restartyde.sh
chmod +x ~/.config/YDE/restartyde.sh
echo "bash ~/.config/YDE/restartyde.sh &" | at now
}

function filepicker(){
ls -la
echo type your file
read file
mpv $file --no-audio-display
pause
}


function calculator(){
screen=calc
echo "enter first value:"
read x
echo "enter second value"
read y
echo "enter action symbol"
read act
case $act in
"+") echo " $x + $y ="  $(expr $y + $x);;
"-") echo "$x - $y ="   $(expr $x - $y);;
"/") if [ $y -eq 0 ]; then
       echo "error: delimiter by zero";
     else
       echo " $x / $y =" $(expr  $x / $y);
     fi;;
"*") echo " $x * $y =" $(expr  $x \* $y);;
*) echo "command is unknown!"
esac
clear
echo "┌───────────────────────────────────────────── Calculator ─────────────────────────────────────────────┐"
echo "│                                                                                                      │"
echo "│                                                                                                      │"
echo "│                        ┌───────────────────────────────────────┐                                     │"
echo "│                        │                                       │                                     │"
echo "│                        │                                       │                                     │"
echo "│                        │                                       │                                     │"
echo "│                  \`8.\  │                                       │ 88888                               │"
echo "│                   \`8.  │                                       │                                     │"
echo "│                    \`8  │                                       │                                     │"
echo "│                     \`  │                                       │                                     │"
echo "│                      \ │                                       │ 888888                              │"
echo "│                        │                                       │                                     │"
echo "│                        │                                       │                                     │"
echo "│                        │                                       │                                     │"
echo "│                        │                                       │                                     │"
echo "│                        │                                       │ 88888                               │"
echo "│                        │                                       │                                     │"
echo "│                        │                                       │                                     │"
echo "│                        └───────────────────────────────────────┘                                     │"
echo "│                                                                                                      │"
echo "│                                                                                                      │"
echo "├──────────────────────────────────────────────────────────────────────────────────────────────────────┤"
echo "│ [S] Homescreen                                                                    [$(date +%D)] [$(date +%H:%M)] │"
echo "└──────────────────────────────────────────────────────────────────────────────────────────────────────┘"
read -sn1 uc
}

function debug(){
screen=desktop
clear
echo This is under construction things. Use with caution!
echo
echo = - desktop
echo
echo m - filepicker
echo c - calculator
echo t - themes
echo s - scrsvr
read ch
case "$ch" in
"=" ) screen=desktop; desktop;;
"m" ) filepicker;;
"c" ) calculator;;
"t" ) themes;;
"s" ) scrsvr;;
esac
debug
}
if [ "$1" == "--func" ]; then
$2
fi



function themes(){
screen=themes
clear
echo "┌─────────────────────────────────────────── Theme Settings ───────────────────────────────────────────┐"
echo "│                                                                                                      │"
echo "│ Active theme - $THEME                                                                               │"
echo "│                                                                                                      │"
echo "│                                                                                                      │"
echo "│                                                                                                      │"
echo "│                                                                                                      │"
echo "│                                                                                                      │"
echo "│                                                                                                      │"
echo "│                                                                                                      │"
echo "│                                                                                                      │"
echo "│                                                                                                      │"
echo "│                                                                                                      │"
echo "│                                                                                                      │"
echo "│                                                                                                      │"
echo "│                                                                                                      │"
echo "│                                                                                                      │"
echo "│                                                                                                      │"
echo "│                                                                                                      │"
echo "│                                                                                                      │"
echo "│                                                                                                      │"
echo "│  There is no custom themes support done yet((                                                        │"
echo "│                                                                                                      │"
echo "├──────────────────────────────────────────────────────────────────────────────────────────────────────┤"
echo "│ [S] Homescreen                                                                    [$(date +%D)] [$(date +%H:%M)] │"
echo "└──────────────────────────────────────────────────────────────────────────────────────────────────────┘"
pause
}


function configurator(){
screen=configurator
printf '\033[8;27;107t'
clear
parts=5
echo
echo "   ┌────────────────────────────────────────────────────────────────────────────────────────────────────┐"
echo "   │YDE Configurator                                                                      [part 1 of $parts] │"
echo "   └────────────────────────────────────────────────────────────────────────────────────────────────────┘"
echo
echo
echo "      Welcome to the YDE Configurator."
echo
echo "      We will ask you questions to set up the environment."
echo "      Application changes will be after all questions."
echo
echo "       - Press ENTER to continue."
echo "       - Press CTRL + C to exit."
echo
pause
clear
echo
echo "   ┌────────────────────────────────────────────────────────────────────────────────────────────────────┐"
echo "   │YDE Configurator                                                                      [part 2 of $parts] │"
echo "   └────────────────────────────────────────────────────────────────────────────────────────────────────┘"
echo
echo
echo "        Download ALL needed parts?"
echo "        [ncal, wget, dialog, bash, sudo]"
echo
echo "         - Type [Y] to Download."
echo "         - Type [N] to Continue."
echo
read -sn1 two
clear
echo
echo "   ┌────────────────────────────────────────────────────────────────────────────────────────────────────┐"
echo "   │YDE Configurator                                                                      [part 3 of $parts] │"
echo "   └────────────────────────────────────────────────────────────────────────────────────────────────────┘"
echo
echo
echo "        Enable startup update checker?"
echo
echo "         - Type [Y] to Enable."
echo "         - Type [N] to Diasble."
echo
read -sn1 three
clear
echo
echo "   ┌────────────────────────────────────────────────────────────────────────────────────────────────────┐"
echo "   │YDE Configurator                                                                      [part 4 of $parts] │"
echo "   └────────────────────────────────────────────────────────────────────────────────────────────────────┘"
echo
echo
echo "        Apply current configuration for all users?"
echo
echo "         - Type [Y] to Enable."
echo "         - Type [N] to Diasble."
echo
read -sn1 four
clear
echo
echo "   ┌────────────────────────────────────────────────────────────────────────────────────────────────────┐"
echo "   │YDE Configurator                                                                      [part 5 of $parts] │"
echo "   └────────────────────────────────────────────────────────────────────────────────────────────────────┘"
echo
echo
echo "        Run YDE After logining in TTY?"
echo "        We just write [/usr/bin/runui] in .bash_profile"
echo "        WARNING!"
echo "        You will need delete this line with text editor yourself if you want to disable it!"
echo
echo "         - Type [Y] to Enable."
echo "         - Type [N] to Continue."
echo
read -sn1 five
clear
echo
echo "   ┌────────────────────────────────────────────────────────────────────────────────────────────────────┐"
echo "   │YDE Configurator                                                                      [part 6 of $parts] │"
echo "   └────────────────────────────────────────────────────────────────────────────────────────────────────┘"
echo
echo
echo "        Enable Fastboot?"
echo
echo "         - Type [Y] to Enable."
echo "         - Type [N] to Diasble."
echo
read -sn1 six
# clear
# echo
# echo "   ┌──────────────────────────────────────────────────────────────────────────────────────────────────────┐"
# echo "   │YDE Configurator                                                                        [part 5 of $parts] │"
# echo "   └──────────────────────────────────────────────────────────────────────────────────────────────────────┘"
# echo
# echo
# echo "        Choose resolution"
# echo
# echo "         - Type [S] to Standart resolution."
# echo "         - Type [U] to Ultra-Wide resolution."
# echo "         - Type [L] to Low resolution."
# echo "         - Type [G] to Graphical Dialog menu."
# echo "         - Type [N] to Text menu."
# echo
# read -sn1 five
### Не возможно сделать на текущем этапе развития. Оставленно на будущее.
# clear
# echo
# echo "   ┌──────────────────────────────────────────────────────────────────────────────────────────────────────┐"
# echo "   │YDE Configurator                                                                        [part 6 of $parts] │"
# echo "   └──────────────────────────────────────────────────────────────────────────────────────────────────────┘"
# echo
# echo
# echo "        Choose language:"
# echo
# curl https://raw.githubusercontent.com/Russanandres/YDE/main/langs/lang.list
# echo
# echo "        Please type your language"
# echo
# read langscr
# wget -q -O /tmp/lang.$langscr //raw.githubusercontent.com/Russanandres/YDE/main/langs/lang.$langscr
# source /tmp/ydelang.$langscr
case "$two" in
"Y"|"y" ) sudo apt install -y ncal dialog wget bash w3m w3m-img mc mpv aplay ; apt install -y ncal dialog wget bash sudo w3m w3m-img mc mpv aplay ;;
esac


case "$three" in
"Y"|"y" ) echo startupcheckupdate=enable >> ~/.config/YDE/settings.conf;;
"N"|"n" ) echo startupcheckupdate=disable >> ~/.config/YDE/settings.conf;;
esac


case "$four" in
"Y"|"y" ) sudo rm /usr/share/YDE/settings.conf; sudo cp ~/.config/YDE/settings.conf /usr/share/YDE/settings.conf;;
"N"|"n" ) sudo rm /usr/share/YDE/settings.conf; sudo touch /usr/share/YDE/settings.conf;;
esac


case "$five" in
"Y"|"y" ) echo /usr/bin/runui >> $HOME/.bash_profile;;
esac


case "$six" in
"Y"|"y" ) echo fastboot=true >> ~/.config/YDE/settings.conf;;
"N"|"n" ) echo fastboot=false >> ~/.config/YDE/settings.conf;;
esac

printf '\033[8;27;104t'


# case "$five" in
# "S"|"s" ) echo not done;;
# "U"|"u" ) echo not done;;
# "L"|"l" ) echo not done;;
# "G"|"g" ) echo not done;;
# "N"|"n" ) echo not done;;
# esac
desktop
}


function update(){
screen=update
printf '\033[8;27;107t'
clear
echo
echo "   ┌────────────────────────────────────────────────────────────────────────────────────────────────────┐"
echo "   │ YDE Updater                                                                          [part 1 of 2] │"
echo "   └────────────────────────────────────────────────────────────────────────────────────────────────────┘"
echo
echo
echo "      Welcome to the YDE update system."
echo
echo "      We are downloading the latest version from the github site on the official repository."
echo "      Please check your internet connection."
echo
echo "       - Press ENTER to update."
echo "       - Press CTRL + C to exit."
echo
pause
clear
echo
echo "   ┌────────────────────────────────────────────────────────────────────────────────────────────────────┐"
echo "   │ YDE Updater                                                                          [part 2 of 2] │"
echo "   └────────────────────────────────────────────────────────────────────────────────────────────────────┘"
echo
echo
echo "    We updating your Desktop Environment..."
loading &
# if [ "$(wc -l ~/.config/YDE/settings.conf | head -c1)" -gt "30" ]; then
# break
# else
# echo Sorry, but we need to erase all your settings. You have 3 second to press CTRL + C and save your config file in ~/.config/YDE/settings.conf
# sleep 3
# rm ~/.config/YDE/settings.conf
# fi
touch /tmp/updatingYDE.tmp
wget https://raw.githubusercontent.com/Russanandres/YDE/main/de.sh
bash de.sh
printf '\033[8;27;104t'
}


function reinstall(){
screen=reinstall
printf '\033[8;27;107t'
clear
echo
echo "   ┌────────────────────────────────────────────────────────────────────────────────────────────────────┐"
echo "   │ YDE reInstallion                                                                     [part 1 of 1] │"
echo "   └────────────────────────────────────────────────────────────────────────────────────────────────────┘"
echo
echo
echo "      Hello!"
echo
echo "      We are reinstalling your YDE."
echo "      Please wait."
loading &
sudo rm $int
sudo cp ./de.sh $int
sudo chmod +x $int
sleep 2
kill "$!"
exitscr
}

function remove(){
screen=remove
printf '\033[8;27;107t'
clear
echo
echo "   ┌────────────────────────────────────────────────────────────────────────────────────────────────────┐"
echo "   │ YDE deInstallion                                                                     [part 1 of 4] │"
echo "   └────────────────────────────────────────────────────────────────────────────────────────────────────┘"
echo
echo
echo "      Hello!"
echo
echo "      We are very sorry that you have to uninstall YDE."
echo "      If you have any problems, please create an issue on github."
echo
echo "       - Press ENTER to uninstall."
echo "       - Press CTRL + C to exit."
echo
pause
clear
echo
echo "   ┌────────────────────────────────────────────────────────────────────────────────────────────────────┐"
echo "   │ YDE deInstallion                                                                     [part 2 of 4] │"
echo "   └────────────────────────────────────────────────────────────────────────────────────────────────────┘"
echo
echo
echo "        Do you want delete all user data?"
echo "        Please type caps letters."
echo
echo "         - Type [Y] to Delete."
echo "         - Type [N] to NOOOOO."
echo
read -sn1 deluserdata
clear
echo
echo "   ┌────────────────────────────────────────────────────────────────────────────────────────────────────┐"
echo "   │ YDE deInstallion                                                                     [part 3 of 4] │"
echo "   └────────────────────────────────────────────────────────────────────────────────────────────────────┘"
echo
echo
echo "   We uninstalling YDE. Please wait."
echo
loading &
sudo rm $int
if [ "$deluserdata" == "Y" ]; then
cp ~/.config/YDE /tmp/YDE/$USER/
cp /usr/share/YDE /tmp/YDE/system/
sudo rm -rf ~/.config/YDE
sudo rm -rf /usr/share/YDE
rm -rf ~/.config/YDE
sleep 2
fi
kill "$!"
clear
echo
echo "   ┌────────────────────────────────────────────────────────────────────────────────────────────────────┐"
echo "   │ YDE deInstallion                                                                     [part 4 of 4] │"
echo "   └────────────────────────────────────────────────────────────────────────────────────────────────────┘"
echo
echo
echo "      YDE has been successfully uninstalled on your PC!"
echo
echo "      We are waiting for you again!"
echo "      All your and system settings temporally saved in /tmp/YDE."
echo "      The uninstaller will close in a couple of seconds."
echo
sleep 3
exitscr
}



if [ "$1" == "--scr" ]; then scrsvr; fi
if [ "$screen" == "startingup" ]; then
 desktop
else
 $screen
fi







done
else
printf '\033[8;27;107t'
clear
echo
echo "   ┌────────────────────────────────────────────────────────────────────────────────────────────────────┐"
echo "   │ YDE Installion                                                                       [part 1 of 3] │"
echo "   └────────────────────────────────────────────────────────────────────────────────────────────────────┘"
echo
echo
echo "      Welcome to the first boot of YDE!"
echo
echo "      This pseudo-graphical shell will try to make you comfortable in the terminal."
echo "      The environment will now be installed on your computer."
echo
echo "       - Press ENTER to continue"
echo "       - Press CTRL + C to exit."
echo
pause
clear
echo
echo "   ┌────────────────────────────────────────────────────────────────────────────────────────────────────┐"
echo "   │ YDE Installion                                                                       [part 2 of 3] │"
echo "   └────────────────────────────────────────────────────────────────────────────────────────────────────┘"
echo
echo
echo "    We installing the required parts..."
echo
loading &
# if [ "$(wc -l ~/.config/YDE/settings.conf | head -c1)" -gt "30" ]; then
# break
# else
# rm ~/.config/YDE/settings.conf
# fi
sudo cp ./de.sh $int
sudo chmod +x $int
sudo mkdir /usr/share/YDE
mkdir ~/.config/YDE/
mkdir ~/.config/YDE/themes
mkdir ~/.config/YDE/languages
mkdir ~/.config/YDE/old
mkdir ~/.config/YDE/apps
touch ~/.config/YDE/settings.conf
sudo touch /usr/share/YDE/settings.conf
touch ~/.config/YDE/apps/list
echo THEME=classic >> ~/.config/YDE/settings.conf
echo int=$int >> ~/.config/YDE/settings.conf
sleep 2
kill "$!"
clear
echo
echo "   ┌────────────────────────────────────────────────────────────────────────────────────────────────────┐"
echo "   │ YDE Installion                                                                       [part 3 of 3] │"
echo "   └────────────────────────────────────────────────────────────────────────────────────────────────────┘"
echo
echo
echo "      YDE has been successfully installed on your PC!"
echo
echo "      Please write runui to run YDE."
echo "      The installer will close in a couple of seconds."
echo
sleep 3
 clear
 echo "run runui to run shell."
 echo
 echo "Your Desktop Environment $VER - 2021-2022. Russanandres"
 date
 exit
fi
echo hi
