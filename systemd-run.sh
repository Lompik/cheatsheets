# Reminder via SystemD Transient service
systemd-run --user -E DISPLAY="$DISPLAY" --unit=reminder1 --on-active=5min notify-send -u critical 'Timers Up'
# to set [Service] properties: ues -p
systemd-run --property=Type=exec -p KillSignal=SIGINT -p NetworkNamespacePath=/var/run/netns/enp999ns -p MemoryMax=500M -- command
# or --service-type=forking
systemd-run \
  --wait \
  --user \
  -E MYENVVAR=VAL \
  --setenv=ASABOVE=VAL \
  --unit=myprog-$(uuidgen -t)  # to set unique service name
