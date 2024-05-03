#!/bin/bash

VER="1.0"
RELEASE="dev "
startuptime=$(date)
export SAVED_STTY="`stty --save`"
userdata="$HOME/.config/RDE"
int="/usr/bin/dewn"
sysset="/usr/share/RDE/settings.conf"
set="$userdata/settings.conf"
updcheck=0;fastboot=0;logon=0;lock=0;sw=0

source $sysset &> /dev/null
source $HOME/.config/RDE/settings.conf &> /dev/null

# TODO:
#
# [R] - Rework
# [N] - Fresh start
# [D] - Test needs (almost done)
#
# [R] Settings management in files
# [R] RDE Configurator
# [R] RDE updating utility
# [R] Bash Fallback
# [D] Backup
# [N] About system
# [N] My Apps
#
#
# Warning! Some places contains character icons, such as diskette, desktop, MailBox, etc.
# Some fonts, terminals or systems, for example tty, haven't this symbols in their fonts. They will be tofu!
#



function pause(){ read -sn1 -p "Press ENTER to continue....";}
function sttynorm(){ stty "$SAVED_STTY"; }
function exitscr(){
 stty "$SAVED_STTY"
 tput cnorm
 kill "$!"
 clear
 echo "RSAR's Desktop Environment (YDE Fork) $VER - 2024. Russanandres"
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

if [ -f "$int" ]; then inst="true ";else inst="false";fi
if [ $RELEASE == user ]; then REL="$0"; else REL="dev.sh";fi



function check(){
mkdir -vp $HOME/.config/RDE/
mkdir -v $HOME/.config/RDE/themes
mkdir -v $HOME/.config/RDE/languages
mkdir -v $HOME/.config/RDE/old
mkdir -v $HOME/.config/RDE/apps
touch $HOME/.config/RDE/settings.conf
if [ "$sudo" == "1" ]; then sudo mkdir -v /usr/share/RDE; else mkdir -v /usr/share/RDE;fi
if [ "$sudo" == "1" ]; then sudo touch $sysset; else touch $sysset;fi
echo "RDE files has been successfully checked!";exit; }



function helpscr(){
echo "RSAR's Desktop Environment. By Russanandres.
Usage: $REL [option]
Availiable options:
    -p | --portable     >>  Run RDE without install
    -v | --version      >>  Show RDE version
    -q | --force-quit   >>  Force quit from RDE
    -c | --legacy       >>  Run RDE in legacy mode
    -h | --help         >>  Show help manual

Additional options:
    --backup            >>  Backup your RDE folder
    --check             >>  Diagnose your RDE folder
    --settings          >>  Difine your own settings file
    --sudo              >>  Allow RDE request sudo rights
    --erase-content     >>  Factory reset RDE
    --target %path%     >>  Locate RDE to install
    --no-check-integrity>>  Don't check user files for corrupt
    --observe-size      >>  Control size and resize terminal"; exit; }



while [ "$1" != "" ]; do
    case $1 in
        -v ) echo $VER; exit;;


        -h | --help )       helpscr;;
        -q | --force-quit ) exitscr;;
        -c | --legacy )     curl -s https://raw.githubusercontent.com/Russanandres/RDE/main/RDE_fallback.sh | bash;;
        -p | --portable )   portable="1";;
        -f | --fastboot )   fastboot="1";;


        --version ) echo -e "Your Desktop Environment $VER by Russanandres. \nThanks for using $REL!";exit;;
        --backup )  backuppath="$HOME/.config/RDE_old/$(date +%d-%m-%y)"
                    mkdir -p $backuppath; echo "Created folder $backuppath"
                    cp -r $HOME/.config/RDE $backuppath; s1=$?; if [ "$s1" == "0" ]; then echo "Copied user folder"; fi
                    cp $int $backuppath; s2=$?; if [ "$s2" == "0" ]; then echo "Copied script"; fi
                    if [ "$s1" == "0" ] && [ "$s2" == "0" ]; then echo "Backup successfull";exit
                    else echo "Can't create backup!";rm -rf $backuppath;exit;fi;;
        --check )   check;;
        --erase-content ) rm -r $HOME/.config/RDE/; sudo rm /usr/share/RDE/settings.conf;check;;
        --settings ) source $2; set=$2;shift;;
        --sudo ) sudo=1;;
        --target ) if [ -z "$2" ]; then echo -e "Please enter install path after variable \nLike --target /usr/bin/RDE"; exit
                   else int=$2;shift;fi;;
        # EXPEREMENTAL
        --userdata )  if [ -z "$2" ]; then true;else userdatanew=$2;echo "userdata=$userdatanew" >> $set;shift;fi;;
        --func ) gotofunc=$2; shift;;
        --turn-off-blink ) blink=0;tput civis;;
        --no-check-integrity ) nocheck=1;;
        # Modify startup environments (as possible)
        --dv-check-updates )   updcheck="1";;
        --dv-logon ) logon="1";;
        --dv-lock ) lock="1"; pass1=$2;shift;;
        --dv-sw ) sw="1";;
        --dv-temp-set-on-all-startup-modifications ) updcheck=1;fastboot=1;logon=1;lock=1;sw=1;;
    esac
    shift
