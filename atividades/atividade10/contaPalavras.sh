#!/bin/bash
read -p "Informe o arquivo: " ARQ

# percorrer as palavras únicas do arquivo e contar a quantidade de cada uma no arquivo
for PALAVRA in $(cat ${ARQ} | egrep -o '[A-Za-z]+' | sort | uniq)
do
	QTD=$(cat ${ARQ} | grep -wo ${PALAVRA} | wc -l)
	echo "${PALAVRA}: ${QTD}"
done 
