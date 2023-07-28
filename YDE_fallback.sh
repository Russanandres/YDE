#!/bin/bash
VER="1.0"
startuptime=$(date)
int=/usr/bin/safeui
# source ~/.config/YDE/settings.conf
source ~/.config/YDE/fallback.conf
function pause(){ read -p "Press ENTER to continue...." ; }
function exitscr(){
 clear
 echo "Your Desktop Environment $VER - 2022-2023. Russanandres"
 date
 exit
}
trap "exitscr" SIGINT
if [ -f "$int" ]; then inst="true "; else inst=false; fi


function helpscr(){
echo "YDE_Fallback. By Russanandres.
Usage: YDE_fallback.sh [option]
Availiable options:
    -v | --version      >>  Show script version
    -q | --force-quit   >>  Force quit from script
    -p | --portable     >>  Run script without install
    -h | --help         >>  Show help manual"; exit
}

while [ "$1" != "" ]; do
    case $1 in
        -v | --version ) echo "YDE Fallback $VER";;
        -h | --help ) helpscr;;
        -q | --force-quit ) exitscr;;
        -p | --portable ) portable=1;;
    esac
    shift
done
clear
if [ -f "$int" ] || [ "$portable" == "1" ]; then
clear
echo "Loading Your Desktop Environment..."
source /usr/share/YDE/settings.conf
printf '\033[8;17;63t'
screen=startingup
kill "$!"
while true; do
function start(){
screen=start
clear
echo "┌──────────────────────── Homescreen ────────────────────────┐"
echo "│                                                            │"
echo "│  ┌───┐                                                     │"
echo "│  │ E │ Exit YDE                                            │"
echo "│  └───┘                                                     │"
echo "│  ┌───┐                                                     │"
echo "│  │ P │ Poweroff                                            │"
echo "│  └───┘                                                     │"
echo "│  ┌───┐                                                     │"
echo "│  │ D │ Desktop                                             │"
echo "│  └───┘                                                     │"
echo "│                                                            │"
echo "│                                                            │"
echo "│                                                            │"
echo "│ [S] Homescreen                          [$(date +%D)] [$(date +%H:%M)] │"
echo "└────────────────────────────────────────────────────────────┘"
read -sn1 ch
case "$ch" in
"E"|"e" ) exitscr;;
"P"|"p" ) sudo poweroff;;
"D"|"d" ) desktop;;
"S"|"s" ) desktop;;
esac;}
function desktop(){
screen=desktop
clear
echo "┌─────────────────────── Your Desktop ───────────────────────┐"
echo "│ [1] - About YDE                                            │"
echo "│ [2] - Back to Command line                                 │"
echo "│ [3] - Environment settings                                 │"
echo "│                                                            │"
echo "│                   ___  _ ____  _____                       │"
echo "│                   \  \///  _ \/  __/                       │"
echo "│                    \  / | | \||  \                         │"
echo "│                    / /  | |_/||  /_                        │"
echo "│                   /_/   \____/\____\                       │"
echo "│                                                            │"
echo "│                                                            │"
echo "│                                                            │"
echo "│                                             [c] - Clock    │"
echo "│ [S] Homescreen                          [$(date +%D)] [$(date +%H:%M)] │"
echo "└────────────────────────────────────────────────────────────┘"
read -sn1 ch
case "$ch" in
"S"|"s" ) start;;
"C"|"c" ) clock;;
"1" ) about;;
"2" ) exitscr;;
"3" ) settings;;
esac;}
function about(){
screen=about
clear
echo "┌─────────────────────── About Desktop ──────────────────────┐"
echo "│ Your Fallback Desktop Environment                          │"
echo "│ Version $VER                                                │"
echo "│                                                            │"
echo "│                                                            │"
echo "│                   ___  _ ____  _____                       │"
echo "│                   \  \///  _ \/  __/                       │"
echo "│                    \  / | | \||  \                         │"
echo "│                    / /  | |_/||  /_                        │"
echo "│                   /_/   \____/\____\                       │"
echo "│                                                            │"
echo "│                                                            │"
echo "│                                                            │"
echo "│                                                            │"
echo "│ [S] Homescreen                          [$(date +%D)] [$(date +%H:%M)] │"
echo "└────────────────────────────────────────────────────────────┘"
read -sn1 ch
case "$ch" in
"S"|"s" ) start;;
"D"|"d" ) desktop;;
esac;}
function settings(){
screen=settings
clear
echo "┌───────────────────── Desktop Settings ─────────────────────┐"
echo "│                                                            │"
echo "│ [-] Installed - $inst                                      │"
echo "│                                                            │"
echo "│ [Q] Reinstall from YDE_fallback.sh                         │"
echo "│ [R] Remove YDE                                             │"
echo "│                                                            │"
echo "│ [I] Install classic version                                │"
echo "│                                                            │"
echo "│                                                            │"
echo "│                                                            │"
echo "│                                                            │"
echo "│                                                            │"
echo "│                                                            │"
echo "│ [S] Homescreen                          [$(date +%D)] [$(date +%H:%M)] │"
echo "└────────────────────────────────────────────────────────────┘"
read -sn1 ch
case "$ch" in
"T"|"t" ) themes;;
"R"|"r" ) remove;;
"Q"|"q" ) reinstall;;
"S"|"s" ) start;;
"D"|"d" ) desktop;;
"I"|"i" ) curl -s https://raw.githubusercontent.com/Russanandres/YDE/main/de.sh | bash;;
esac;}
function clock(){
clear
while sleep 1; do
clear
echo "┌─────────────────────────── Clock ──────────────────────────┐"
echo "│                                                            │"
echo "│      Now is:                                               │"
echo "│  $(date +%D) $(date +%H:%M:%S)                                         │"
echo "│         $(date +%a)                                                 │"
echo "│                                                            │"
echo "│                                                            │"
echo "│                   ___  _ ____  _____                       │"
echo "│                   \  \///  _ \/  __/                       │"
echo "│                    \  / | | \||  \                         │"
echo "│                    / /  | |_/||  /_                        │"
echo "│                   /_/   \____/\____\                       │"
echo "│                                                            │"
echo "│                                                            │"
echo "│ Press CTRL + C to exit                                     │"
echo "└────────────────────────────────────────────────────────────┘"
trap "desktop" EXIT
done;}
function reinstall(){
printf '\033[8;17;66t'
screen=reinstall
clear
echo
echo "   ┌────────────────────────────────────────────────────────────┐"
echo "   │ YDEf reInstallion                            [part 1 of 1] │"
echo "   └────────────────────────────────────────────────────────────┘"
echo
echo
echo "      Hello!"
echo
echo "      We are reinstalling your YDE fallback."
echo "      Please wait."
sudo rm $int
sudo cp ./$0 $int
sudo chmod +x $int
sleep 2
kill "$!"
exitscr;}
function remove(){
printf '\033[8;17;66t'
screen=remove
clear
echo
echo "   ┌────────────────────────────────────────────────────────────┐"
echo "   │ YDEf deInstallion                            [part 1 of 3] │"
echo "   └────────────────────────────────────────────────────────────┘"
echo
echo
echo "      Hello!"
echo
echo "      We are very sorry that you have to uninstall YDE fallback."
echo "      If you have any problems, please create an issue on github."
echo
echo "       - Press ENTER to uninstall."
echo "       - Press CTRL + C to exit."
echo
pause
clear
echo
echo "   ┌────────────────────────────────────────────────────────────┐"
echo "   │ YDEf deInstallion                            [part 2 of 3] │"
echo "   └────────────────────────────────────────────────────────────┘"
echo
echo
echo "      We uninstalling YDE fallback. Please wait."
loading &
sudo rm $int
rm -f ~/.config/YDE/fallback.conf
sleep 2
kill "$!"
clear
echo
echo "   ┌────────────────────────────────────────────────────────────┐"
echo "   │ YDEf deInstallion                            [part 3 of 3] │"
echo "   └────────────────────────────────────────────────────────────┘"
echo
echo
echo "      YDE fallback has been successfully uninstalled on your PC!"
echo
echo "      We are waiting for you again!"
echo "      The uninstaller will close in a couple of seconds."
echo
sleep 3
exitscr;}
if [ "$screen" == "startingup" ]; then desktop; else $screen; fi
done
else
printf '\033[8;17;66t'
clear
echo
echo "   ┌────────────────────────────────────────────────────────────┐"
echo "   │ YDEf Installion                               [part 1 of 3] │"
echo "   └────────────────────────────────────────────────────────────┘"
echo
echo
echo "      Welcome to the first boot of YDE fallback!"
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
echo "   ┌────────────────────────────────────────────────────────────┐"
echo "   │ YDEf Installion                               [part 2 of 3] │"
echo "   └────────────────────────────────────────────────────────────┘"
echo
echo
echo "    We installing the required parts..."
echo
sudo cp ./$0 $int
sudo chmod +x $int
sudo mkdir /usr/share/YDE
mkdir ~/.config/YDE/
mkdir ~/.config/YDE/themes
mkdir ~/.config/YDE/languages
mkdir ~/.config/YDE/old
# touch ~/.config/YDE/yde.log
touch ~/.config/YDE/fallback.conf
sudo touch /usr/share/YDE/fallback.conf
touch ~/.config/YDE/apps/list
echo int=$int >> ~/.config/YDE/fallback.conf
sleep 2
kill "$!"
clear
echo
echo "   ┌────────────────────────────────────────────────────────────┐"
echo "   │ YDEf Installion                               [part 3 of 3] │"
echo "   └────────────────────────────────────────────────────────────┘"
echo
echo
echo "      YDE fallback has been successfully installed on your PC!"
echo
echo "      Please write safeui to run YDEf."
echo "      The installer will close in a couple of seconds."
echo
sleep 3
 clear
 echo "Run safeui to run shell."
 echo
 echo "Your Fallback Desktop Environment $VER - 2022-2023. Russanandres"
 date
 exit
fi
