#!/bin/bash
DIR1=${1}
DIR2=${2}
DATA=${3}

DATASEGUNDOS=$(date +%s -d "${DATA}")

for arq in $(ls ${DIR1})
do
	DATAARQ=$(stat -c %Y ${DIR1}/${arq} | cut -f1 -d'.')
	if [ ${DATAARQ} -gt ${DATASEGUNDOS} ]
	then
		cp ${DIR1}${arq} ${DIR2}
	fi
done
