#!/bin/bash

VER="1.1"
RELEASE="dev "
startuptime=$(date)
export SAVED_STTY="`stty --save`"
userdata="$HOME/.config/YDE"
int="/usr/bin/runui"
sysset="/usr/share/YDE/settings.conf"
set="$userdata/settings.conf"
updcheck=0;fastboot=0;logon=0;lock=0;sw=0

source $sysset &> /dev/null
source $HOME/.config/YDE/settings.conf &> /dev/null


function pause(){ read -sn1 -p "Press ENTER to continue....";}
function sttynorm(){ stty "$SAVED_STTY"; }
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

if [ -f "$int" ]; then inst="true ";else inst="false";fi
if [ $RELEASE == user ]; then REL="$0"; else REL="dev.sh";fi



function windows(){
while sleep 0.5; do
if [ $(tput cols) != 104 ] || [ $(tput lines) != 27 ]; then printf '\033[8;27;104t'; fi
done &
}


function check(){
mkdir -vp $HOME/.config/YDE/
mkdir -v $HOME/.config/YDE/themes
mkdir -v $HOME/.config/YDE/languages
mkdir -v $HOME/.config/YDE/old
mkdir -v $HOME/.config/YDE/apps
touch $HOME/.config/YDE/settings.conf
if [ "$sudo" == "1" ]; then sudo mkdir -v /usr/share/YDE; else mkdir -v /usr/share/YDE;fi
if [ "$sudo" == "1" ]; then sudo touch $sysset; else touch $sysset;fi
echo "YDE files has been successfully checked!";exit; }



function helpscr(){
echo "Your Desktop Environment. By Russanandres.
Usage: $REL [option]
Availiable options:
    -p | --portable     >>  Run YDE without install
    -v | --version      >>  Show YDE version
    -q | --force-quit   >>  Force quit from YDE
    -c | --legacy       >>  Run YDE in legacy mode
    -h | --help         >>  Show help manual

Additional options:
    --backup            >>  Backup your YDE folder
    --check             >>  Diagnose your YDE folder
    --settings          >>  Difine your own settings file
    --sudo              >>  Allow YDE request sudo rights
    --erase-content     >>  Factory reset YDE
    --target %path%     >>  Locate YDE to install
    --no-check-integrity>>  Don't check user files for corrupt
    --observe-size      >>  Control size and resize terminal"; exit; }



while [ "$1" != "" ]; do
    case $1 in
        -v ) echo $VER; exit;;


        -h | --help )       helpscr;;
        -q | --force-quit ) exitscr;;
        -c | --legacy )     curl -s https://raw.githubusercontent.com/Russanandres/YDE/main/YDE_fallback.sh | bash;;
        -p | --portable )   portable="1";;
        -f | --fastboot )   fastboot="1";;


        --version ) echo -e "Your Desktop Environment $VER by Russanandres. \nThanks for using $REL!";exit;;
        --backup )  backuppath="$HOME/.config/YDE_old/$(date +%d-%m-%y)"
                    mkdir -p $backuppath; echo "Created folder $backuppath"
                    cp -r $HOME/.config/YDE $backuppath; s1=$?; if [ "$s1" == "0" ]; then echo "Copied user folder"; fi
                    cp $int $backuppath; s2=$?; if [ "$s2" == "0" ]; then echo "Copied script"; fi
                    if [ "$s1" == "0" ] && [ "$s2" == "0" ]; then echo "Backup successfull";exit
                    else echo "Can't create backup!";rm -rf $backuppath;exit;fi;;
        --check )   check;;
        --erase-content ) rm /tmp/updatingYDE.tmp; rm -r $HOME/.config/YDE/; sudo rm /usr/share/YDE/settings.conf;check;;
        --settings ) source $2; set=$2;shift;;
        --sudo ) sudo=1;;
        --target ) if [ -z "$2" ]; then echo -e "Please enter install path after variable \nLike --target /usr/bin/yde"; exit
                   else int=$2;shift;fi;;
        # EXPEREMENTAL
        --userdata )  if [ -z "$2" ]; then true;else userdatanew=$2;echo "userdata=$userdatanew" >> $set;shift;fi;;
        --func ) gotofunc=$2; shift;;
        --turn-off-blink ) blink=0;tput civis;;
        --no-check-integrity ) nocheck=1;;
        --observe-size ) windows;;
        # Modify startup environments (as possible)
        --check-updates )   updcheck="1";;
        --logon ) logon="1";;
        --lock ) lock="1"; pass1=$2;shift;;
        --sw ) sw="1";;
    esac
    shift
