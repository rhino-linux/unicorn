#!/bin/bash

if [[ -z $UID ]]; then
    UID="$(id -u)"
fi

# set $XDG_MENU_PREFIX to "xfce-" so that "xfce-applications.menu" is picked
# over "applications.menu" in all Xfce applications.
if [[ -z $XDG_MENU_PREFIX ]]; then
    XDG_MENU_PREFIX="xfce-"
    export XDG_MENU_PREFIX
fi

# set DESKTOP_SESSION so that one can detect easily if an Xfce session is running
if [[ -z $DESKTOP_SESSION ]]; then
    DESKTOP_SESSION="unicorn"
    export DESKTOP_SESSION
fi

# set XDG_CURRENT_DESKTOP so that Qt 5 applications can identify user set Xfce theme
if [[ -z $XDG_CURRENT_DESKTOP ]]; then
    XDG_CURRENT_DESKTOP="Unicorn"
    export XDG_CURRENT_DESKTOP
fi

# $XDG_CONFIG_HOME defines the base directory relative to which user specific
# configuration files should be stored. If $XDG_CONFIG_HOME is either not set
# or empty, a default equal to $HOME/.config should be used.
if [[ -z $XDG_CONFIG_HOME ]]; then
    XDG_CONFIG_HOME=$HOME/.config
fi
[[ -d $XDG_CONFIG_HOME ]] || mkdir "$XDG_CONFIG_HOME"

# $XDG_CACHE_HOME defines the base directory relative to which user specific
# non-essential data files should be stored. If $XDG_CACHE_HOME is either not
# set or empty, a default equal to $HOME/.cache should be used.
if [[ -z $XDG_CACHE_HOME ]]; then
    XDG_CACHE_HOME=$HOME/.cache
fi
[[ -d $XDG_CACHE_HOME ]] || mkdir "$XDG_CACHE_HOME"

# set up XDG user directores.  see
# http://freedesktop.org/wiki/Software/xdg-user-dirs
if command -v xdg-user-dirs-update &> /dev/null; then
    xdg-user-dirs-update
fi

# For now, start with an empty list
XRESOURCES=()

# Has to go prior to merging Xft.xrdb, as its the "Defaults" file
[[ -r "/etc/xdg/unicorn/Xft.xrdb" ]] && XRESOURCES+=("/etc/xdg/unicorn/Xft.xrdb")
[[ -r "$HOME/.Xdefaults" ]] && XRESOURCES+=("$HOME/.Xdefaults")

BASEDIR=$XDG_CONFIG_HOME/xfce4
if [[ -r "$BASEDIR/Xft.xrdb" ]]; then
    XRESOURCES+=("$BASEDIR/Xft.xrdb")
elif [[ -r "$XFCE4HOME/Xft.xrdb" ]]; then
    mkdir -p "$BASEDIR"
    cp "$XFCE4HOME/Xft.xrdb" "$BASEDIR"/
    XRESOURCES+=("$BASEDIR/Xft.xrdb")
fi

# merge in X cursor settings
[[ -r "$BASEDIR/Xcursor.xrdb" ]] && XRESOURCES+=("$BASEDIR/Xcursor.xrdb")

# ~/.Xresources contains overrides to the above
[[ -r "$HOME/.Xresources" ]] && XRESOURCES+=("$HOME/.Xresources")

# load all X resources (adds /dev/null to avoid an empty list that would hang the process)
cat /dev/null "${XRESOURCES[@]}" | xrdb -merge -

# load local modmap
[[ -r "$HOME/.Xmodmap" ]] && xmodmap "$HOME/.Xmodmap"

# if XAUTHLOCALHOSTNAME is not set in systemd user session, starting of xfce4-notifyd, DISPLAY etc. will fail
if command -v systemctl &> /dev/null && systemctl --user list-jobs &> /dev/null; then # user session is running
    dbus-update-activation-environment --systemd XAUTHLOCALHOSTNAME="$XAUTHLOCALHOSTNAME"
fi

# check if we start xfce4-session with ck-launch-session. this is only
# required for starting from a console, not a login manager
if [[ $XFCE4_SESSION_WITH_CK == "1" ]]; then
    if command -v ck-launch-session &> /dev/null; then
        exec ck-launch-session xfce4-session
    else
        echo
        echo "You have tried to start Xfce with consolekit support, but"
        echo "ck-launch-session is not installed."
        echo "Aborted startup..."
        echo
        exit 1
    fi
else
    # start xfce4-session normally
    exec xfce4-session
fi

# if we got here, then exec failed
exit 1
