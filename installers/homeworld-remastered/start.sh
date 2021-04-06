#!/usr/bin/env bash

# - HWRC Proton Launcher -
# ========================
#
# An alternative launcher script for the Steam version of Homeworld Remastered
# Collection to be played on GNU/Linux systems with Proton from Steam Play.


# Copyright 2019-2020 /dev/fra
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


# ___ User defined variables ___________________________________________________

# Steam main folder, usually it is one of these common paths:
#   $HOME/.local/share/Steam
#   $HOME/.steam
#   $HOME/.steam/debian-installation
steam_client_path="$HOME/.steam"

# Steam library folder, usually it is the "steam" folder inside the Steam main
# folder, e.g. "$HOME/.steam/steam", but it can be a different path as well.
steam_library="$HOME/.steam/steam"

# Proton version.
proton_version=5.0

# Launch options, to be used to prepend additional commands to the actual run
# command. Additional commands have to be provided in the parentheses and
# properly quoted when needed (this is an array). For example, to launch the
# games with Feral's gamemode and primus-vk set:
#   launch_options=(env "GAMEMODERUNEXEC=pvkrun" gamemoderun)
launch_options=()


# ___ Common variables _________________________________________________________
#
# There should be no need to change the variables in this section.

# Proton main folder.
proton_path="${steam_library}/steamapps/common/Proton ${proton_version}"

# Game root folder.
game_root_path="${steam_library}/steamapps/common/Homeworld"

# Steam ID of the game.
app_id=244160


# ___ Environment variables ____________________________________________________

# Set the Mesa drivers OpenGL version to 3.3 Compatibility Profile.
# This is required in order to run the remastered version of the games when
# using the Mesa drivers (Intel and AMD graphics cards).
export MESA_GL_VERSION_OVERRIDE=3.3COMPAT

# Environment variables required by Steam
#
# WARNING: This section should be periodically checked and updated when new
#          versions of Steam and Proton are released.
#
# These environment variables are set by Steam when launching the game from
# the Steam client using Steam Play. To retrieve these variables inspect the
# run script that can be dumped from Steam in this way:
#   1. Set the game launch options in the Steam client to
#      "PROTON_DUMP_DEBUG_COMMANDS=1 %command%";
#   2. Launch the game (even if it does not work);
#   3. Find the script "/tmp/proton_<username>/run".

steam_custom_paths="${proton_path}/dist/bin:"
steam_custom_paths+="${steam_client_path}/ubuntu12_32/steam-runtime/amd64/bin:"
steam_custom_paths+="${steam_client_path}/ubuntu12_32/steam-runtime/amd64/usr/bin:"
steam_custom_paths+="${steam_client_path}/ubuntu12_32/steam-runtime/usr/bin:"
export PATH="$steam_custom_paths:${PATH}"

export TERM=xterm
export WINEDEBUG=-all
export WINEDLLPATH="$proton_path"/dist/lib64/wine:"$proton_path"/dist/lib/wine

LD_LIBRARY_PATH="$proton_path"/dist/lib64:
LD_LIBRARY_PATH+="$proton_path"/dist/lib:
LD_LIBRARY_PATH+="$steam_client_path"/ubuntu12_32/steam-runtime/pinned_libs_32:
LD_LIBRARY_PATH+="$steam_client_path"/ubuntu12_32/steam-runtime/pinned_libs_64:
LD_LIBRARY_PATH+=/usr/lib/x86_64-linux-gnu/libfakeroot:
LD_LIBRARY_PATH+=/lib/i386-linux-gnu:
LD_LIBRARY_PATH+=/usr/local/lib:
LD_LIBRARY_PATH+=/lib/x86_64-linux-gnu:
LD_LIBRARY_PATH+=/lib:
LD_LIBRARY_PATH+=/lib/i386-linux-gnu/sse2:
LD_LIBRARY_PATH+=/lib/i386-linux-gnu/i686:
LD_LIBRARY_PATH+=/lib/i386-linux-gnu/i686/sse2:
LD_LIBRARY_PATH+="$steam_client_path"/ubuntu12_32/steam-runtime/lib/i386-linux-gnu:
LD_LIBRARY_PATH+="$steam_client_path"/ubuntu12_32/steam-runtime/usr/lib/i386-linux-gnu:
LD_LIBRARY_PATH+="$steam_client_path"/ubuntu12_32/steam-runtime/lib/x86_64-linux-gnu:
LD_LIBRARY_PATH+="$steam_client_path"/ubuntu12_32/steam-runtime/usr/lib/x86_64-linux-gnu:
LD_LIBRARY_PATH+="$steam_client_path"/ubuntu12_32/steam-runtime/lib:
LD_LIBRARY_PATH+="$steam_client_path"/ubuntu12_32/steam-runtime/usr/lib:
export LD_LIBRARY_PATH

export WINEPREFIX="${steam_library}/steamapps/compatdata/${app_id}/pfx/"
export WINEESYNC="1"
export WINEFSYNC="1"
export SteamGameId="$app_id"
export SteamAppId="$app_id"
export WINEDLLOVERRIDES="steam.exe=b;mfplay=n;dxvk_config=n;d3d11=n;d3d10=n;d3d10core=n;d3d10_1=n;d3d9=n"
export STEAM_COMPAT_CLIENT_INSTALL_PATH="$steam_client_path"
export WINE_LARGE_ADDRESS_AWARE="1"


