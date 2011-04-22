#!/bin/bash

# Print HOSTNAME to a rainbow colors.

if echo ${PS1} | grep "\\\\h" ; then
   declare sourcestr
   sourcestr=`hostname -s`
   declare -i mojisu=${#sourcestr}

   # Rainbowize
   declare -a color=(red yellow green cyan blue magenda)
   declare -i i=0
   declare rainbowstr=

   while [ ${mojisu} -gt 0 ]; do
      declare -i order=$i+1
      letter=`echo ${sourcestr} | cut -c${order}`

      # Paint it rainbow
      iro=${color[$i%6]}
      if [ "${iro}" = "red" ]; then
         letter="\[\033[31;1m\]${letter}\[\033[0m\]"
      elif [ "${iro}" = yellow ]; then
         letter="\[\033[33;1m\]${letter}\[\033[0m\]"
      elif [ "${iro}" = green ]; then
         letter="\[\033[32;1m\]${letter}\[\033[0m\]"
      elif [ "${iro}" = cyan ]; then
         letter="\[\033[36;1m\]${letter}\[\033[0m\]"
      elif [ "${iro}" = blue ]; then
         letter="\[\033[34;1m\]${letter}\[\033[0m\]"
      elif [ "${iro}" = magenda ]; then
         letter="\[\033[35;1m\]${letter}\[\033[0m\]"
      fi

      rainbowstr=${rainbowstr}${letter}

      let ++i
      let --mojisu
   done
   # Add back-slach to substitute them
   rainbowstr=`echo ${rainbowstr}|sed -e "s:\\\\\\\\:\\\\\\\\\\\\\\\\:g"`

   # Substitute \h with raibowized \h
   PS=`echo ${PS1} | sed -e "s:\\\\\h:${rainbowstr}:g"`

   export PS1=${PS}
else
   echo ''
   echo 'Your $PS1 does not have the hostname. Add "\h" to your $PS1.'
   echo ''
fi

