#!/bin/bash

set -e

# https://blog.dhampir.no/content/sleeping-without-a-subprocess-in-bash-and-how-to-sleep-forever
snore() {
	local IFS
	[[ -n "${_snore_fd:-}" ]] || exec {_snore_fd}<> <(:)
	read -r ${1:+-t "$1"} -u $_snore_fd || :
}

DELAY=0.2
ICON=(
  ""
  ""
  ""
)

while snore $DELAY; do
	WP_OUTPUT=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)

	if [[ $WP_OUTPUT =~ ^Volume:[[:blank:]]([0-9]+)\.([0-9]{2})([[:blank:]].MUTED.)?$ ]]; then
		if [[ -n ${BASH_REMATCH[3]} ]]; then
				printf " %s   \n" " ${ICON[2]}"
		else
			VOLUME=$((10#${BASH_REMATCH[1]}${BASH_REMATCH[2]}))

			if [[ $VOLUME -gt 100 ]]; then
        wpctl set-volume @DEFAULT_AUDIO_SINK@ 1.0
				printf "%s  " " ${ICON[0]}"
			elif [[ $VOLUME -gt 50 ]]; then
				printf "%s  " " ${ICON[0]}"
			elif [[ $VOLUME -gt 25 ]]; then
				printf "%s  " " ${ICON[1]}"
			elif [[ $VOLUME -ge 0 ]]; then
				printf "%s  " " ${ICON[2]}"
			fi

			printf "$VOLUME%% \n"
		fi
	fi
done

exit 0
