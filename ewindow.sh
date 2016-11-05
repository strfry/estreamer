#!/bin/bash -ex

cd $(dirname $0) # Change working directory

#svscan $(dirname $0) &

#./send-localhost.sh >/dev/null &

if [ -n "$SSH_CLIENT" ]; then
  REMOTE_IP=$(echo $SSH_CLIENT | cut -f 1 -d " " )

  case "$2" in # Switch on arguments
    CALL)
      echo Incoming call from $REMOTE_IP
      # Asking for permission, to break the current call would happen here
      ssh $REMOTE_IP ACCEPT
      echo "Connection Accepted"
      echo $REMOTE_IP > send/host
      svc -du send recv
      #Doesnt work in SSH script dialog --msgbox "Starting call..." 20 100
      sleep 10
      svc -d send recv
      exit 0
      ;;
    ACCEPT)
      echo Call to $REMOTE_IP accepted
      echo $REMOTE_IP > send/host
      svc -d -u send recv
      exit 0
      ;;
    *)
      echo Unknown Command, exiting
      exit 1
      ;;
  esac
fi

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
		ssh 10.7.7.93 CALL
		svc -d recv send
		exit
		;;
	Exit*)
		exit
		;;
esac

exec $0