# ___ Functions ________________________________________________________________

print_help() {
    cat << EOF
Usage: $0 GAME [OPTIONS]

This is an alternative launcher script for the Steam version of Homeworld
Remastered Collection. This script can be used to launch the games in the
collection using Proton from Steam Play on GNU/Linux systems.

Important notes:
- Please edit the user defined variables of this script before using it;
- Steam must be running already before launching a game.

Game:

  hw1cla        Homeworld 1 Classic
  hw2cla        Homeworld 2 Classic
  hw1rem        Homeworld 1 Remastered
  hw2rem        Homeworld 2 Remastered
  hwmp          Homeworld Remastered Multiplayer

Options:

  -m <MOD PATH> Load mod at the given path (see below for details)
  -w            Windowed mode

Loading a mod:

The option '-m' requires a path to the mod file. The path can be an absolute
path, or a relative path to the game DATAWORKSHOPSMODS folder. The following
folders should be available:
- <STEAM PATH>/steamapps/common/Homeworld/HomeworldRM/DATAWORKSHOPMODS
- <STEAM PATH>/steamapps/common/Homeworld/Homeworld2Classic/DATAWORKSHOPMODS

For example, to load the Homeworld Remastered 2.3 Players Patch using a
relative path (provided the mod file and any parent folder are in the
DATAWORKSHOPSMODS folder):

  $0 hw1rem -m 1190476337/2.3PlayersPatch.big

EOF
    exit
}

exit_now() {
    printf "%s\\n" "$1" >&2
    exit 1
}

run_game() {
    # Check if Steam is running.
    if ! pgrep -f -l "${steam_client_path%/}"/ubuntu12_32/steam; then
        exit_now "ERROR: Is Steam running? Make sure to launch Steam first."
    fi

    # This is basically how the Steam run script launches the game (see the
    # environment variables section above on how to dump it). The expansion to
    # the positional parameters ($@) has to remain unquoted otherwise the game
    # options are not taken by steam.exe, for some reason.
    cd "${1%/*}" || exit_now "ERROR: invalid path ${1%/*}"
    "${launch_options[@]}" "$proton_path"/dist/bin/wine steam.exe $@
}


# ___ Main body ________________________________________________________________

# Initialise all the option variables to avoid contamination from the
# environment.
mod_path=
windowed=

# Check main paths.
[[ ! -d $steam_client_path ]] &&
    exit_now "ERROR: invalid Steam path $steam_client_path"
[[ ! -d $steam_library ]] &&
    exit_now "ERROR: invalid Steam library path $steam_library"
[[ ! -d $proton_path ]] &&
    exit_now "ERROR: invalid Proton path $proton_path"
[[ ! -d $game_root_path ]] &&
    exit_now "ERROR: invalid game root path $game_root_path"
[[ ! -d $WINEPREFIX ]] &&
    exit_now "ERROR: invalid wine prefix $WINEPREFIX"

# Check arguments and set game executable and options.
#[[ $# -lt 1 ]] && print_help

if ! command -v zenity &> /dev/null
then
    [[ $# -lt 1 ]] && print_help
    game="$1"
else
    game=$(zenity --title "Select Homeworld version" --list --radiolist -column "" --column "Version" FALSE "hw1cla" FALSE "hw2cla" FALSE "hw1rem" TRUE "hw2rem" FALSE "hwmp")
fi

while :; do
    case $2 in
        -m)
            if [[ -n $3 && ${3##*.} == "big" ]]; then
                mod_path="$3"
                shift 2
            else
                exit_now "ERROR: invalid mod file name"
            fi
            ;;
        -w) windowed=true; shift ;;
        *) break ;;
    esac
done

game_options=()
case "$game" in
    # Game options have to be separated by a space but no trailing space must
    # be left.
    hw1cla)
        game_exe="${game_root_path}/Homeworld1Classic/exe/Homeworld.exe"
        game_options+=("/noglddraw")
        [[ $windowed = true ]] && game_options+=("/window")
        ;;
    hw2cla)
        game_exe="${game_root_path}/Homeworld2Classic/Bin/Release/Homeworld2.exe"
        [[ $windowed = true ]] && game_options+=("-windowed")
        ;;
    hw1rem)
        game_exe="${game_root_path}/HomeworldRM/Bin/Release/HomeworldRM.exe"
        game_options+=("-dlccampaign HW1Campaign.big")
        game_options+=("-campaign HomeworldClassic")
        game_options+=("-moviepath DataHW1Campaign")
        [[ $windowed = true ]] && game_options+=("-windowed")
        ;;
    hw2rem)
        game_exe="${game_root_path}/HomeworldRM/Bin/Release/HomeworldRM.exe"
        game_options+=("-dlccampaign HW2Campaign.big")
        game_options+=("-campaign Ascension")
        game_options+=("-moviepath DataHW2Campaign")
        [[ $windowed = true ]] && game_options+=("-windowed")
        ;;
    hwmp)
        game_exe="${game_root_path}/HomeworldRM/Bin/Release/HomeworldRM.exe"
        [[ $windowed = true ]] && game_options+=("-windowed")
        ;;
    *)
        print_help
        ;;
esac

[[ -n $mod_path ]] && game_options+=("-workshopmod $mod_path")

# Launch the selected game.
run_game "$game_exe" "${game_options[@]}"

exit
