#!/bin/sh

process=$(pgrep -x "frklstatus")

if [[ $(echo "$process" | wc -l) -gt 1 ]]; then
    exit 1
fi

colorzero=" "
colorone=" "
colortwo=" "
colorthree=" "

wifi_interface="wlp0s20f0u3"
eth_interfaces=""

frklstatusbar(){
  while true; do

    local status=""
    local status="${colorzero} $(getdatetime)${status}"

    local status="${colortwo} $(getvol) ${status}"
    local status="${colorone} $(getmem) ${status}"
    local status="$(getnetspeed) ${status}"

    xsetroot -name "${status}"
    sleep $1
  done
}

getdatetime(){
  echo "󱑌 $(date +"%d/%m/%Y %R")"
}
getmem(){
  local used=$(free -h | awk '/^Mem.:/ {print $3}')
  # local free=$(free -h | awk '/^Mem.:/ {print $4}')
  local total=$(free -h | awk '/^Mem.:/ {print $2}')

  echo -e " m. ${used}  ${total}"
}
getvol(){
  local vol="$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2 * 100}')"
  echo "󱄠 ${vol}%"
}
getnetstatus(){
  cat /sys/class/net/$1/operstate
}

getspeed() {
    local rx1=$(cat /sys/class/net/$1/statistics/rx_bytes)
    local rx1=0
    local rxfile="/tmp/${interface}_rx"
    if [ -f $rxfile ]; then
      rx1=$(cat $rxfile)
    fi
    local rx2=$(cat /sys/class/net/$1/statistics/rx_bytes)
    echo $rx2 > $rxfile
    speed=$(numfmt --to=iec $((rx2-rx1)))
    if [ $(echo $speed | grep "K" || echo $speed | grep "M") ]; then
        printf "$colortwo $2%5s/s" $speed
    else
        printf "$colorthree $2%4sB/s" $speed
    fi
}

getnetspeed(){
  # for eth_interface in $eth_interfaces; do
  #     if [ -e /sys/class/net/$eth_interface ] && [ "$(getStatus $eth_interface)" = "up" ]; then
  #         getSpeed $eth_interface 
  #         exit 0
  #     fi
  # done
  if [[ "$(getnetstatus $wifi_interface)" = "up" ]]; then
    getspeed $wifi_interface 󰤨
  else
    echo "${colorzero}󱞐 "
  fi
}

initstatus(){
  xsetroot -name "  frkl-dwm  "
  sleep 1
  frklstatusbar 1s
}

initstatus
