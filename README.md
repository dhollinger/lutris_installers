# Lutris installers repo

This repository is for storing the offline versions of the installers I created to install various games via the Lutris game manager on Linux. These can be used standalone, but my primary form of support for these is through their Lutris.net game pages. If you find any issues with the installers, submit an issue or pull request.

## Games

### X-Wing Alliance Upgrade Project files for WINE installation

This installer will install X-Wing Alliance (only supports GOG version at this time), XWAUpgrade 2020, and some additional Windows tools. Additionally, this installs DXVK outside of Lutris and adds a registry entry that disables DXVK when running the BabuFrikConfigurator Config application for XWAUpgrade as it doesn't play well with DXVK. There is also a .bat script that will launch a mini-launcher offering the choice between launching the game and launching the configuration tool.
