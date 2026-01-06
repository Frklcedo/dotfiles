#!/bin/sh

PIDFILE="/tmp/frklstatus.pid"

cleanup() {
    if [ -f "$PIDFILE" ] && [ "$(cat "$PIDFILE")" = "$$" ]; then
        rm -f "$PIDFILE"
    fi
    pgrep -f frklstatus
    exit 0
}
trap cleanup INT TERM EXIT
#
if [ -f "$PIDFILE" ]; then
    echo "$PIDFILE pid arquivo"
    OLD_PID=$(cat "$PIDFILE")
    echo "$OLD_PID pid antigo"
    if kill -0 "$OLD_PID" 2>/dev/null; then
        echo "$PIDFILE"
        kill "$OLD_PID" 2>/dev/null
    fi
fi

echo $$ > "$PIDFILE"

while true; do
    xsetroot -name "$(~/.dwm/frklstatus)"
    sleep 1s
done

