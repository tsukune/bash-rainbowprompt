#!/bin/bash

# Rainbowize the hostname!

rainbowize() {
   declare source=${*}
   declare -i mojisu=${#source}

   # rainbowize $source
   declare -a color=(red yellow green cyan blue magenda)
   declare -i i=0
   declare rainbowstr=

   while [ ${mojisu} -gt 0 ]; do
      declare -i order=$i+1
      letter=`echo ${source} | cut -c${order}`
      # rainbowize per-character
      iro=${color[$i%6]}
      if [ "${iro}" = "red" ]; then
         letter="\033[31;1m${letter}\033[0m"
      elif [ "${iro}" = yellow ]; then
         letter="\033[33;1m${letter}\033[0m"
      elif [ "${iro}" = green ]; then
         letter="\033[32;1m${letter}\033[0m"
      elif [ "${iro}" = cyan ]; then
         letter="\033[36;1m${letter}\033[0m"
      elif [ "${iro}" = blue ]; then
         letter="\033[34;1m${letter}\033[0m"
      elif [ "${iro}" = magenda ]; then
         letter="\033[35;1m${letter}\033[0m"
      fi

      rainbowstr=${rainbowstr}${letter}
      let ++i
      let --mojisu
   done

   # escape backslash 
   str=`echo ${rainbowstr} | sed -e "s:\\\\\\033\[\([0-9]\{2\}\);1m\\\\\\\\\\\\\\\\\\033\[0m:\\\\\\033\[\1;1m\\\\\\\\\\\\\\\\\\\\\\\\033\[0m:g"`
}

if echo ${PS1} | grep "\\\\h" ; then
   # rainbowize hostname
   declare sourcestr=`hostname -s`
   rainbowize ${sourcestr}
   # convert the rainbowized hostname to do "export PS1"
   str=`echo ${str} | sed -e "s:\(\\\\\\033\[\([0-9]\{2\}\);1m\([a-zA-Z0-9 ]\{1\}\)\\\\\\033\[0m[ ]\{0,\}\):\\\\\\\[\\\\\\033\[\2;1m\\\\\\\]\3\\\\\\\[\\\\\\\033\[0m\\\\\\\]:g"`
   # escape backslash
   str=`echo ${str}| sed -e "s:\\\\\\:\\\\\\\\\\\\\:g"`
   # insert a rainbow into PS1
   PS=`echo ${PS1} | sed -e "s:\\\\\\h:${str}:g"`
   export PS1=${PS}
else
   # print this message when $PS1 does not have \h
   declare message='Your $PS1 does not have the hostname. Add "\h" to your $PS to see a rainbow.'
   rainbowize ${message}
   echo -e ${str}
   echo ""
   echo 'Your $PS1:'
   echo "$PS1"
   echo ""
fi