done


clear

if [ "$updcheck" == "1" ]; then
loading &
gitver=$(curl -f -# https://raw.githubusercontent.com/Russanandres/YDE/main/lastversion)
if [ "$VER" == "$gitver" ]; then echo "All ok!";sleep 0.5
elif [ "$gitver" -gt "$VER" ]; then echo "You have old version of script! Please update it!";pause
elif [ "$gitver" -lt "$VER" ]; then echo "You somehow have newer version, than availible in repository! Please create issue in github!";pause
fi
kill "$!";fi

if [ -f "/tmp/updatingYDE.tmp" ]; then
loading &
sudo rm $int
sudo cp ./$0 $int
sudo chmod +x $int
rm /tmp/updatingYDE.tmp
sleep 2
kill "$!"
clear
fi

if [ ! -f "$HOME/.config/YDE/settings.conf" ] && [ "$portable" != "1" ] && [ -f "$int" ] && [ "$nocheck" != "1" ]; then
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
fi

function error(){
echo -e "
   ┌─────────────────────────────────────────────────────────────────────────────────────────────────┐
   │ YDE Error reporter $VER                                                                  ${BIRed}[ERROR]${No_color} │
   └─────────────────────────────────────────────────────────────────────────────────────────────────┘

     Somewhere in the script appears error!
     YDE can't find errors automatically(
     Please check screenlog, try reinstall yde or use it in portable mode.

     Also, you can tell about this bug to developer (@Russanandres).
";exit;}



if [ -f "$int" ] || [ "$portable" == "1" ]; then
printf '\033[8;27;104t'
clear
echo -n "┌                                                                                                      ┐


                                    Loading Your Desktop Environment
















                                                   ";tput civis;loading &
screen=startingup
stty -icanon -icrnl time 0 min 0
if [ "$fastboot" != "1" ]; then sleep 1.3;fi
printf '\033[8;27;104t'
kill "$!";if [ "$blink" != "0" ]; then tput cnorm;fi

while true; do ################## ParT Start of something beautiful (Hell no)
function start(){
screen=start
clear
echo -e "┌───────────────────────────────────────────── Homescreen ─────────────────────────────────────────────┐
│                                                                                                      │
│  ┌───┐              ┌───┐               ┌───┐                                                        │
│  │ A │ About YDE    │ X │ Clock         │ ? │ Undefined                                              │
│  └───┘              └───┘               └───┘                                                        │
│  ┌───┐              ┌───┐                                                                            │
│  │ E │ Exit YDE     │ C │ Configurator                                                               │
│  └───┘              └───┘                                                                            │
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
"S"|"s" ) sttynorm;start;;
"1" ) sttynorm;exitscr;;
"L"|"l" ) sttynorm;lock;;
"~" ) sttynorm;debug;;
esac;break
else sleep 0.5;fi;done
}

function yourapps(){
screen=yourapps
echo -e "┌────────────────────────────────────────────── YDE Apps ──────────────────────────────────────────────┐

  ┌───┐
  │ 1 │
  └───┘
  ┌───┐
  │ 2 │
  └───┘
  ┌───┐
  │ 3 │
  └───┘











┌──────────────────────────────────────────────────────────────────────────────────────────────────────┐
│ [YDE]                                                                             [$(date +%D)] [$(date +%H:%M)] │
└──────────────────────────────────────────────────────────────────────────────────────────────────────┘"

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
│ Release: $RELEASE                                                                                        │
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



function sysabout(){
screen=sysabout
stty -icanon -icrnl time 0 min 0
if [ "$(hostnamectl chassis)" == "laptop" ];then hasbattery=1;fi
while true; do
trap "exitscr" SIGINT
clear
echo -e "
┌──────────────────────────────────────────── About System ────────────────────────────────────────────┐
│                                                                                                      │
│  System Kernel: $(uname -rm)
│
│  OS Type: $OSTYPE
│  $(hostnamectl | grep System)
│
│$(hostnamectl | grep "Hardware Model")
│
│
│
│
│
│
│
│
│
│
│
│
│
│                                                                            Batttery percentage: $bat%
├──────────────────────────────────────────────────────────────────────────────────────────────────────┐
│ [S] Homescreen                                                               [$(date +%D)] [$(date +%H:%M:%S)] ${BRed}D${No_color} │
└──────────────────────────────────────────────────────────────────────────────────────────────────────┘"
bat="$(cat /sys/class/power_supply/BAT1/capacity)"
if read -t 0; then
read -n 1 char
case "$char" in
"S"|"s" ) start;;
"D"|"d" ) desktop;;
esac;break
else sleep 0.5;fi;done
}




