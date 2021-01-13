#!/bin/bash
# Correção OK
DIR1=${1}
DIR2=${2}

for arq in $(ls ${DIR1})
do
	if [ ! $(find ${DIR2} -name ${arq}) ]
	then
		cp ${DIR1}${arq} ${DIR2}
	fi
done
