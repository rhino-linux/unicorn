# Rhino Linux XFCE4 Dotfiles
Here are the XFCE4 Dotfiles. These files customize the interface to best suit your needs as a Rhino Linux user. Enjoy a start menu that lets you easily read man pages, search the web using DuckDuckGo, search for your files, read Wikipedia, run programs in a Teriminal, and open webpages at the press of the ENTER key. Use a terminal that is eye-catching. Experience a XFCE experience like never before!

If you'd like more information and tutorials, consider [checking out our wiki](https://wiki.rhinolinux.org).

## Directory Structure
Here is a directory structure of the dotfiles.

    .
    ├── logo.png
    ├── logo.svg
    ├── README.md
    ├── rhino
    │   ├── geo.png
    │   ├── moon.png
    │   ├── mountains.png
    │   ├── remix.png
    │   ├── rolling-rhino-default.png
    │   ├── simple.png
    │   └── waves.png
    └── xfce4
        ├── desktop
        │   ├── icons.screen0-1904x990.rc
        │   └── icons.screen.latest.rc -> /home/httpllamaz/.config/xfce4/desktop/icons.screen0-1904x990.rc
        ├── panel
        │   └── whiskermenu-1.rc
        ├── terminal
        │   └── terminalrc
        └── xfconf
            └── xfce-perchannel-xml
                ├── displays.xml
                ├── keyboards.xml
                ├── thunar.xml
                ├── xfce4-desktop.xml
                ├── xfce4-keyboard-shortcuts.xml
                ├── xfce4-notifyd.xml
                ├── xfce4-panel.xml
                ├── xfce4-power-manager.xml
                ├── xfce4-session.xml
                ├── xfce4-settings-manager.xml
                ├── xfwm4.xml
                └── xsettings.xml

- **README.md** — You are here.
- **rhino** — Our logo assets and desktop backgrounds
    - **logos** - All the logos we use
- **xfce4** — All of the XFCE4 Configuration
    - **desktop** — Sets the icons we use
    - **panel** — Used to customize the Whisker Menu
    - **terminal** — Config for our Terminal
    - **xfconf** — The majority of config files stored as XML

