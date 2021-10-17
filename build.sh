#!/bin/bash
path="./src/components"

if [ CI = true ]; then
  for f in $path/*
    do
      component=${f#"$path/"}
      if grep -q $component "$index"; then
        echo $component exported
      else
        exit 1
      fi
  done
else
  clear

  RED='\033[0;31m'
  GREEN='\033[0;32m'
  NC='\033[0m'
  index="./src/index.ts"
  cols=$(tput cols)
  errors=0

  repeat_chracter cols "="
  echo -e "$prepends\nChecking exports...\n$prepends\n"

  for f in $path/*
    do
      component=${f#"$path/"}
      if grep -q $component "$index"; then
        result="${component} is exported "
        width=$((cols - ${#result} - 3))
        prepends=""
        for ((n=0;n<$width;n++))
        do
          prepends+="-"
        done
        echo -e "$result${GREEN}$prepends${NC} 👌"
      else
        result="${component} is not exported "
        width=$((cols - ${#result} - 3))
        prepends=""
        for ((n=0;n<$width;n++))
        do
          prepends+="-"
        done
        errors=$((errors + 1))
        echo -e "$result${RED}$prepends${NC} 💀"
      fi
  done

  if [ $errors -ne 0 ]; then
    prepends=""
    for ((n=0;n<$cols;n++))
    do
      prepends+="-"
    done
    echo -e "\n$prepends"
    echo -e "You have ${RED}$errors${NC} component(s) not exported."
    exit 1
  else
    # Start building process
    yarn rollup -c
  fi
fi
