# Reminder via SystemD Transient service
systemd-run --user -E DISPLAY="$DISPLAY" --unit=reminder1 --on-active=5min notify-send -u critical 'Timers Up'