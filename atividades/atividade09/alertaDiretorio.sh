#!/bin/bash
# Correção: 3,0
TEMPO=${1}
DIR=${2}

QTD_ANT=$(ls ${DIR} | wc -l)
ls ${DIR} > arquivos.txt

while true
do
	QTD_NOVA=$(ls ${DIR} | wc -l)
	ARQS=""
	if [ ${QTD_NOVA} -gt ${QTD_ANT} ]
	then
		DATA=$(date +"%d-%m-%Y %T")
		
		for f in $(ls ${DIR})
		do
			grep ${f} arquivos.txt > /dev/null
			if [ $? -ne 0 ]
			then
				ARQS="${ARQS} ${f}"
			fi
		done
		
		echo "[${DATA}] Alteração! ${QTD_ANT}->${QTD_NOVA}. Adicionados: ${ARQS}" >> dirSensors.log
		
		QTD_ANT=${QTD_NOVA}
		ls ${DIR} > arquivos.txt
		
	elif [ ${QTD_NOVA} -lt ${QTD_ANT} ]
	then
		DATA=$(date +"%d-%m-%Y %T")
		
		for l in $(cat arquivos.txt)
		do
			if [ ! $(find ${DIR} -name ${l}) ] > /dev/null
			then
				ARQS="${ARQS} ${l}"
			fi	
		done
		
		echo "[${DATA}] Alteração! ${QTD_ANT}->${QTD_NOVA}. Removidos: ${ARQS}" >> dirSensors.log
		
		QTD_ANT=${QTD_NOVA}
		ls ${DIR} > arquivos.txt
	fi
	sleep ${TEMPO}
done
