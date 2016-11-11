#!/bin/sh

Clock() {
  DATE=$(date "+%A, %b. %d")
  TIME=$(date "+%I:%M %P")

  echo -n "%{F-}%{R}%{O16}$DATE%{O16}%{R}%{O8}$TIME%{O16}"
}

Wifi() {
  SSID=$(iwgetid -r)

  echo -n "%{R}%{O16}wifi%{O16}%{R}%{O8}$SSID%{O16}"
}

Batt() {
  BATT=$(cat /sys/class/power_supply/BAT1/capacity)

  echo -n "%{B-}%{R}%{O16}battery%{O16}%{R}%{O8}$BATT%%{O16}"
}

Bright() {
  BR=$(xbacklight | cut -c 1-3)

  echo -n "%{B-}%{R}%{O16}brightness%{O16}%{R}%{O8}$BR%{O16}"
}

update_int=60
update_ctr=$(( update_int - 1 ))
Updates() {
  if [ $update_ctr -ne $update_int ]; then
    UPDATES=$(./check_updates.sh)
    update_ctr=0
  fi
  update_ctr=$(( update_ctr+1 ))

  #if [ $UPDATES != "0" ]; then
    #echo -n "%{B#d26d33}%{O16}updates available%{O16}%{B-}"
  #fi
}

while true; do
  buf=""
  buf="${buf} %{l}$(Wifi)"
  buf="${buf} $(Batt)"
  buf="${buf} $(Bright)"
  buf="${buf} %{c}$(Updates)"
  buf="${buf} %{r}$(Clock)" 
  echo ${buf}
  sleep 1
done
