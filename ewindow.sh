#!/bin/bash

cd $(dirname $0) # Change working directory

#svscan $(dirname $0) &

#./send-localhost.sh >/dev/null &

dialog --menu menutext 20 100 10 \
	Preview "Show Local Camera Stream" \
	Call "Holzwerkstatt" \
	Exit "" \
	2> dialog.result

if [[ ! $? ]] ; then
	exit
fi

case $(cat dialog.result) in
	Preview*)
		echo localhost > send/host
		svc -d -u send
		svc -u recv
		dialog --msgbox "Started Camera Preview..." 20 100
		svc -d recv
		;;
	Call*)
		exit
		;;
	Exit*)
		exit
		;;
esac

exec $0
