#!/bin/bash

# 虹色にする文字列とその文字数
declare myhostname
myhostname=`hostname -s`
declare -i mojisu=${#myhostname}

# 虹色化
declare -i i=0
declare rainbowstr=

while [ ${mojisu} -gt 0 ]; do
   # 虹色
   declare -a color=(red yellow green cyan blue magenda)

   # 文字を1文字切り出す
   declare -i order=$i+1
   letter=`echo ${myhostname} | cut -c${order}`

   # 文字に色を付ける
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

   # 文字列を結合する
   rainbowstr=${rainbowstr}${letter}

   # 残りの文字数の計算など
   let ++i
   let --mojisu
done

export PS1="[\u@${rainbowstr}: \w]\$ "

