#!/usr/bin/env bash

if ! command -v zenity &> /dev/null
then
    echo "Zenity could not be found, starting Jedi Academy Multiplayer"
    selection="Multiplayer"
else
    selection=$(zenity --title "Select Jedi Academy Game Mode" --list --radiolist --column "" --column "Game Mode" FALSE "Single Player" TRUE "Multiplayer")
fi

case $selection in
    "Single Player")
        GameData/openjk_sp.x86_64
        ;;
    "Multiplayer")
        GameData/openjk.x86_64
        ;;
    *)
        echo "Invalid option, please submit an issue if this keeps happening"
        exit 1
        ;;
esac
