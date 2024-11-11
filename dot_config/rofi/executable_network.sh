# /usr/bin/env bash
#
# Description: Network ROFI menu
# Manage network connections from ROFI


function get_network_status() {
  _status=$(nmcli -t -f NAME,STATE con show --active | grep -v '^lo')
  _name=$(echo $_status | cut -d ':' -f 1)
  _state=$(echo $_status | cut -d ':' -f 2)
  if [ -z "$_status" ]; then
    echo "No active connections"
  else
    echo -en "Connection: $_name\n"
    echo -en "aap\0icon\x1fwireguard\n"
    # mark line as active
    echo -en "\0active\x1f0:1\n"
  fi
}

function display_main_menu() {
  get_network_status
}

# Entry point (script called with no arguments)
if [ $# -eq 0 ]; then
  display_main_menu
  exit 0
fi