done


clear

if [ "$updcheck" == "1" ]; then
loading &
gitver=$(curl -f -# https://raw.githubusercontent.com/Russanandres/RDE/main/lastversion)
if [ "$VER" == "$gitver" ]; then echo "All ok!";sleep 0.5
elif [ "$gitver" -gt "$VER" ]; then echo "You have old version of script! Please update it!";pause
elif [ "$gitver" -lt "$VER" ]; then echo "You somehow have newer version, than availible in repository! Please create issue in github!";pause
fi
kill "$!";fi

function execsudo(){ if [ "$sudo" == "1" ]; then sudo $@;else $@;fi; }

if [ "$PWD" == "/tmp" ] && [ "$0" == "RDE.sh" ]; then
loading &
execsudo rm $int
execsudo cp ./$0 $int
execsudo chmod +x $int
sleep 2
kill "$!"
clear
fi

if [ ! -f "$HOME/.config/RDE/settings.conf" ] && [ "$portable" != "1" ] && [ -f "$int" ] && [ "$nocheck" != "1" ]; then
echo -e "Your config file is corrupted!\n\nCheck RDE files? [Y/n]\n"
read -sn1 rec
case "$rec" in
"Y"|"y" )
mkdir $HOME/.config/RDE/
mkdir $HOME/.config/RDE/themes
mkdir $HOME/.config/RDE/languages
mkdir $HOME/.config/RDE/old
mkdir $HOME/.config/RDE/apps
touch $HOME/.config/RDE/settings.conf
touch $HOME/.config/RDE/apps/list
echo "int=$int" >> $HOME/.config/RDE/settings.conf;;
esac
fi

function error(){
echo -e "
   ┌─────────────────────────────────────────────────────────────────────────────────────────────────┐
   │ RDE Error reporter $VER                                                                  ${BIRed}[ERROR]${No_color} │
   └─────────────────────────────────────────────────────────────────────────────────────────────────┘

     Somewhere in the script appears error!
     RDE can't find errors automatically(
     Please check screenlog, try reinstall RDE or use it in portable mode.

     Also, you can tell about this bug to developer (@Russanandres).
";exit;}





function toosmallwindow(){          # See drawtestwindow function for offsets meaning
while sleep 0.1; do clear
cols=$(tput cols)
lines=$(tput lines)

if [ "$cols" -ge "$ncols" ] && [ "$lines" -ge "$nlines" ]; then break; fi

let colsc=cols-5 ### Offset to stabilze picture
let linesd=lines-9 ### Text


echo -n "┌"
for (( i=1; i <= $colsc; i++ ));do echo -n " ";done
echo -n "┐"
echo -e "\n
Your terminal is too small for RDE.
Try to resize it. Cols: $(if [ $cols -lt $ncols ]; then echo ${BRed};else echo ${BGreen};fi)$cols${No_color} | Lines: $(if [ $lines -lt $nlines ]; then echo ${BRed};else echo ${BGreen};fi)$lines${No_color}"
for (( i=0; i <= $linesd; i++ ));do echo " "; echo -n " ";done
echo

echo -n "└"
for (( i=1; i <= $colsc; i++ ));do echo -n " ";done
echo "┘"

done;}





function draw(){                    # See drawtestwindow function for offsets meaning
case "$1" in
"Header" )  let colsd=cols/2                                                                        # Divide for headerbar
            let colsd=colsd-colsdoffset                                                             # Minus amount of header text sym
            echo -n "┌"
            for (( i=1; i <= $colsd; i++ ));do echo -n " ";done
            echo -n " $2 "
            for (( i=1; i <= $colsd; i++ ));do echo -n " ";done; echo -n "┐";;
"Upperbar-Head-conf" ) echo -n "┌$(for (( i=1; i <= $colsc; i++ ));do echo -n "─";done)┐";;
"Upperbar-Botton-conf" ) echo -n "└$(for (( i=1; i <= $colsc; i++ ));do echo -n "─";done)┘";;
"Space" ) for (( i=0; i <= $linesd; i++ ));do echo " ";done;;
"Footer" )  echo -n "└"
            for (( i=1; i <= $colsc; i++ ));do echo -n " ";done
            echo "[$(date +%D)] [$(date +%H:%M)]   ┘";;
