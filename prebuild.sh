#!/bin/bash

clear

RED='\033[0;31m'
NC='\033[0m'
path="./src/components"
index="./src/index.ts"
cols=$(tput cols)
errors=0

function repeat_chracter () {
  prepends=""
  for ((n=0;n<$1;n++))
  do
    prepends+=$2
  done
}

repeat_chracter cols "="
echo -e "$prepends\nChecking components...\n$prepends\n"

for f in $path/*
do
  component=${f#"$path/"}
  if grep -q $component "$index"; then
    result="${component} is exported "
    width=$((cols - ${#result} - 3))
    repeat_chracter width "-"
    echo $result $prepends 👌
  else
    result="${component} is not exported "
    width=$((cols - ${#result} - 3))
    repeat_chracter width "-"
    errors=$((errors + 1))
    echo $result $prepends 💀
  fi
done

if [ $errors -ne 0 ]; then
  repeat_chracter cols "="
  echo -e "\n$prepends"
  echo -e "You have ${RED}$errors${NC} component not exported."
  exit
else
  clear
  # Start building process
  yarn rollup -c
fi
