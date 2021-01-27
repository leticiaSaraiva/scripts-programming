#!/bin/bash
# Correção: 1,0
DIR1=${1}
DIR2=${2}

for arq in $(ls ${DIR1})
do
	DATAARQ=$(stat -c %y ${DIR1}${arq} | cut -f1 -d' ' | sed 's/'-'/\//g')
	ANO=$(echo "${DATAARQ}" | cut -f1 -d'/')
	MES=$(echo "${DATAARQ}" | cut -f2 -d'/')
	DIA=$(echo "${DATAARQ}" | cut -f3 -d'/')

	if [ ! -d ${DIR2}${ANO}/${MES}/${DIA} ]
	then
		mkdir -p ${DIR2}${ANO}/${MES}/${DIA}
	fi
	cp ${DIR1}${arq} ${DIR2}${ANO}/${MES}/${DIA}
done