esac;}

function getcols(){ cols=$(tput cols);}
function getlines(){ lines=$(tput lines);}











if [ -f "$int" ] || [ "$portable" == "1" ]; then
getcols;getlines
let linesd=lines/2;let linesd=linesd-5
clear
echo -ne "┌$(for (( i=1; i <= $cols-2; i++ ));do echo -n " ";done)┐


$(for (( i=1; i <= $cols/2-16; i++ ));do echo -n " ";done)Loading Your Desktop Environment
$(draw Space)\n";for (( i=1; i <= $cols/2-1; i++ ));do echo -n " ";done;tput civis;loading &
screen=startingup
stty -icanon -icrnl time 0 min 0
if [ "$fastboot" != "1" ]; then sleep 1.3;fi
# printf '\033[8;27;104t'
kill "$!";if [ "$blink" != "0" ]; then tput cnorm;fi


while true; do ################## ParT Start of something beautiful (Hell no)





function start(){
screen=start

stty -icanon -icrnl time 0 min 0
while true; do clear
trap "exitscr" SIGINT

getcols;ncols=54
getlines;nlines=17
if [ "$cols" -lt "$ncols" ] || [ "$lines" -lt "$nlines" ]; then toosmallwindow; fi

colsdoffset=7        # Offset for corner element, no offset
let colsc=cols-23   # Offset for date and time + Corner elements
let linesd=lines-18 # Offset for menu and first empty line

draw Header Homescreen
echo -n "

   ┌───┐             ┌───┐             ┌───┐
   │ A │ About RDE   │ X │ Clock       │ 🖪 │ Undefined
   └───┘             └───┘             └───┘
   ┌───┐             ┌───┐
   │ E │ Exit RDE    │ C │ Configurator
   └───┘             └───┘
   ┌───┐             ┌───┐
   │ P │ Powermenu   │ Q │ Your apps
   └───┘             └───┘
   ┌───┐
   │ L │ Lock PC
   └───┘         "
draw Space
echo "    [W] All apps
"
draw Footer

if read -t 0; then
read -n 1 ch
case "$ch" in
"A"|"a" ) about;;
"E"|"e" ) exitscr;;
"P"|"p" ) exitt;;
"L"|"l" ) lock;;

"C"|"c" ) configurator;;

"X"|"x" ) clear; clock;;

"W"|"w" ) apps;;
"Q"|"q" ) yourapps;;

"S"|"s" ) desktop;;
"D"|"d" ) desktop;;
esac;break
else sleep 1;fi;done
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
"B"|"b" ) lynx https://google.com;;
"F"|"f" ) mc;;

"Y"|"y" ) yourapps;;
esac
}

