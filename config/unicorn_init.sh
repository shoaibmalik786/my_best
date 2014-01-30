<<<<<<< HEAD
i#!/bin/sh
set -e

# Feel free to change any of the following variables for your app:
TIMEOUT=${TIMEOUT-60}
APP_ROOT=/data/www/conciage/current
PID=$APP_ROOT/tmp/pids/unicorn.pid
CMD="cd $APP_ROOT; bundle exec unicorn -D -c $APP_ROOT/config/unicorn.rb -E production"
AS_USER=andy
set -u

OLD_PIN="$PID.oldbin"

sig () {
  test -s "$PID" && kill -$1 `cat $PID`
}

oldsig () {
  test -s $OLD_PIN && kill -$1 `cat $OLD_PIN`
}

run () {
  if [ "$(id -un)" = "$AS_USER" ]; then
    eval $1
  else
    su -c "$1" - $AS_USER
  fi
}

case "$1" in
start)
  sig 0 && echo >&2 "Already running" && exit 0
  run "$CMD"
  ;;
stop)
  sig QUIT && exit 0
  echo >&2 "Not running"
  ;;
force-stop)
  sig TERM && exit 0
  echo >&2 "Not running"
  ;;
restart|reload)
  sig HUP && echo reloaded OK && exit 0
  echo >&2 "Couldn't reload, starting '$CMD' instead"
  run "$CMD"
  ;;
upgrade)
  if sig USR2 && sleep 2 && sig 0 && oldsig QUIT
  then
    n=$TIMEOUT
    while test -s $OLD_PIN && test $n -ge 0
    do
      printf '.' && sleep 1 && n=$(( $n - 1 ))
    done
    echo

    if test $n -lt 0 && test -s $OLD_PIN
    then
      echo >&2 "$OLD_PIN still exists after $TIMEOUT seconds"
      exit 1
    fi
    exit 0
  fi
  echo >&2 "Couldn't upgrade, starting '$CMD' instead"
  run "$CMD"
  ;;
reopen-logs)
  sig USR1
  ;;
*)
  echo >&2 "Usage: $0 <start|stop|restart|upgrade|force-stop|reopen-logs>"
  exit 1
  ;;
esac
=======
#!/bin/sh
set -e

TIMEOUT=${TIMEOUT-60}
APP_ROOT=/data/www/conciage
PID=$APP_ROOT/tmp/pids/unicorn.pid
CMD="$APP_ROOT/bin/unicorn -D -c $APP_ROOT/config/unicorn.rb"
action="$1"
set -u

old_pid="$PID.oldbin"

cd $APP_ROOT || exit 1

sig () {
    test -s "$PID" && kill -$1 `cat $PID`
}

oldisg () {
    test -s $old_pid && kill -$1 `cat $old_pid`
}

case $action in 
    start)
        sig 0 && echo >&2 "Already Running" && exit 0
        #su -c "$CMD" - conciage
        su -c "$CMD" 
        ;;
    stop)
        sig QUIT && exit 0
        echo >&2 "Not Running"
        ;;
    force-stop)
        sig TERM && exit 0
        echo >&2 "Not Running"
        ;;
    restart|reload)
        sig HUP && echo reloaded OK && exit 0
        echo >&2 "Couldn't reload, starting '$CMD' instead"
        su -c "$CMD" - conciage
        ;;
    upgrade) 
        if sig USR2 && sleep 2 && sig 0 && oldsig QUIT
        then 
            n=$TIMEOUT
            while test -s $old_pid && test $n -ge 0
            do
                printf '.' && sleep 1 && n=$(( $n - 1 ))
            done
            echo

            if test $n -lt 0 && test -s $old_pid
            then
                echo >&2 "$old_pid still exists after $TIMEOUT seconds"
                exit 1
            fi
            exit 0
        fi
        echo >&2 "Couldnt upgrade, starting '$CMD' instead"
        su -c "$CMD" - conciage
        ;;
    reopen-logs)
        sig USR1
        ;;
    *)
        echo >&2 "Usage $0 <start|stop|restart|upgrade|force-stop|reopen-logs>"
        exit 1
        ;;
    esac

>>>>>>> Added unicorn configuration files
