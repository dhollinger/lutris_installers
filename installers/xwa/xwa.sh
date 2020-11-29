#!/bin/bash

# Environment variables
export SDL_VIDEO_FULLSCREEN_DISPLAY="off"
export DRI_PRIME="1"
export __NV_PRIME_RENDER_OFFLOAD="1"
export __GLX_VENDOR_LIBRARY_NAME="nvidia"
export __VK_LAYER_NV_optimus="NVIDIA_only"
export STEAM_RUNTIME="/home/dhollinger/.local/share/lutris/runtime/steam"
export LD_LIBRARY_PATH="/home/dhollinger/.local/share/lutris/runners/wine/lutris-5.7-11-x86_64/lib:/home/dhollinger/.local/share/lutris/runners/wine/lutris-5.7-11-x86_64/lib64:/usr/lib/x86_64-linux-gnu/libfakeroot:/lib/i386-linux-gnu/sse2:/lib/i386-linux-gnu/i686/sse2:/usr/local/lib:/lib32:/lib:/lib/i386-linux-gnu:/lib/x86_64-linux-gnu:/lib64:/lib64:/usr/lib:/usr/lib64:/usr/lib32:/usr/lib64:/usr/lib/i386-linux-gnu:/usr/lib/x86_64-linux-gnu:/home/dhollinger/.local/share/lutris/runtime/lib32:/home/dhollinger/.local/share/lutris/runtime/steam/i386/lib/i386-linux-gnu:/home/dhollinger/.local/share/lutris/runtime/steam/i386/lib:/home/dhollinger/.local/share/lutris/runtime/steam/i386/usr/lib/i386-linux-gnu:/home/dhollinger/.local/share/lutris/runtime/steam/i386/usr/lib:/home/dhollinger/.local/share/lutris/runtime/lib64:/home/dhollinger/.local/share/lutris/runtime/steam/amd64/lib/x86_64-linux-gnu:/home/dhollinger/.local/share/lutris/runtime/steam/amd64/lib:/home/dhollinger/.local/share/lutris/runtime/steam/amd64/usr/lib/x86_64-linux-gnu:/home/dhollinger/.local/share/lutris/runtime/steam/amd64/usr/lib:$LD_LIBRARY_PATH"
export DXVK_STATE_CACHE="0"
export WINEDEBUG="-all"
export WINEARCH="win64"
export WINE="/home/dhollinger/.local/share/lutris/runners/wine/lutris-5.7-11-x86_64/bin/wine"
export WINEPREFIX="/home/dhollinger/Games/star-wars-x-wing-alliance"
export WINEESYNC="0"
export WINEFSYNC="0"
export WINEDLLOVERRIDES="ddraw.dll,dinput.dll=n,b;winemenubuilder.exe=d"
export WINE_LARGE_ADDRESS_AWARE="1"
export TERM="xterm"

# Command

if ! command -v zenity &> /dev/null
then
    echo "Zenity could not be found, Starting X-Wing Alliance Game"
    selection="Launch Game"
else
    selection=$(zenity --title "X-Wing Alliance Launcher" --list --radiolist --column "" --column "Option" TRUE "Launch Game" FALSE "Launch Configuration")
fi

case $selection in
    "Launch Game")
        gamemoderun /home/dhollinger/.local/share/lutris/runners/wine/lutris-5.7-11-x86_64/bin/wine '/home/dhollinger/Games/star-wars-x-wing-alliance/drive_c/GOG Games/Star Wars - X-Wing Alliance/XWINGALLIANCE.EXE'
        ;;
    "Launch Configuration")
        gamemoderun /home/dhollinger/.local/share/lutris/runners/wine/lutris-5.7-11-x86_64/bin/wine '/home/dhollinger/Games/star-wars-x-wing-alliance/drive_c/GOG Games/Star Wars - X-Wing Alliance/TotalConverter/BabuFriksConfigurator.exe'
        ;;
    *)
        echo "Invalid option, please submit an issue if this keeps happening"
        exit 1
        ;;
esac
