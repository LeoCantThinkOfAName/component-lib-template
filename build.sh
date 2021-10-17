#!/bin/bash
clear
path="./src/components"
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'
index="./src/index.ts"
cols=$(tput cols)
errors=0

repeat_chracter() {
  prepends=""
  for n in `seq $1`
  do
    prepends+=$2
  done
}

repeat_chracter $cols "="
echo -e "$prepends\nChecking exports...\n$prepends\n"

for f in $path/*
do
  component=${f#"$path/"}
  if grep -q $component "$index"; then
    result="${component} is exported "
    width=$((cols - ${#result} - 3))
    repeat_chracter $width "-"
    echo -e "$result${GREEN}$prepends${NC} 👌"
  else
    result="${component} is not exported "
    width=$((cols - ${#result} - 3))
    repeat_chracter $width "-"
    errors=$((errors + 1))
    echo -e "$result${RED}$prepends${NC} 💀"
  fi
done

if [ $errors -ne 0 ]; then
  repeat_chracter $cols "="
  echo -e "\n$prepends"
  echo -e "You have ${RED}$errors${NC} component(s) not exported."
  exit 1
else
  # Start building process
  yarn rollup -c
fi
