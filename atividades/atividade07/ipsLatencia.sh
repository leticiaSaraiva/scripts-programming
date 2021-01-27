#!/bin/bash
# Correção: 0,5
IPS=${1}

echo "Relatório de Latência."
for ip in $(cat ${IPS})
do
	TEMPO=$(ping -c5 ${ip} | grep 'avg' | cut -f4 -d' ' | cut -f2 -d'/')
	echo "${ip} ${TEMPO}ms"
done