function clock(){
while sleep 1;do
clear
echo -e "13256278887989457651018865901401704640782365987321562315876321089356230569230965691230568320985414719943
146327141023${BIRed}$(date +%H)${No_color}58962157813246038295603891732589740891325632179${BIBlue}Hours${No_color}72895632401486327890128914876329144016
10238911584142038723814702136981562038350239768947613256789289471028947639178947195372523789512305731980
023576214${BIBlue}Minutes${No_color}314274214137241027429815127459812740129${BIRed}$(date +%M)${No_color}31720971957218019587312957109472957312095780912
82765392361544132764802151276541287613275612087232087167326153285621096357129091235634589326109658921655
19238456231049312658127846480723560498261589740814673825697436578326049675782365743865120347680312564301
95781235621985629871563124520158940912785631278945631298746102785621975631278043289462571938245723561573
178953172307816958917898750938537460823591364${BIBlue}Seconds${No_color}902614902631382719876932187209217091875618${BIRed}$(date +%S)${No_color}81702843
15782091879356870728941789006731123579134567815987612550049731689615872689713097861157986725146789009874
012956327${BIRed}$(date +%d)${No_color}512408321756432752318748389473625023565143250182963572310838${BIBlue}Day${No_color}672104723562019432628634891435
09283475674389458765473829348576584930239485765483920934857658493023948576859430239485678594034958678596
12345678909876543234567890987654321234567890987654321234567890987654321234567890987654321234567890987654
420${BIBlue}Month${No_color}469578216578968923742043628942073904204179489127${BIRed}$(date +%m)${No_color}4201497184721094420120948734981074420141034420
91280357294152730984732605791864832176593728160238196894672497326189652309846732980689723089156098895019
29357621387563289469872316749758326184906327849836278953216049236512890567832106897695623890157621809561
74129849123456312084632017349862359403678649832765423809652189056123890751890576328905632197548932257820
69289472894721849612875613287652569348564387829112963421976843267893218796517695279157965962721679851969
20225416259861${BIRed}$(date +%Y)${No_color}26314192738572369857613278649823651784${BIBlue}Year${No_color}85632498743985273501238765896438967679232023
25163278476321894728596310325894368572309863892758460289750783260189563478061289567812306981567123780600
10821395607236823567801247849162353018274683125128905620381753478561951369583267801489739825638905137289
01298374650192837465102${BIBlue}Day${No_color}$(date +%q)${BIBlue}Of${No_color}$(date +%u)${BIBlue}Week${No_color}38475602934857620394857620938475602934857647565372${BIRed}$(date +%a)${No_color}28374567483929458
40455597400772545991068448662128914785645348115465743829834756748392034857658675685697178483473935842396
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1  [01011001 01000100 01000101] 420461982375678321589023657834615289030653478901589265784360346985769  1
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000"
trap "desktop" EXIT
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
done;}
function unlock(){
sttynorm
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
│ Unlock PC with your password:                                                                        │
└──────────────────────────────────────────────────────────────────────────────────────────────────────┘"
read -e pass
if [ $pass1 -eq $pass ]; then desktop; else echo "Password do not match! Please try again!"; sleep 3; lock; fi
pause;}





### Under construction things

function exitt(){
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
"P"|"p" ) clear; echo "Do you really want to shut down? [Y/n]"; read -sn1 ch; case "$ch" in "Y"|"y") sudo poweroff; esac;;
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
Description=YDE management service
After=network.target

[Service]
User=$USER
ExecStart=$int
Restart=on-failure

[Install]
WantedBy=multi-user.target" >> $HOME/.config/systemd/user/ydemanager.service
systemctl --user start ydemanager
if [ $? != 0 ]; then echo -e "Can't start daemon service.\n\nDo you use systemd?"; pause; fi;}

