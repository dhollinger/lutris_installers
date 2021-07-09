#!/bin/bash 
# GOG.com (www.gog.com)
# Game

# Initialization 
CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )" 
cd "${CURRENT_DIR}" 
source support/gog_com.shlib 

# Game info 
GAME_NAME="$(get_gameinfo 1)" 
VERSION="$(get_gameinfo 2)" 
VERSION_DEV="$(get_gameinfo 3)" 

# Actions
run_game() { 
echo "Running ${GAME_NAME}" 
cd "${CURRENT_DIR}/game" 
chmod +x * 
 ./$1 

}

# Config Launcher
config() {
    cselect=$(zenity --title "X3: Configuration Tools" --list --radiolist --column "" --column "" TRUE "Terran Conflict Config" FALSE "Albion Prelude Config" FALSE "Farnham's Legacy Config")
    
    case $cselect in
        "Terran Conflict Config")
            run_game "X3TC_config"
            ;;
        "Albion Prelude Config")
            run_game "X3AP_config"
            ;;
        "Farnham's Legacy Config")
            run_game "X3FL_config"
            ;;
    esac
}

# Launcher
game() {
    selection=$(zenity --title "X3: DLC Selection" --list --radiolist --column "" --column "" TRUE "X3: Terran Conflict" FALSE "X3: Albion Prelude" FALSE "X3: Farnham's Legacy")

    case $selection in
        "X3: Terran Conflict")
            run_game "X3TC_main"
            ;;
        "X3: Albion Prelude")
            run_game "X3AP_main"
            ;;
        "X3: Farnham's Legacy")
            run_game "X3FL_main"
            ;;
        *)
            echo "DLC doesn't exist, please submit an issue if this keeps happening"
            exit 1
            ;;
    esac
}

# Launcher main
launcher() {
    if ! command -v zenity &> /dev/null
    then
        echo "Zenity not found, defaulting to Terran Conflict"
        run_game "X3TC_config"
    else
        opts=$(zenity --title "X3 Launcher" --list --radiolist --column "" --column "" TRUE "Game List" FALSE "Configuration")
    fi

    case $opts in
        "Game List")
            game
            ;;
        "Configuration")
            config
            ;;
     esac
}

default() { 
launcher
} 

# Options 
define_option "-s" "--start" "start ${GAME_NAME}" "run_game" "$@" 

# Defaults
standard_options "$@" 


