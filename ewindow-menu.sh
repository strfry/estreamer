#!/bin/bash

#svscan $(dirname $0) &

#./send-localhost.sh >/dev/null &

dialog --menu menutext 20 100 10 \
	Preview "Show Local Camera Stream" \
	tag2 item2 tag3 item3 \
	Exit "" \
	2> dialog.result

if [[ ! $? ]] ; then
	exit
fi

case $(cat dialog.result) in
	Preview*)
		svc -u recv
		dialog --msgbox "Started Camera Preview..." 20 100
		svc -d recv
		;;
	Exit*)
		exit
		;;
esac

exec $0
