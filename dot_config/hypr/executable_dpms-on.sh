#!/usr/bin/env bash
# Turn all outputs on and re-check for a few seconds: the C2722DE USB-C monitor
# re-enumerates (hotplug) shortly after wake, which can leave another output
# stuck in DPMS off.
for delay in 0 2 3 4; do
    sleep "$delay"
    hyprctl dispatch dpms on >/dev/null
    sleep 0.5
    off=$(hyprctl monitors -j | jq -r '.[] | select(.dpmsStatus == false) | .name')
    [[ -z "$off" ]] && exit 0
done
echo "dpms-on: still off after retries: $off" >&2
exit 1