function debug(){
screen=desktop
sttynorm
clear
echo "Under construction.

s - Sudo rights test        |   sudo var - $sudo
r - RescueScript (Start YDE management service daemon for systemd)
l - cols and lines
a - Reduce config file"
read -sn1 ch
case "$ch" in
"s" ) clear;sudo echo hello; read -sn1 ch;;
"S" ) if read -t 15; then clear;sudo echo hello; read -sn1 ch;fi;;
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
printf '\033[8;27;104t'
if [ "$inst" == "true " ]; then incol="${BGreen}"; else incol=${BRed};fi
if [ "$updcheck" == "1" ]; then updcol="${BGreen}"; else updcol=${BRed};fi
if [ "$logon" == "1" ]; then logcol="${BGreen}"; else logcol=${BRed};fi
if [ "$fastboot" == "1" ]; then fbcol="${BGreen}"; else fbcol=${BRed};fi
if [ "$lock" == "1" ]; then locol="${BGreen}"; else locol=${BRed};fi
if [ "$sw" == "1" ]; then swcol="${BGreen}"; else swcol=${BRed};fi
while sleep 1; do
clear
echo -e "
   ┌────────────────────────────────────────────────────────────────────────────────────────────────┐
   │ YDE Configurator                                                                 [Main screen] │
   └────────────────────────────────────────────────────────────────────────────────────────────────┘

      Welcome to YDE configurator!                            Installed: ${incol}$inst${No_color}
      ${BRed}0${No_color} - Turned off
      ${BGreen}1${No_color} - Turned on

      [W - ${BIBlue}$REL${No_color}] - YDE Release

      [I] - Install requrements                               [Z] - Remove YDE
      [S - ${updcol}$updcheck${No_color}] - Check updates on startup                      [X] - Reinstall YDE from current file
      [R - ${logcol}$logon${No_color}] - Run YDE after logging in TTY                  [C] - Check update
      [F - ${fbcol}$fastboot${No_color}] - Enable FastBoot                               [V] - Legacy mode
      [L - ${locol}$lock${No_color}] - Setup lockscreen
      [A - ${swcol}$sw${No_color}] - Turn this configuration to system-wide        [K] - ON/OFF cursor blink
"
read -sn1 conf
case "$conf" in
    "w" | "W" ) if [ "$RELEASE" == "dev " ];then echo -e "RELEASE=\"user\"" >> $set;RELEASE="user"
                else echo -e "RELEASE=\"dev \"" >> $set;RELEASE="dev ";fi;;

    "i" | "I" )if [ "$sudo" == "1" ]; then sudo apt install -y ncal dialog wget bash lynx mc mpv
               else apt install -y ncal dialog wget bash sudo lynx mc mpv;fi;;

    "s" | "S" )if [ "$updcheck" == "1" ]; then echo -e "updcheck=\"0\"" >> $set;updcheck="0";updcol="${BRed}"
               else echo -e "updcheck=\"1\"" >> $set;updcheck="1";updcol="${BGreen}";fi;;

    "r" | "R" );;

    "f" | "F" )if [ "$fastboot" == "1" ];then echo -e "fastboot=\"0\"" >> $set;fastboot="0";fbcol="${BRed}"
               else echo -e "fastboot=\"1\"" >> $set;fastboot="1";fbcol="${BGreen}";fi;;

    "l" | "L" )sttynorm;echo -e "Enter \"-\" to disable password\nor\nPlease, type your new password:\n";read -s passwd;if [ "$passwd" != "-" ];then echo "pass1=$passwd" >> $set;fi;stty -icanon -icrnl time 0 min 0;;

    "a" | "A" )if [ "$sw" == "1" ];then echo -e "sw=\"0\"" >> $set;sw=0;swcol="${BRed}";if [ "$sudo" == "1" ]; then sudo rm $sysset; sudo cp $HOME/.config/YDE/settings.conf $sysset;else rm $sysset; cp $HOME/.config/YDE/settings.conf $sysset;fi
               else echo -e "sw=\"1\"" >> $set;sw=1;swcol="${BGreen}";if [ "$sudo" == "1" ]; then sudo rm $sysset; sudo touch $sysset;else rm $sysset; touch $sysset;fi;fi;;

    "z" | "Z" )remove;;

    "x" | "X" )reinstall;;

    "c" | "C" )update;;

    "v" | "V" )curl -s https://raw.githubusercontent.com/Russanandres/YDE/main/YDE_fallback.sh | bash;;

    "K" | "K" )if [ "$blink" == "1" ]; then tput civis; blink="0"; else tput cnorm;blink="1";fi;sleep 2;;

    "S" | "s" ) start;;
    "D" | "d" ) desktop;;
