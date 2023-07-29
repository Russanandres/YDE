#!/bin/bash

VER="1.0"
startuptime=$(date)
export SAVED_STTY="`stty --save`"
userdata="$HOME/.config/YDE"
int="/usr/bin/runui"
source /usr/share/YDE/settings.conf &> /dev/null
source $HOME/.config/YDE/settings.conf &> /dev/null

function pause(){ read -p "Press ENTER to continue....";}
function exitscr(){
 stty "$SAVED_STTY"
 tput cnorm
 kill "$!"
 clear
 echo "Your Desktop Environment $VER - 2022-2023. Russanandres"
 date
 exit;}
function loading() {
    local i sp n
    sp='/-\|'
    n=${#sp}
    printf ' '
    while sleep 0.1; do
        printf "%s\b" "${sp:i++%n:1}"
    done;}
trap "stty "$SAVED_STTY";exitscr" SIGINT

if [ -f "$int" ]; then inst="true "
else inst="false"
fi


function check(){
mkdir -vp $HOME/.config/YDE/
mkdir -v $HOME/.config/YDE/themes
mkdir -v $HOME/.config/YDE/languages
mkdir -v $HOME/.config/YDE/old
mkdir -v $HOME/.config/YDE/apps
touch $HOME/.config/YDE/settings.conf
echo -e "\nEnter root password to check systemwide directory."
sudo mkdir -v /usr/share/YDE
sudo touch /usr/share/YDE/settings.conf
echo "YDE files has been successfully checked!";exit; }



function helpscr(){
echo "Your Desktop Environment. By Russanandres.
Usage: de.sh [option]
Availiable options:
    -p | --portable     >>  Run YDE without install
    -v | --version      >>  Show YDE version
    -f | --force-quit   >>  Force quit from YDE
    -c | --legacy       >>  Run YDE in legacy mode
    -h | --help         >>  Show help manual

Additional options:
    --backup            >>  Backup your YDE folder
    --check             >>  Diagnose your YDE folder
    --erase-content     >>  Factory reset YDE
    --target %path%     >>  Locate YDE to install"; exit; }



while [ "$1" != "" ]; do
    case $1 in
        -v ) echo $VER; exit;;


        -h | --help )       helpscr;;
        -q | --force-quit ) exitscr;;
        -c | --legacy )     curl -s https://raw.githubusercontent.com/Russanandres/YDE/main/YDE_fallback.sh | bash;;
        -p | --portable )   portable="1";;
        -f | --fastboot )   fastboot="true";;


        --version ) echo -e "Your Desktop Environment $VER by Russanandres. \nThanks for using!";exit;;
        --backup )  backuppath="$HOME/.config/YDE_old/$(date +%d-%m-%y)"
                    mkdir -p $backuppath; echo "Created folder $backuppath"
                    cp -r $HOME/.config/YDE $backuppath; s1=$?; if [ "$s1" == "0" ]; then echo "Copied user folder"; fi
                    cp $int $backuppath; s2=$?; if [ "$s2" == "0" ]; then echo "Copied script"; fi
                    if [ "$s1" == "0" ] && [ "$s2" == "0" ]; then echo "Backup successfull";exit
                    else echo "Can't create backup!";rm -rf $backuppath;exit;fi;;
        --check )   check;;
        --func ) gotofunc=$2; shift;;
        --turn-off-blink ) tput civis;;
        --erase-all-content ) rm /tmp/updatingYDE.tmp; rm -r $HOME/.config/YDE/; sudo rm /usr/share/YDE/settings.conf
                              check;;
        --target ) if [ -z "$2" ]; then echo -e "Please enter install path after variable \nLike --target /usr/bin/yde"; exit; else int=$2;shift;fi;;
        --userdata )  if [ -z "$2" ]; then true;else userdatanew=$2;echo "userdata=$userdatanew" >> $userdata/settings.conf;shift;fi;; #EXPEREMENTAL
    esac
    shift
