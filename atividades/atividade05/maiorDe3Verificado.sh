#!/bin/bash
# Correção: 1,0
numero1=${1}
numero2=${2}
numero3=${3}

if ! expr ${numero1} + 1 &> /dev/null
then 
	echo "Opa! ${numero1} não é um número."
elif ! expr ${numero2} + 1 &> /dev/null
then 
	echo "Opa! ${numero2} não é um número."
elif ! expr ${numero3} + 1 &> /dev/null
then 
	echo "Opa! ${numero3} não é um número."
else
	if [ ${numero1} -ge ${numero2} -a ${numero1} -ge ${numero3} ] &> /dev/null
	then
		echo ${numero1}
	elif [ ${numero2} -ge ${numero1} -a ${numero2} -ge ${numero3} ] &> /dev/null
	then
		echo ${numero2}
	elif [ ${numero3} -ge ${numero1} -a ${numero3} -ge ${numero2} ] &> /dev/null
	then
		echo ${numero3}	
	fi
fi