esac
done
}



function update(){
screen=update
sttynorm
printf '\033[8;27;107t'
clear
echo "
   ┌───────────────────────────────────────────────────────────────────────────────────────────────────┐
   │ YDE Updater                                                                         [part 1 of 2] │
   └───────────────────────────────────────────────────────────────────────────────────────────────────┘


      Welcome to the YDE update system.

      We are downloading the latest version from the github on the official repository.
      Please check your internet connection.

       - Press ENTER to update.
       - Press CTRL + C to exit.
"
read -sn1
clear
echo "
   ┌───────────────────────────────────────────────────────────────────────────────────────────────────┐
   │ YDE Updater                                                                         [part 2 of 2] │
   └───────────────────────────────────────────────────────────────────────────────────────────────────┘


    We updating your Desktop Environment..."
loading &
touch /tmp/updatingYDE.tmp
if [ "$RELEASE" == "user" ]; then
wget -q https://raw.githubusercontent.com/Russanandres/YDE/main/de.sh -O /tmp/yde.sh
elif [ "$RELEASE" == "dev " ]; then
wget -q https://raw.githubusercontent.com/Russanandres/YDE/main/dev.sh -O /tmp/yde.sh
fi
bash /tmp/yde.sh
printf '\033[8;27;104t'
}


function reinstall(){
screen=reinstall
sttynorm
printf '\033[8;27;107t'
clear
echo "
   ┌───────────────────────────────────────────────────────────────────────────────────────────────────┐
   │ YDE reInstallion                                                                    [part 1 of 1] │
   └───────────────────────────────────────────────────────────────────────────────────────────────────┘


      Hello!

      We are reinstalling your YDE.
      Please wait...
"
tput civis
loading &
if [ "$RELEASE" == "user" ]; then
wget -q https://raw.githubusercontent.com/Russanandres/YDE/main/de.sh -O /tmp/yde.sh
elif [ "$RELEASE" == "dev " ]; then
wget -q https://raw.githubusercontent.com/Russanandres/YDE/main/dev.sh -O /tmp/yde.sh
else echo -e "\n\n We can't detect your YDE release type!";error
fi

if [ "$sudo" == "1" ]; then sudo rm $int;else rm $int;fi
if [ "$sudo" == "1" ]; then sudo cp ./$0 $int;else cp ./$0 $int;fi
if [ "$sudo" == "1" ]; then sudo chmod +x $int;else chmod +x $int;fi

sleep 2
kill "$!"
tput cnorm
exitscr
}

function remove(){
screen=remove
sttynorm
printf '\033[8;27;107t'
clear
echo "
   ┌───────────────────────────────────────────────────────────────────────────────────────────────────┐
   │ YDE deInstallion                                                                    [part 1 of 3] │
   └───────────────────────────────────────────────────────────────────────────────────────────────────┘


      Hello!

      We are very sorry that you have to uninstall YDE.
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
   ┌───────────────────────────────────────────────────────────────────────────────────────────────────┐
   │ YDE deInstallion                                                                    [part 2 of 3] │
   └───────────────────────────────────────────────────────────────────────────────────────────────────┘


     YDE deInstallion will be started after $sec...
"
sleep 1
done
tput civis
loading &
if [ "$sudo" == "1" ]; then sudo rm $int;else rm $int;fi
rm -rf /tmp/YDE
mkdir -p /tmp/YDE/$USER/
mkdir -p /tmp/YDE/system
mv -f $HOME/.config/YDE /tmp/YDE/$USER/
# sudo mv -f /usr/share/YDE /tmp/YDE/system/
if [ "$sudo" == "1" ]; then sudo rm -rf /usr/share/YDE;else rm -rf /usr/share/YDE;fi
rm -rf $HOME/.config/YDE
rm -rf $HOME/.config/YDE_old
sleep 2
kill "$!"
clear
echo "
   ┌───────────────────────────────────────────────────────────────────────────────────────────────────┐
   │ YDE deInstallion                                                                    [part 3 of 3] │
   └───────────────────────────────────────────────────────────────────────────────────────────────────┘


      YDE has been successfully uninstalled on your PC!

      We are waiting for you again!
      All your and system settings temporally saved in /tmp/YDE.
      The uninstaller will close in a couple of seconds.
"
sleep 3
tput cnorm
exitscr
}




