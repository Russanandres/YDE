#!/bin/bash
printf '\033[8;27;104t'
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
echo "│                                                                   [M] - Turn on/off mouse navigation │"
echo "├──────────────────────────────────────────────────────────────────────────────────────────────────────┤"
echo "│ [S] Homescreen                                                                 [$(date +%D)] [$(date +%H:%M:%S)] │"
echo "└──────────────────────────────────────────────────────────────────────────────────────────────────────┘"

declare -i mouseX
declare -i mouseY
declare -i mouseButton
declare -r ESC_CODE=$'\e'
declare -r EXIT_CODE='x'
printMouseInfo() {
	echo button=$mouseButton column=$mouseX row=$mouseY
}

readMouse() {
	local mouseButtonData
	local mouseXData
	local mouseYData
	read -r -s -n 1 -t 1 mouseButtonData
	read -r -s -n 1 -t 1 mouseXData
	read -r -s -n 1 -t 1 mouseYData
	local -i mouseButtonCode
	local -i mouseXCode
	local -i mouseYCode
	LC_ALL=C printf -v mouseButtonCode '%d' "'$mouseButtonData"
	LC_ALL=C printf -v mouseXCode '%d' "'$mouseXData"
	LC_ALL=C printf -v mouseYCode '%d' "'$mouseYData"
    	((mouseButton = mouseButtonCode))
	((mouseX = mouseXCode - 32))
	((mouseY = mouseYCode - 32))
}

declare key
echo -ne "\e[?9h"
while true; do
	key=""
	read -r -s -t 1 -n 1 key
	case "$key" in
		$EXIT_CODE)
			break;;
		$ESC_CODE)
			read -r -s -t 1 -n 1 key
			if [[ "$key" == '[' ]]; then
				read -r -s -t 1 -n 1 key
				if [[ "$key" == "M" ]]; then
			 		readMouse
					printMouseInfo
					echo -ne "\e[?9l"
					exit
				fi
			fi;;
	esac
done
echo -ne "\e[?9l"