function desktop(){
screen=desktop
stty -icanon -icrnl time 0 min 0
while true; do
trap "exitscr" SIGINT
getcols;getlines;colsdoffset=4;let linesd=lines-22;linesmax=3;let colsc=cols-4;ncols=53;nlines=22
if [ "$cols" -lt "$ncols" ] || [ "$lines" -lt "$nlines" ]; then toosmallwindow; fi
clear
echo -e "$(draw Header Desk)
$(for (( i=1; i <= $cols-23; i++ ));do echo -n " ";done)Now is:
  [1] - Back to CLI    $(for (( i=1; i <= $cols-51; i++ ));do echo -n " ";done)$(date +%D) $(date +%H:%M:%S)
  [L] - Lockscreen$(for (( i=1; i <= $cols-39; i++ ));do echo -n " ";done)$(date +%a)




$(for (( i=1; i <= $cols-84; i++ ));do echo -n " ";done)\`8.\`8888.      ,8' 8 888888888o.      8 8888888888
$(for (( i=1; i <= $cols-84; i++ ));do echo -n " ";done) \`8.\`8888.    ,8'  8 8888    \`^888.   8 8888
$(for (( i=1; i <= $cols-84; i++ ));do echo -n " ";done)  \`8.\`8888.  ,8'   8 8888        \`88. 8 8888
$(for (( i=1; i <= $cols-84; i++ ));do echo -n " ";done)   \`8.\`8888.,8'    8 8888         \`88 8 8888
$(for (( i=1; i <= $cols-84; i++ ));do echo -n " ";done)    \`8.\`88888'     8 8888          88 8 888888888888
$(for (( i=1; i <= $cols-84; i++ ));do echo -n " ";done)     \`8. 8888      8 8888          88 8 8888
$(for (( i=1; i <= $cols-84; i++ ));do echo -n " ";done)      \`8 8888      8 8888         ,88 8 8888
$(for (( i=1; i <= $cols-84; i++ ));do echo -n " ";done)       8 8888      8 8888        ,88' 8 8888   FORK
$(for (( i=1; i <= $cols-84; i++ ));do echo -n " ";done)       8 8888      8 8888    ,o88P'   8 8888
$(for (( i=1; i <= $cols-84; i++ ));do echo -n " ";done)       8 8888      8 888888888P'      8 888888888888$(draw Space)
 $(draw Upperbar-Head-conf)
 │ [S] Homescreen$(for (( i=1; i <= $cols-41; i++ ));do echo -n " ";done)[$(date +%D)] [$(date +%H:%M:%S)] │
 $(draw Upperbar-Botton-conf)"
if read -t 0; then
read -n 1 char
case "$char" in
"S"|"s" ) sttynorm;start;;
"1" ) sttynorm;exitscr;;
"L"|"l" ) sttynorm;lock;;
"~" ) sttynorm;debug;;
esac;break
else sleep 1;fi;done
}

function yourapps(){
screen=yourapps
echo -e "Hello World"

if ! [ -d $HOME/.config/RDE/apps ]; then
clear
echo "I'm a teapot!"
mkdir $HOME/.config/RDE/apps
sleep 1
exit 418
fi
clear
echo "──────────── Your Apps ────────────"
echo "- Type yahelp to see wiki"
echo "- Type edesk to exit to desktop"
echo "- Apps list:"
echo
ls -xX1 $HOME/.config/RDE/apps/
# cat $HOME/.config/RDE/apps/list
echo
read selapp
if [ "$selapp" == "yahelp" ]; then
clear
echo "- Type app name to start it"
echo "- We are tested only shell scripts now"
echo "- Then you are started app, RDE keeps running in background"
echo "- To add your app in list, see instruction on github."
pause
elif [ "$selapp" == "edesk" ]; then
desktop
fi
source $HOME/.config/RDE/apps/$selapp
execsudo $run
}







function about(){
screen=about

stty -icanon -icrnl time 0 min 0
while true; do clear
trap "exitscr" SIGINT

getcols;ncols=32
getlines;nlines=9

if [ "$cols" -lt "$ncols" ] || [ "$lines" -lt "$nlines" ]; then toosmallwindow; fi

colsdoffset=9     # Offset for corner element, no offset
let colsc=cols-23   # Offset for date and time + Corner elements
let linesd=lines-9 # Offset for menu and first empty line

draw Header "About desktop"
echo -n "
  RSAR's Desktop Environment 🗔  (Your Desktop Environment Fork)
  Version $VER
  Release: $RELEASE"
draw Space
for (( i=0; i <= $colsc-3; i++ ));do echo -n " ";done; echo -n ""   # Making offset for phrase in right side. Before it print spaces

echo "by Russanandres 2024
"

draw Footer

if read -t 0; then
read -n 1 ch
case "$ch" in
"S"|"s" ) start;;
"D"|"d" ) desktop;;
esac;break
else sleep 0.5;fi;done
}







function clock(){                   # Well, i dunno how to do it right.
while sleep 0.1;do clear
stty -icanon -icrnl time 0 min 0
trap "exitscr" SIGINT

getcols;ncols=32
getlines;nlines=9

if [ "$cols" -lt "$ncols" ] || [ "$lines" -lt "$nlines" ]; then toosmallwindow; fi

echo -e "$(tr -cd "[:digit:]" < /dev/urandom | head -c $cols)
$(tr -cd "[:digit:]" < /dev/urandom | head -c 12)${BIRed}$(date +%H)${No_color}$(tr -cd "[:digit:]" < /dev/urandom | head -c 47)${BIBlue}Hours${No_color}$(tr -cd "[:digit:]" < /dev/urandom | head -c 38)
$(tr -cd "[:digit:]" < /dev/urandom | head -c $cols)
$(tr -cd "[:digit:]" < /dev/urandom | head -c 9)${BIBlue}Minutes${No_color}$(tr -cd "[:digit:]" < /dev/urandom | head -c 39)${BIRed}$(date +%M)${No_color}$(tr -cd "[:digit:]" < /dev/urandom | head -c 47)
$(tr -cd "[:digit:]" < /dev/urandom | head -c $cols)
$(tr -cd "[:digit:]" < /dev/urandom | head -c $cols)
$(tr -cd "[:digit:]" < /dev/urandom | head -c $cols)
$(tr -cd "[:digit:]" < /dev/urandom | head -c 45)${BIBlue}Seconds${No_color}$(tr -cd "[:digit:]" < /dev/urandom | head -c 42)${BIRed}$(date +%S)${No_color}$(tr -cd "[:digit:]" < /dev/urandom | head -c 8)
$(tr -cd "[:digit:]" < /dev/urandom | head -c $cols)
$(tr -cd "[:digit:]" < /dev/urandom | head -c 9)${BIRed}$(date +%d)${No_color}$(tr -cd "[:digit:]" < /dev/urandom | head -c 60)${BIBlue}Day${No_color}$(tr -cd "[:digit:]" < /dev/urandom | head -c 30)
$(tr -cd "[:digit:]" < /dev/urandom | head -c $cols)
$(tr -cd "[:digit:]" < /dev/urandom | head -c $cols)
420${BIBlue}Month${No_color}$(tr -cd "[:digit:]" < /dev/urandom | head -c 48)${BIRed}$(date +%m)${No_color}$(tr -cd "[:digit:]" < /dev/urandom | head -c 46)
$(tr -cd "[:digit:]" < /dev/urandom | head -c $cols)
$(tr -cd "[:digit:]" < /dev/urandom | head -c $cols)
$(tr -cd "[:digit:]" < /dev/urandom | head -c $cols)
$(tr -cd "[:digit:]" < /dev/urandom | head -c $cols)
$(tr -cd "[:digit:]" < /dev/urandom | head -c 14)${BIRed}$(date +%Y)${No_color}$(tr -cd "[:digit:]" < /dev/urandom | head -c 38)${BIBlue}Year${No_color}$(tr -cd "[:digit:]" < /dev/urandom | head -c 44)
$(tr -cd "[:digit:]" < /dev/urandom | head -c $cols)
$(tr -cd "[:digit:]" < /dev/urandom | head -c $cols)
$(tr -cd "[:digit:]" < /dev/urandom | head -c 23)${BIBlue}Day${No_color}$(date +%q)${BIBlue}Of${No_color}$(date +%u)${BIBlue}Week${No_color}$(tr -cd "[:digit:]" < /dev/urandom | head -c 50)${BIRed}$(date +%a)${No_color}$(tr -cd "[:digit:]" < /dev/urandom | head -c 17)
$(tr -cd "[:digit:]" < /dev/urandom | head -c $cols)
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1  [01011001 01000100 01000101] 420461982375678321589023657834615289030653478901589265784360346985769  1
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000"
trap "desktop" EXIT
done
}

function lock(){
while sleep 1; do
getcols;colsdoffset=7
clear
echo -e "$(draw Header Lockscreen)
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
done;}
function unlock(){
sttynorm
clear
echo -e "$(draw Header Lockscreen)
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
│ Unlock PC with your password:                                                                        │
└──────────────────────────────────────────────────────────────────────────────────────────────────────┘"
read -e pass
if [ $pass1 -eq $pass ]; then desktop; else echo "Password do not match! Please try again!"; sleep 3; lock; fi
pause;}





### Under construction things

function exitt(){
getcols;getlines;colsdoffset=6;let linesd=lines-14;let colsc=cols-23;ncols=53;nlines=22
clear
echo -e "$(draw Header Poweroff)

   ┌───┐
   │ E │ Exit RDE
   └───┘
   ┌───┐
   │ P │ Poweroff
   └───┘
   ┌───┐
   │ D │ Desktop
   └───┘
$(draw Space)
$(draw Footer)"
read -sn1 ch
case "$ch" in
"P"|"p" ) clear; echo "Do you really want to shut down? [Y/n]"; read -sn1 ch; case "$ch" in "Y"|"y") execsudo poweroff; esac;;
"E"|"e" ) exitscr;;
esac;}

# Reset                   ${No_color}
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
function colored(){ echo -e "${Cyan}This ${BIPurple}text ${BBlue}written ${IGreen}with ${On_IRed}different${No_color} ${UWhite}colors!${No_color}";pause; }

reduceconfig(){
if [ "$fastboot" == "1" ]; then
    while read pattern;do
        sed -e '/$pattern/d' $config > /dev/null
    done < "fastboot=1"
    echo fastboot=1 >> $config
else
    while read pattern;do
        sed -e '/$pattern/d' $config > /dev/null
    done < "fastboot=0"
    echo fastboot=0 >> $config
fi

if [ "$updcheck" == "1" ]; then
    while read pattern;do
        sed -e '/$pattern/d' $config > /dev/null
    done < "updcheck=1"
    echo updcheck=1 >> $config
else
    while read pattern;do
        sed -e '/$pattern/d' $config > /dev/null
    done < "updcheck=0"
    echo updcheck=0 >> $config
fi;}

function resscr(){
mkdir -p $HOME/.config/systemd/user/
echo "[Unit]
Description=RDE management service
After=network.target

[Service]
User=$USER
ExecStart=$int
Restart=on-failure

[Install]
WantedBy=multi-user.target" >> $HOME/.config/systemd/user/RDEmanager.service
systemctl --user start RDEmanager
if [ $? != 0 ]; then echo -e "Can't start daemon service.\n\nDo you use systemd?"; pause; fi;}

function debug(){
screen=desktop
sttynorm
clear
echo "Under construction.

s - Sudo rights test        |   sudo var - $sudo
r - RescueScript (Start RDE management service daemon for systemd)
l - cols and lines
a - Reduce config file"
read -sn1 ch
case "$ch" in
"s" ) clear;execsudo touch $sysset; pause;;
"S" ) if read -t 15; then clear;execsudo echo hello; pause;fi;;
"=" ) screen=desktop; desktop;;
"r" ) resscr;;
a ) reduceconfig;;
"l" ) colsandlines;;
esac;}
function colsandlines(){
while sleep 0.1; do
clear
echo -e "Cols: $(tput cols)\nLines: $(tput lines)"
trap "desktop" EXIT
done;}






function configurator(){
screen=desktop
if [ "$inst" == "true " ]; then incol="${BGreen}"; else incol=${BRed};fi
if [ "$updcheck" == "1" ]; then updcol="${BGreen}"; else updcol=${BRed};fi
if [ "$logon" == "1" ]; then logcol="${BGreen}"; else logcol=${BRed};fi
if [ "$fastboot" == "1" ]; then fbcol="${BGreen}"; else fbcol=${BRed};fi
if [ "$lock" == "1" ]; then locol="${BGreen}"; else locol=${BRed};fi
if [ "$sw" == "1" ]; then swcol="${BGreen}"; else swcol=${BRed};fi
while sleep 1; do
getcols;let colsc=cols-6
getlines;let colsd=cols-37
trap "desktop" SIGINT
clear
echo -e "
   $(draw Upperbar-Head-conf)
   │ RDE Configurator$(for (( i=1; i <= $colsd; i++ ));do echo -n " ";done)[Main screen] │
   $(draw Upperbar-Botton-conf)

      Welcome to RDE configurator!                            Installed: ${incol}$inst${No_color}
      ${BRed}0${No_color} - Turned off
      ${BGreen}1${No_color} - Turned on

      [W - ${BIBlue}$REL${No_color}] - RDE Release

      [I] - Install requrements                               [Z] - Remove RDE
      [S - ${updcol}$updcheck${No_color}] - Check updates on startup                      [X] - Reinstall RDE from current file
      [R - ${logcol}$logon${No_color}] - Run RDE after logging in TTY                  [C] - Check update
      [F - ${fbcol}$fastboot${No_color}] - Enable FastBoot                               [V] - Legacy mode
      [L - ${locol}$lock${No_color}] - Setup lockscreen
      [A - ${swcol}$sw${No_color}] - Turn this configuration to system-wide        [K] - ON/OFF cursor blink
"
read -sn1 conf
case "$conf" in
    "w" | "W" ) if [ "$RELEASE" == "dev " ];then echo -e "RELEASE=\"user\"" >> $set;RELEASE="user"
                else echo -e "RELEASE=\"dev \"" >> $set;RELEASE="dev ";fi;;

    "i" | "I" )execsudo apt install -y ncal dialog wget bash lynx mc mpv;;

    "s" | "S" )if [ "$updcheck" == "1" ]; then echo -e "updcheck=\"0\"" >> $set;updcheck="0";updcol="${BRed}"
               else echo -e "updcheck=\"1\"" >> $set;updcheck="1";updcol="${BGreen}";fi;;

    "r" | "R" );;

    "f" | "F" )if [ "$fastboot" == "1" ];then echo -e "fastboot=\"0\"" >> $set;fastboot="0";fbcol="${BRed}"
               else echo -e "fastboot=\"1\"" >> $set;fastboot="1";fbcol="${BGreen}";fi;;

    "l" | "L" )sttynorm;echo -e "Enter \"-\" to disable password\nor\nPlease, type your new password:\n";read -s passwd;if [ "$passwd" != "-" ];then echo "pass1=$passwd" >> $set;fi;stty -icanon -icrnl time 0 min 0;;

    "a" | "A" )if [ "$sw" == "1" ];then echo -e "sw=\"0\"" >> $set;sw=0;swcol="${BRed}";execsudo rm $sysset; execsudo cp $HOME/.config/RDE/settings.conf $sysset
               else echo -e "sw=\"1\"" >> $set;sw=1;swcol="${BGreen}";execsudo rm $sysset; execsudo touch $sysset;fi;;

    "z" | "Z" )remove;;

    "x" | "X" )reinstall;;

    "c" | "C" )update;;

    "v" | "V" )curl -s https://raw.githubusercontent.com/Russanandres/RDE/main/RDE_fallback.sh -o $userdata/RDEf.sh; bash $userdata/RDEf.sh;;
    "k" | "K" ) if [ "$blink" == "1" ]; then tput civis; blink="0"; else tput cnorm;blink="1";fi;sleep 2;;

    "d" | "D" ) desktop;;
esac
done
}



function update(){
screen=update
sttynorm
getcols;let colsc=cols-7
getlines;let colsd=cols-33
clear
echo "
   $(draw Upperbar-Head-conf)
   │ RDE Updater$(for (( i=1; i <= $colsd; i++ ));do echo -n " ";done)[part 1 of 2] │
   $(draw Upperbar-Botton-conf)


      Welcome to the RDE update system.

      We are downloading the latest version from the github on the official repository.
      Please check your internet connection.

       - Press ENTER to update.
       - Press CTRL + C to exit.
"
read -sn1
clear
echo "
   $(draw Upperbar-Head-conf)
   │ RDE Updater$(for (( i=1; i <= $colsd; i++ ));do echo -n " ";done)[part 2 of 2] │
   $(draw Upperbar-Botton-conf)


    We updating your Desktop Environment..."
loading &
if [ "$RELEASE" == "user" ]; then
wget -q https://raw.githubusercontent.com/Russanandres/RDE/main/de.sh -O /tmp/RDE.sh
elif [ "$RELEASE" == "dev " ]; then
wget -q https://raw.githubusercontent.com/Russanandres/RDE/main/dev.sh -O /tmp/RDE.sh
fi
bash /tmp/RDE.sh
printf '\033[8;27;104t'
}


function reinstall(){
screen=reinstall
sttynorm
getcols;let colsc=cols-6
getlines;let colsd=cols-35
clear
echo "
   $(draw Upperbar-Head-conf)
   │ RDE reInstallion$(for (( i=1; i <= $colsd; i++ ));do echo -n " ";done)[part 1 of 1] │
   $(draw Upperbar-Botton-conf)


      Hello!

      We are reinstalling your RDE.
      Please wait...
"
tput civis
loading &
if [ "$RELEASE" == "user" ]; then
wget -q https://raw.githubusercontent.com/Russanandres/RDE/main/de.sh -O /tmp/RDE.sh
elif [ "$RELEASE" == "dev " ]; then
wget -q https://raw.githubusercontent.com/Russanandres/RDE/main/dev.sh -O /tmp/RDE.sh
else echo -e "\n\n We can't detect your RDE release type!";error
fi

execsudo rm $int
execsudo cp ./$0 $int
execsudo chmod +x $int

sleep 2
kill "$!"
tput cnorm
exitscr
}

function remove(){
screen=remove
sttynorm
getcols;let colsc=cols-6
getlines;let colsd=cols-37
clear
echo "
   $(draw Upperbar-Head-conf)
   │ RDE deInstallion$(for (( i=1; i <= $colsd; i++ ));do echo -n " ";done)[part 1 of 3] │
   $(draw Upperbar-Botton-conf)


      Hello!

      We are very sorry that you have to uninstall RDE.
      If you have any problems, please create an issue on github.

       - Press ENTER to uninstall.
       - Press CTRL + C to exit.
"
read -sn1
sec=4; timer=0
while [ "$timer" -lt "4" ]; do
clear
let timer=timer+1
let sec=sec-1
echo "
   $(draw Upperbar-Head-conf)
   │ RDE deInstallion$(for (( i=1; i <= $colsd; i++ ));do echo -n " ";done)[part 2 of 3] │
   $(draw Upperbar-Botton-conf)


     RDE deInstallion will be started after $sec...
"
sleep 1
done
tput civis
loading &
execsudo rm $int
rm -rf /tmp/RDE
mkdir -p /tmp/RDE/$USER/
mkdir -p /tmp/RDE/system
mv -f $HOME/.config/RDE /tmp/RDE/$USER/
execsudo mv -f /usr/share/RDE /tmp/RDE/system/
execsudo rm -rf /usr/share/RDE
rm -rf $HOME/.config/RDE
rm -rf $HOME/.config/RDE_old
sleep 2
kill "$!"
clear
echo "
   $(draw Upperbar-Head-conf)
   │ RDE deInstallion$(for (( i=1; i <= $colsd; i++ ));do echo -n " ";done)[part 3 of 3] │
   $(draw Upperbar-Botton-conf)


      RDE has been successfully uninstalled on your PC!

      We are waiting for you again!
      All your and system settings temporally saved in /tmp/RDE.
      The uninstaller will close in a couple of seconds.
"
sleep 3
tput cnorm
exitscr
}




function drawtestwindow(){ clear
getlines;getcols
colsdoffset=4       # Offset for Title                           (Symbols of header name)
let colsc=cols-23   # Offset for date and time + Corner elements (23 is +- default)
let linesd=lines-5  # Offset for menu and header                 (3 is header, 1 is menu, 1 empty line)
draw Header Test
draw Space
draw Footer;exit;}




$gotofunc
if [ "$screen" == "startingup" ]; then desktop
else $screen
fi






done
else
tput civis;sttynorm
getcols;let colsc=cols-6
getlines;let colsd=cols-35; let linesd=lines-16
clear
echo "
   $(draw Upperbar-Head-conf)
   │ RDE Installion$(for (( i=1; i <= $colsd; i++ ));do echo -n " ";done)[part 1 of 3] │
   $(draw Upperbar-Botton-conf)


      Welcome to the first boot of RDE!

      This pseudo-graphical shell will try to make you comfortable in the terminal.
      The environment will now be installed on your computer.

       - Press ENTER to continue
       - Press CTRL + C to exit."
draw Space
read -sn1 -p "       Press any button to continue"
clear; err=0
sec=4; timer=0
while [ "$timer" -lt "4" ]; do
clear
let timer=timer+1
let sec=sec-1
echo "
$(draw Upperbar-Head-conf)
   │ RDE Installion$(for (( i=1; i <= $colsd; i++ ));do echo -n " ";done)[part 2 of 3] │
$(draw Upperbar-Botton-conf)


    Installing of RSAR's Desktop Environment will be started after $sec seconds...
"
sleep 1
done
loading &

execsudo cp ./$0 $int
if [ "$?" == "0" ]; then errcopy="copy OK";else errorcopy="copy ERROR";let err=$err+1;fi
execsudo chmod +x $int
if [ "$?" == "0" ]; then errexec="make executable OK";else errexec="make executable ERROR";let err=$err+1;fi

mkdir /usr/share/RDE
mkdir $HOME/.config/RDE/
if [ "$?" == "0" ]; then errhome="create home OK";else errhome="create home ERROR";let err=$err+1;fi

mkdir $HOME/.config/RDE/themes
mkdir $HOME/.config/RDE/languages
mkdir $HOME/.config/RDE/old
mkdir $HOME/.config/RDE/apps
touch $HOME/.config/RDE/settings.conf
if [ "$?" == "0" ]; then errset="create user config OK";else errset="create user config ERROR";let err=$err+1;fi


execsudo touch $sysset
if [ "$?" == "0" ]; then errsw="create system-wide config OK";else errsw="create system-wide config ERROR";let err=$err+1;fi

if [ ! -f $HOME/.config/RDE/settings.conf ];then
echo "int=$int" > $HOME/.config/RDE/settings.conf
echo "userdata=$userdata" >> $HOME/.config/RDE/settings.conf
echo "fastboot=$fastboot" >> $HOME/.config/RDE/settings.conf
echo "sysset=$sysset" >> $HOME/.config/RDE/settings.conf
echo "sw=$sw" >> $HOME/.config/RDE/settings.conf
echo "logon=$logon" >> $HOME/.config/RDE/settings.conf
echo "updcheck=$updcheck" >> $HOME/.config/RDE/settings.conf
fi

sleep 2
kill "$!"
timer=0

if [ "$err" == "0" ]; then sec=4
while [ "$timer" -lt "4" ]; do
clear
let timer=timer+1
let sec=sec-1
echo "
   $(draw Upperbar-Head-conf)
   │ RDE Installion$(for (( i=1; i <= $colsd; i++ ));do echo -n " ";done)[part 3 of 3] │
   $(draw Upperbar-Botton-conf)


      RDE has been successfully installed on your PC!

      Please write runui to run RDE.
      The installer will close in $sec.
"
sleep 1
done
clear

else

sec=7
while [ "$timer" -lt "7" ]; do
clear
let timer=timer+1
let sec=sec-1
echo "
$(draw Upperbar-Head-conf)
   │ RDE Installion$(for (( i=1; i <= $colsd; i++ ));do echo -n " ";done)[part 3 of 3] │
$(draw Upperbar-Botton-conf)


      RDE has been unsuccessfully installed with $err total errors!

      Log is:

      $errcopy
      $errexec
      $errhome
      $errset
      $errsw

      You can ignore this errors and continue use RDE, but some features can be broken.

      The installer will close in $sec
"
sleep 1
done
fi
stty "$SAVED_STTY"
tput cnorm
echo -e "Run ${int##*/} to open RDE.\n\nRSAR's Desktop Environment $VER - 2024. Russanandres"
date
exit
fi
echo "Onwards here if you believe!"