$gotofunc
if [ "$screen" == "startingup" ]; then desktop
else $screen
fi






done
else
tput civis;sttynorm
printf '\033[8;27;107t'
clear
echo "
   ┌────────────────────────────────────────────────────────────────────────────────────────────────────┐
   │ YDE Installion                                                                       [part 1 of 3] │
   └────────────────────────────────────────────────────────────────────────────────────────────────────┘


      Welcome to the first boot of YDE!

      This pseudo-graphical shell will try to make you comfortable in the terminal.
      The environment will now be installed on your computer.

       - Press ENTER to continue
       - Press CTRL + C to exit.
"
read -sn1 -p "Press any button to continue"
clear; err=0
sec=4; timer=0
while [ "$timer" -lt "4" ]; do
clear
let timer=timer+1
let sec=sec-1
echo "
   ┌────────────────────────────────────────────────────────────────────────────────────────────────────┐
   │ YDE Installion                                                                       [part 2 of 3] │
   └────────────────────────────────────────────────────────────────────────────────────────────────────┘


    Installing of Your Desktop Environment will be started after $sec seconds...
"
sleep 1
done
loading &

if [ "$sudo" == "1" ]; then sudo cp ./$0 $int; else cp ./$0 $int;fi
if [ "$?" == "0" ]; then errcopy="copy OK";else errorcopy="copy ERROR";let err=$err+1;fi
if [ "$sudo" == "1" ]; then sudo chmod +x $int; else chmod +x $int;fi
if [ "$?" == "0" ]; then errexec="make executable OK";else errexec="make executable ERROR";let err=$err+1;fi

mkdir /usr/share/YDE
mkdir $HOME/.config/YDE/
if [ "$?" == "0" ]; then errhome="create home OK";else errhome="create home ERROR";let err=$err+1;fi

mkdir $HOME/.config/YDE/themes
mkdir $HOME/.config/YDE/languages
mkdir $HOME/.config/YDE/old
mkdir $HOME/.config/YDE/apps
touch $HOME/.config/YDE/settings.conf
if [ "$?" == "0" ]; then errset="create user config OK";else errset="create user config ERROR";let err=$err+1;fi


if [ "$sudo" == "1" ]; then sudo touch $sysset; else touch $sysset;fi
if [ "$?" == "0" ]; then errsw="create system-wide config OK";else errsw="create system-wide config ERROR";let err=$err+1;fi

if [ ! -f $HOME/.config/YDE/settings.conf ];then
echo int="$int" > $HOME/.config/YDE/settings.conf
echo userdata="$userdata" >> $HOME/.config/YDE/settings.conf
echo fastboot="$fastboot" >> $HOME/.config/YDE/settings.conf
echo sysset="$sysset" >> $HOME/.config/YDE/settings.conf
echo sw="$sw" >> $HOME/.config/YDE/settings.conf
echo logon="$logon" >> $HOME/.config/YDE/settings.conf
echo updcheck="$updcheck" >> $HOME/.config/YDE/settings.conf
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
   ┌───────────────────────────────────────────────────────────────────────────────────────────────────┐
   │ YDE Installion                                                                      [part 3 of 3] │
   └───────────────────────────────────────────────────────────────────────────────────────────────────┘


      YDE has been successfully installed on your PC!

      Please write runui to run YDE.
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
   ┌────────────────────────────────────────────────────────────────────────────────────────────────────┐
   │ YDE Installion                                                                       [part 3 of 3] │
   └────────────────────────────────────────────────────────────────────────────────────────────────────┘


      YDE has been unsuccessfully installed with $err total errors!

      Log is:

      $errcopy
      $errexec
      $errhome
      $errset
      $errsw

      You can ignore this errors and continue using YDE, but some features can be broken.

      The installer will close in $sec
"
sleep 1
done
fi
stty "$SAVED_STTY"
tput cnorm
echo -e "Run ${int##*/} to open YDE.\n\nYour Desktop Environment $VER - 2022-2023. Russanandres"
date
exit
fi
echo "Onwards here if you believe!"
