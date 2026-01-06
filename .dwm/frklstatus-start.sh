#!/bin/sh

PIDFILE="/tmp/frklstatus.pid"

cleanup() {
    rm -f "$PIDFILE"
    exit 0
}
trap cleanup INT TERM EXIT
#
if [ -f "$PIDFILE" ]; then
    OLD_PID=$(cat "$PIDFILE")
    if kill -0 "$OLD_PID" 2>/dev/null; then
        exit 1
    fi
fi

echo $$ > "$PIDFILE"

while true; do
    xsetroot -name "$(~/.dwm/frklstatus)"
    sleep 1s
done