done


clear

if [ "$startupcheckupdate" == "enable" ]; then
loading &
gitver=$(curl -f -# https://raw.githubusercontent.com/Russanandres/YDE/main/lastversion)
if [ "$VER" == "$gitver" ]; then echo "All ok!";sleep 0.5
elif [ "$gitver" -gt "$VER" ]; then echo "You have old version of script! Please update it!";pause
elif [ "$gitver" -lt "$VER" ]; then echo "You have newer version, than repository! Please create issue in github!";pause
fi
kill "$!";fi

if [ -f "/tmp/updatingYDE.tmp" ]; then
loading &
sudo rm $int
sudo cp ./$0 $int
sudo chmod +x $int
sleep 2
kill "$!"
clear
fi

if [ ! -f "$HOME/.config/YDE/settings.conf" ] && [ "$portable" != "1" ]; then
echo -e "Your config file is corrupted!\n\nCheck YDE files? [Y/n]\n"
read -sn1 rec
case "$rec" in
"Y"|"y" )
mkdir $HOME/.config/YDE/
mkdir $HOME/.config/YDE/themes
mkdir $HOME/.config/YDE/languages
mkdir $HOME/.config/YDE/old
mkdir $HOME/.config/YDE/apps
touch $HOME/.config/YDE/settings.conf
touch $HOME/.config/YDE/apps/list
echo "int=$int" >> $HOME/.config/YDE/settings.conf;;
esac
elif [ "$portable" == "1" ]; then true
fi

if [ -f "$int" ] || [ "$portable" == "1" ]; then
clear
echo -n "┌                                                                                                      ┐


                                    Loading Your Desktop Environment
















                                                   ";tput civis;loading &
screen=startingup
stty -icanon -icrnl time 0 min 0
if [ "$fastboot" != "true" ]; then sleep 1.3;fi
printf '\033[8;27;104t'
kill "$!";tput cnorm

while true; do ################## PT Start of something beautiful (Hell no)
function start(){
screen=start
clear
echo -e "┌───────────────────────────────────────────── Homescreen ─────────────────────────────────────────────┐
│                                                                                                      │
│  ┌───┐            ┌───┐               ┌───┐                                                          │
│  │ A │ About YDE  │ M │ Misc          │ X │ Clock-kit                                                │
│  └───┘            └───┘               └───┘                                                          │
│  ┌───┐            ┌───┐                                                                              │
│  │ E │ Exit YDE   │ C │ Configurator                                                                 │
│  └───┘            └───┘                                                                              │
│  ┌───┐                                                                                               │
│  │ P │ Powermenu                                                                                     │
│  └───┘                                                                                               │
│  ┌───┐                                                                                               │
│  │ L │ Lock PC                                                                                       │
│  └───┘                                                                                               │
│                                                                                                      │
│                                                                                                      │
│                                                                                                      │
│                                                                                                      │
│                                                                                     ┌───┐            │
│                                                                                     │ Q │ Your apps  │
│  [W] All apps                                                                       └───┘            │
│                                                                                                      │
├──────────────────────────────────────────────────────────────────────────────────────────────────────┤
│ [YDE] $VER                                                                         [$(date +%D)] [$(date +%H:%M)] │
└──────────────────────────────────────────────────────────────────────────────────────────────────────┘"
read -sn1 ch
case "$ch" in
"A"|"a" ) about;;
"E"|"e" ) exitscr;;
"P"|"p" ) exitt;;
"L"|"l" ) lock;;

"M"|"m" ) settings;;
"C"|"c" ) configurator;;

"X"|"x" ) clear; clock;;

"W"|"w" ) apps;;
"Q"|"q" ) yourapps;;

"S"|"s" ) desktop;;
"D"|"d" ) desktop;;
esac
}

