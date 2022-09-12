#!/bin/bash
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


echo -e ${No_color}

# Regular Colors
echo Normal
echo -e ${Black}Black${No_color}
echo -e ${Red}Red${No_color}
echo -e ${Green}Green${No_color}
echo -e ${Yellow}Yellow${No_color}
echo -e ${Blue}Blue${No_color}
echo -e ${Purple}Purple${No_color}
echo -e ${Cyan}Cyan${No_color}
echo -e ${White}White${No_color}

# Bold
echo; echo; echo Bold
echo -e ${BBlack}BBlack${No_color}
echo -e ${BRed}BRed${No_color}
echo -e ${BGreen}BGreen${No_color}
echo -e ${BYellow}BYellow${No_color}
echo -e ${BBlue}BBlue${No_color}
echo -e ${BPurple}BPurple${No_color}
echo -e ${BCyan}BCyan${No_color}
echo -e ${BWhite}BWhite${No_color}

# Underline
echo; echo; echo Underline
echo -e ${UBlack}UBlack${No_color}
echo -e ${URed}URed${No_color}
echo -e ${UGreen}UGreen${No_color}
echo -e ${UYellow}UYellow${No_color}
echo -e ${UBlue}UBlue${No_color}
echo -e ${UPurple}UPurple${No_color}
echo -e ${UCyan}UCyan${No_color}
echo -e ${UWhite}UWhite${No_color}

# Background
echo; echo; echo Background
echo -e ${On_Black}On_Black${No_color}
echo -e ${On_Red}On_Red${No_color}
echo -e ${On_Green}On_Green${No_color}
echo -e ${On_Yellow}On_Yellow${No_color}
echo -e ${On_Blue}On_Blue${No_color}
echo -e ${On_Purple}On_Purple${No_color}
echo -e ${On_Cyan}On_Cyan${No_color}
echo -e ${On_White}On_White${No_color}

# High Intensity
echo; echo; echo High Intensity
echo -e ${IBlack}IBlack${No_color}
echo -e ${IRed}IRed${No_color}
echo -e ${IGreen}IGreen${No_color}
echo -e ${IYellow}IYellow${No_color}
echo -e ${IBlue}IBlue${No_color}
echo -e ${IPurple}IPurple${No_color}
echo -e ${ICyan}ICyan${No_color}
echo -e ${IWhite}IWhite${No_color}

# Bold High Intensity
echo; echo; echo Bold High Intensity
echo -e ${BIBlack}BIBlack${No_color}
echo -e ${BIRed}BIRed${No_color}
echo -e ${BIGreen}BIGreen${No_color}
echo -e ${BIYellow}BIYellow${No_color}
echo -e ${BIBlue}BIBlue${No_color}
echo -e ${BIPurple}BIPurple${No_color}
echo -e ${BICyan}BICyan${No_color}
echo -e ${BIWhite}BIWhite${No_color}

# High Intensity backgrounds
echo; echo; echo High Intensity backgrounds
echo -e ${On_IBlack}On_IBlack${No_color}
echo -e ${On_IRed}On_IRed${No_color}
echo -e ${On_IGreen}On_IGreen${No_color}
echo -e ${On_IYellow}On_IYellow${No_color}
echo -e ${On_IBlue}On_IBlue${No_color}
echo -e ${On_IPurple}On_IPurple${No_color}
echo -e ${On_ICyan}On_ICyan${No_color}
echo -e ${On_IWhite}On_IWhite${No_color}
exit
