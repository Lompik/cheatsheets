# list audio devices
mpv --ad help

# list video devices
mpv --vd help

#specify subtitle file
mpv --sub-file $file

# keybindings
ctrl+shift+backspace # set mark
shift+backspace      # jump to mark
_                    # Cycle through the available video tracks.
#                    # Cycle through the available audio tracks.

# Personal Keybinds
h set hwdec no
alt+k add sub-scale +0.2                  # increase subtitle font size
alt+j add sub-scale -0.2                  # decrease subtitle font size
a cycle-adevices       (lua)
n cycle-denoisers      (lua)
c cycle-channel-layout (custom: 5.1, 2.1, etc)
b cycle-tscale         (custom)

alt+i cycle-values icc-profile-auto (no yes)
alt+I cycle-values icc-intent (0:percep 1:rela 2:sat 3:abso)

+,-,ctrl+t/T tonemap ±