function apps(){
screen=apps
clear
echo -e "┌─────────────────────────────────────────── Homescreen apps ──────────────────────────────────────────┐
│                                                                                                      │
│  ┌───┐                                                                                               │
│  │ H │ Homescreen                                                                                    │
│  └───┘                                                                                               │
│  ┌───┐                                                                                               │
│  │ D │ Desktop                                                                                       │
│  └───┘                                                                                               │
│  ┌───┐                                                                                               │
│  │ F │ MC FM                                                                                         │
│  └───┘                                                                                               │
│  ┌───┐                                                                                               │
│  │ B │ Browser                                                                                       │
│  └───┘                                                                                               │
│                                                                                                      │
│                                                                                                      │
│                                                                                                      │
│                                                                                                      │
│                                                                                     ┌───┐            │
│                                                                                     │ Y │ Your apps  │
│                                                                                     └───┘            │
│                                                                                                      │
├──────────────────────────────────────────────────────────────────────────────────────────────────────┤
│ [S] Back to Homescreen                                                            [$(date +%D)] [$(date +%H:%M)] │
└──────────────────────────────────────────────────────────────────────────────────────────────────────┘"
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

function desktop(){
screen=desktop
while true; do
trap "exitscr" SIGINT
clear
echo -e "┌──────────────────────────────────────────── Your Desktop ────────────────────────────────────────────┐
│                                                                             Now is:                  │
│ [1] - Back to Command line                                              $(date +%D) $(date +%H:%M:%S)            │
│ [L] - Lockscreen                                                               $(date +%a)                   │
│                                                                                                      │
│                                                                                                      │
│                                                                                                      │
│                        \`8.\`8888.      ,8' 8 888888888o.      8 8888888888                            │
│                         \`8.\`8888.    ,8'  8 8888    \`^888.   8 8888                                  │
│                          \`8.\`8888.  ,8'   8 8888        \`88. 8 8888                                  │
│                           \`8.\`8888.,8'    8 8888         \`88 8 8888                                  │
│                            \`8.\`88888'     8 8888          88 8 888888888888                          │
│                             \`8. 8888      8 8888          88 8 8888                                  │
│                              \`8 8888      8 8888         ,88 8 8888                                  │
│                               8 8888      8 8888        ,88' 8 8888                                  │
│                               8 8888      8 8888    ,o88P'   8 8888                                  │
│                               8 8888      8 888888888P'      8 888888888888                          │
│                                                                                                      │
│                                                                                                      │
│                                                                                                      │
│                                                                                                      │
│                                                                                                      │
├──────────────────────────────────────────────────────────────────────────────────────────────────────┤
│ [S] Homescreen                                                                 [$(date +%D)] [$(date +%H:%M:%S)] │
└──────────────────────────────────────────────────────────────────────────────────────────────────────┘"
if read -t 0; then
read -n 1 char
case "$char" in
"I" ) echo "Hello World!"; sleep 2;;
"S"|"s" ) start;;
"1" ) exitscr;;
"L"|"l" ) lock;;
"=" ) debug;;
esac;break
else sleep 0.5;fi;done
}

function yourapps(){
screen=yourapps
if ! [ -d $HOME/.config/YDE/apps ]; then
clear
echo "I'm a teapot!"
mkdir $HOME/.config/YDE/apps
sleep 1
exit 418
fi
clear
echo "──────────── Your Apps ────────────"
echo "- Type yahelp to see wiki"
echo "- Type edesk to exit to desktop"
echo "- Apps list:"
echo
ls -xX1 $HOME/.config/YDE/apps/
# cat $HOME/.config/YDE/apps/list
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
source $HOME/.config/YDE/apps/$selapp
if [ "$sudo" == "1" ]; then
sudo bash $run
elif [ "$sudo" == "0" ]; then
bash $run
fi
}


function about(){
screen=about
clear
echo -e "┌──────────────────────────────────────────── About Desktop ───────────────────────────────────────────┐
│ Your Desktop Environment                                                                             │
│ Version $VER                                                                                          │
│                                                                                                      │
│                                                                                                      │
│                                                                                                      │
│                                                                                                      │
│                  \`8.\`8888.      ,8' 8 888888888o.      8 8888888888                                  │
│                   \`8.\`8888.    ,8'  8 8888    \`^888.   8 8888                                        │
│                    \`8.\`8888.  ,8'   8 8888        \`88. 8 8888                                        │
│                     \`8.\`8888.,8'    8 8888         \`88 8 8888                                        │
│                      \`8.\`88888'     8 8888          88 8 888888888888                                │
│                       \`8. 8888      8 8888          88 8 8888                                        │
│                        \`8 8888      8 8888         ,88 8 8888                                        │
│                         8 8888      8 8888        ,88' 8 8888                                        │
│                         8 8888      8 8888    ,o88P'   8 8888                                        │
│                         8 8888      8 888888888P'      8 888888888888                                │
│                                                                                                      │
│                                                                                                      │
│                                                                                                      │
│                                                                                                      │
│                                                                                by Russanandres 2023  │
├──────────────────────────────────────────────────────────────────────────────────────────────────────┤
│ [S] Homescreen                                                                    [$(date +%D)] [$(date +%H:%M)] │
└──────────────────────────────────────────────────────────────────────────────────────────────────────┘"
read -sn1 ch
case "$ch" in
"S"|"s" ) start;;
"D"|"d" ) desktop;;
esac
}

function settings(){
screen=settings
clear
echo -e "┌────────────────────────────────────────── Desktop Settings ──────────────────────────────────────────┐
│                                                                                                      │
│ [E] Echo Hello World!                                                                                │
│ [-] Installed - $inst                                                                                │
│                                                                                                      │
│ [U] Check Update                                                                                     │
│ [Q] Reinstall from current file                                                                      │
│ [R] Remove YDE                                                                                       │
│                                                                                                      │
│ [C] Compatibility mode                                                                               │
│                                                                                                      │
│                                                                                                      │
│                                                                                                      │
│                                                                                                      │
│                                                                                                      │
│                                                                                                      │
│                                                                                                      │
│                                                                                                      │
│                                                                                                      │
│  [F] Enable Fast boot [o] - disable                                                                  │
│  [L] Turn-on loading animation [k] - Turn off                                                        │
│                                                                                                      │
├──────────────────────────────────────────────────────────────────────────────────────────────────────┤
│ [S] Homescreen                                                                    [$(date +%D)] [$(date +%H:%M)] │
└──────────────────────────────────────────────────────────────────────────────────────────────────────┘"
read -sn1 ch
case "$ch" in
"E"|"e" ) echo "Hello World!"; sleep 2;;
"U"|"u" ) update;;
"R"|"r" ) remove;;
"Q"|"q" ) reinstall;;
"C"|"c" ) curl -s https://raw.githubusercontent.com/Russanandres/YDE/main/YDE_fallback.sh | bash;;
"S"|"s" ) start;;
"D"|"d" ) desktop;;
"l" ) loading &;;
"k" ) kill "$!";;
"f" ) echo fastboot=true >> $HOME/.config/YDE/settings.conf;;
"o" ) echo fastboot=false >> $HOME/.config/YDE/settings.conf;;
"b" ) tput civis;;
"v" ) tput cnorm;;
esac
}


function clock(){
echo "Choose tool:"
echo
echo "1 - Timer and clock"
echo "2 - Stopwatch and clock"
echo "other button - clock"
echo
echo "CTRL + C to exit desktop"
trap "desktop" EXIT
read -sn1 cl
case "$cl" in
"1" ) timer;;
"2" ) st=1;;
esac
scrclock
}
function timer(){
clear
t=1; echo "WARNING! The alarm was the white noise!"; echo
echo "Please type time in second from 1 to 99:"
read -n2 e
scrclock
}
function scrclock(){
while sleep 1; do
if [ $t == '1' ]; then
	let e="$e-1"
else e=00
fi
if [ $st == '1' ]; then
	let m="$m+1"
else m=00
fi
clear
echo -e "┌──────────────────────────────────────────── Screen clock ────────────────────────────────────────────┐
│                                                                                                      │
│                                                                                                      │
│              ┌Clock────────────────┐                                                                 │
│              │                     │                                                                 │
│              │      Now is:        │                                                                 │
│              │  $(date +%D) $(date +%H:%M:%S)  │                                                                 │
│              │         $(date +%a)          │                                                                 │
│              │                     │                                                                 │
│              └─────────────────────┘                                                                 │
│                                                                                                      │
│                                                                                                      │
│   ┌Timer────────────────┐      ┌Stopwatch────────────┐            ___  _ ____  _____                 │
│   │                     │      │                     │            \  \///  _ \/  __/                 │
│   │   Time left:        │      │  Time passed:       │             \  / | | \||  \                   │
│   │      $e sec         │      │    $m sec           │             / /  | |_/||  /_                  │
│   │                     │      │                     │            /_/   \____/\____\                 │
│   │                     │      │                     │                                               │
│   └─────────────────────┘      └─────────────────────┘                                               │
│                                                                                                      │
│                                                                                                      │
│                                                                                                      │
├──────────────────────────────────────────────────────────────────────────────────────────────────────┤
│ Press CTRL + C to exit to desktop                                                                    │
└──────────────────────────────────────────────────────────────────────────────────────────────────────┘"
trap "desktop" EXIT
if [ $e == '0' ]; then echo "time is out!"; aplay /dev/random; fi
done
}

function lock(){
while sleep 1; do
clear
echo -e "┌───────────────────────────────────────────── Lockscreen ─────────────────────────────────────────────┐
│                                                                                                      │
│                                                                                                      │
│                                                                                                      │
│                                                                                                      │
│                     Now is:                                                                          │
│                 $(date +%D) $(date +%H:%M:%S)                                                                    │
│                        $(date +%a)                                                                           │
│                                                                                                      │
│                                                                                                      │
│                                                                                                      │
│                                                                                                      │
│                                                                                                      │
│                                                                                                      │
│                                                                   ___  _ ____  _____                 │
│                                                                   \  \///  _ \/  __/                 │
│                                                                    \  / | | \||  \                   │
│                                                                    / /  | |_/||  /_                  │
│                                                                   /_/   \____/\____\                 │
│                                                                                                      │
│                                                                                                      │
│                                                                                                      │
├──────────────────────────────────────────────────────────────────────────────────────────────────────┤
│ Press CTRL + C to unlock                                                                             │
└──────────────────────────────────────────────────────────────────────────────────────────────────────┘"
trap "break" SIGINT
done
}
function unlock(){
clear
echo -e "┌───────────────────────────────────────────── Lockscreen ─────────────────────────────────────────────┐
│                                                                                                      │
│                                                                                                      │
│                                                                                                      │
│                Please enter passcode                                                                 │
│                                                                                                      │
│                                                                                                      │
│                                                                                                      │
│                                                                                                      │
│                                                                                                      │
│                                                                                                      │
│                                                                                                      │
│                                                                                                      │
│                                                                                                      │
│                                                                   ___  _ ____  _____                 │
│                                                                   \  \///  _ \/  __/                 │
│                                                                    \  / | | \||  \                   │
│                                                                    / /  | |_/||  /_                  │
│                                                                   /_/   \____/\____\                 │
│                                                                                                      │
│                                                                                                      │
│                                                                                                      │
├──────────────────────────────────────────────────────────────────────────────────────────────────────┤
│ Unlock PC with your password                                                                         │
└──────────────────────────────────────────────────────────────────────────────────────────────────────┘"
read -e pass
if [ $pass1 -eq $pass ]; then desktop; else echo "Password do not match! Please try again!"; sleep 3; lock; fi
pause
}





### Under construction things

exitt=0
function exitt()
{
    let exitt++
    echo
    if [[ $exitt == 1 ]]; then
clear
echo -e "┌────────────────────────────────────────────── Shutdown ──────────────────────────────────────────────┐
│                                                                                                      │
│  ┌───┐                                                                                               │
│  │ E │ Exit YDE                                                                                      │
│  └───┘                                                                                               │
│  ┌───┐                                                                                               │
│  │ P │ Poweroff                                                                                      │
│  └───┘                                                                                               │
│  ┌───┐                                                                                               │
│  │ D │ Desktop                                                                                       │
│  └───┘                                                                                               │
│                                                                                                      │
│                                                                                                      │
│                                                                                                      │
│                                                                                                      │
│                                                                                                      │
│                                                                                                      │
│                                                                                                      │
│                                                                                                      │
│                                                                                                      │
│                                                                                                      │
│                                                                                                      │
├──────────────────────────────────────────────────────────────────────────────────────────────────────┤
│ [YDE]                                                                             [$(date +%D)] [$(date +%H:%M)] │
└──────────────────────────────────────────────────────────────────────────────────────────────────────┘"
read -sn1 ch
case "$ch" in
"P"|"p" ) clear; echo "Shut Down? [Y/n]"; read -sn1 ch; case "$ch" in "Y"|"y") sudo poweroff; esac;;
"E"|"e" ) exitscr;;
esac
    fi
}

# Reset
No_color='\033[0m'       # Text Reset
# Regular Colors
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White
# Bold
BBlack='\033[1;30m'       # Black
BRed='\033[1;31m'         # Red
BGreen='\033[1;32m'       # Green
BYellow='\033[1;33m'      # Yellow
BBlue='\033[1;34m'        # Blue
BPurple='\033[1;35m'      # Purple
BCyan='\033[1;36m'        # Cyan
BWhite='\033[1;37m'       # White
# Underline
UBlack='\033[4;30m'       # Black
URed='\033[4;31m'         # Red
UGreen='\033[4;32m'       # Green
UYellow='\033[4;33m'      # Yellow
UBlue='\033[4;34m'        # Blue
UPurple='\033[4;35m'      # Purple
UCyan='\033[4;36m'        # Cyan
UWhite='\033[4;37m'       # White
# Background
On_Black='\033[40m'       # Black
On_Red='\033[41m'         # Red
On_Green='\033[42m'       # Green
On_Yellow='\033[43m'      # Yellow
On_Blue='\033[44m'        # Blue
On_Purple='\033[45m'      # Purple
On_Cyan='\033[46m'        # Cyan
On_White='\033[47m'       # White
# High Intensity
IBlack='\033[0;90m'       # Black
IRed='\033[0;91m'         # Red
IGreen='\033[0;92m'       # Green
IYellow='\033[0;93m'      # Yellow
IBlue='\033[0;94m'        # Blue
IPurple='\033[0;95m'      # Purple
ICyan='\033[0;96m'        # Cyan
IWhite='\033[0;97m'       # White
# Bold High Intensity
BIBlack='\033[1;90m'      # Black
BIRed='\033[1;91m'        # Red
BIGreen='\033[1;92m'      # Green
BIYellow='\033[1;93m'     # Yellow
BIBlue='\033[1;94m'       # Blue
BIPurple='\033[1;95m'     # Purple
BICyan='\033[1;96m'       # Cyan
BIWhite='\033[1;97m'      # White
# High Intensity backgrounds
On_IBlack='\033[0;100m'   # Black
On_IRed='\033[0;101m'     # Red
On_IGreen='\033[0;102m'   # Green
On_IYellow='\033[0;103m'  # Yellow
On_IBlue='\033[0;104m'    # Blue
On_IPurple='\033[0;105m'  # Purple
On_ICyan='\033[0;106m'    # Cyan
On_IWhite='\033[0;107m'   # White
function colored(){
source $HOME/.config/YDE/colors.sh
echo
echo -e "${Cyan}This ${BIPurple}text ${BBlue}written ${IGreen}with ${On_IRed}different${No_color} ${UWhite}colors!" # ${}
echo -e ${No_color}
pause
}

function resscr(){
mkdir -p $HOME/.config/systemd/user/
echo "[Unit]
Description=YDE management service
After=network.target

[Service]
User=$USER
ExecStart=/usr/bin/runui
Restart=on-failure

[Install]
WantedBy=multi-user.target" >> $HOME/.config/systemd/user/ydemanager.service
systemctl --user start ydemanager
if [ $? != 0 ]; then echo -e "Can't start daemon service.\n\nDo you use systemd?"; pause; fi
}

function debug(){
screen=desktop
clear
echo "Under construction.

r - resscr (Start YDE management service daemon for systemd)"
read -sn1 ch
case "$ch" in
"=" ) screen=desktop; desktop;;
"r" ) resscr;;
esac
}


function configurator(){
screen=configurator
printf '\033[8;27;107t'
clear
parts=8
echo -e "
   ┌────────────────────────────────────────────────────────────────────────────────────────────────────┐
   │ YDE Configurator                                                                     [part 1 of $parts] │
   └────────────────────────────────────────────────────────────────────────────────────────────────────┘


         Welcome to the YDE Configurator.

         We will ask you questions to set up the environment.
         Application changes will be after all questions.

          - Press ENTER to continue
          - Press CTRL + C to exit
"
pause
clear
echo -e "
   ┌────────────────────────────────────────────────────────────────────────────────────────────────────┐
   │ YDE Configurator                                                                     [part 2 of $parts] │
   └────────────────────────────────────────────────────────────────────────────────────────────────────┘


         Download ALL needed parts?
         [ncal, wget, dialog, bash, sudo]

          - Type [Y] to Download
          - Type [N] to Continue
"
read -sn1 two
clear
echo -e "
   ┌────────────────────────────────────────────────────────────────────────────────────────────────────┐
   │ YDE Configurator                                                                     [part 3 of $parts] │
   └────────────────────────────────────────────────────────────────────────────────────────────────────┘


        Enable startup update checker?

         - Type [Y] to Enable
         - Type [N] to Diasble
         - Type [S] to Skip
"
read -sn1 three
clear
echo -e "
   ┌────────────────────────────────────────────────────────────────────────────────────────────────────┐
   │ YDE Configurator                                                                     [part 4 of $parts] │
   └────────────────────────────────────────────────────────────────────────────────────────────────────┘


        Run YDE After logining in TTY?
        We just write [/usr/bin/runui] in .bash_profile
        WARNING!
        You will need delete this line with text editor yourself if you want to disable it!

         - Type [Y] to Enable
         - Type [N] to Continue
"
read -sn1 four
clear
echo -e "
   ┌────────────────────────────────────────────────────────────────────────────────────────────────────┐
   │ YDE Configurator                                                                     [part 5 of $parts] │
   └────────────────────────────────────────────────────────────────────────────────────────────────────┘


        Enable Fastboot?

         - Type [Y] to Enable
         - Type [N] to Diasble
         - Type [S] to Skip
"
read -sn1 five
clear
echo -e "
   ┌────────────────────────────────────────────────────────────────────────────────────────────────────┐
   │ YDE Configurator                                                                     [part 6 of $parts] │
   └────────────────────────────────────────────────────────────────────────────────────────────────────┘


        Setup lockscreen password?
        PASSWORD WILL NOT BE ENCRYPTED!!!

         - Type [S] to Skip
         - Or type pasword
"
read six
clear
echo -e "
   ┌────────────────────────────────────────────────────────────────────────────────────────────────────┐
   │ YDE Configurator                                                                     [part 7 of $parts] │
   └────────────────────────────────────────────────────────────────────────────────────────────────────┘


        Apply current configuration for all users?

         - Type [Y] to Enable
         - Type [N] to Diasble
"
read -sn1 seven
# clear
# echo
# echo "   ┌──────────────────────────────────────────────────────────────────────────────────────────────────────┐"
# echo "   │YDE Configurator                                                                        [part 5 of $parts] │"
# echo "   └──────────────────────────────────────────────────────────────────────────────────────────────────────┘"
# echo
# echo
# echo "        Choose resolution:"
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

clear
echo -e "
   ┌────────────────────────────────────────────────────────────────────────────────────────────────────┐
   │ YDE Configurator                                                                     [part 8 of $parts] │
   └────────────────────────────────────────────────────────────────────────────────────────────────────┘


        YDE is being configurating...

"

case "$two" in
"Y"|"y" ) sudo apt install -y ncal dialog wget bash w3m w3m-img mc mpv aplay ; apt install -y ncal dialog wget bash sudo w3m w3m-img mc mpv aplay ;;
esac


case "$three" in
"Y"|"y" ) echo startupcheckupdate=enable >> $HOME/.config/YDE/settings.conf;;
"N"|"n" ) echo startupcheckupdate=disable >> $HOME/.config/YDE/settings.conf;;
esac


case "$four" in
"Y"|"y" ) echo /usr/bin/runui >> $HOME/.bash_profile;;
esac


case "$five" in
"Y"|"y" ) echo fastboot=true >> $HOME/.config/YDE/settings.conf;;
"N"|"n" ) echo fastboot=false >> $HOME/.config/YDE/settings.conf;;
esac

case "$six" in
"S"|"s" ) true;;
* ) echo pass1=$seven >> $HOME/.config/YDE/settings.conf
esac


case "$seven" in
"Y"|"y" ) sudo rm /usr/share/YDE/settings.conf; sudo cp $HOME/.config/YDE/settings.conf /usr/share/YDE/settings.conf;;
esac

sleep 2
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
# if [ "$(wc -l $HOME/.config/YDE/settings.conf | head -c1)" -gt "30" ]; then
# break
# else
# echo Sorry, but we need to erase all your settings. You have 3 second to press CTRL + C and save your config file in $HOME/.config/YDE/settings.conf
# sleep 3
# rm $HOME/.config/YDE/settings.conf
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
echo "      Please wait..."
tput civis
loading &
sudo rm $int
sudo cp ./$0 $int
sudo chmod +x $int
sleep 2
kill "$!"
tput cnorm
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
tput civis
loading &
sudo rm $int
if [ "$deluserdata" == "Y" ]; then
mv $HOME/.config/YDE /tmp/YDE/$USER/
mv /usr/share/YDE /tmp/YDE/system/
rm -rf $HOME/.config/YDE
sleep 2
fi
kill "$!"
tput cnorm
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



$gotofunc
if [ "$screen" == "startingup" ]; then desktop
else $screen
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
tput civis
loading &
sudo cp ./$0 $int
sudo chmod +x $int
sudo mkdir /usr/share/YDE
mkdir -p $HOME/.config/YDE/
mkdir $HOME/.config/YDE/themes
mkdir $HOME/.config/YDE/languages
mkdir $HOME/.config/YDE/old
mkdir $HOME/.config/YDE/apps
touch $HOME/.config/YDE/settings.conf
sudo touch /usr/share/YDE/settings.conf
echo int=$int >> $HOME/.config/YDE/settings.conf
sleep 2
kill "$!"
tput cnorm
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
stty "$SAVED_STTY"
clear
echo -e "Run runui to run shell.\n\nYour Desktop Environment $VER - 2022-2023. Russanandres"
date
exit
fi
echo "Onwards here if you believe!"
