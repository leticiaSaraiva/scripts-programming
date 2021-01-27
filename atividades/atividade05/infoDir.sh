#!/bin/bash
# Correção: 1,0
caminho=${1}
tamanho=$(du -s ${caminho} | cut -f1)
itens=$(ls ${caminho} | wc -l)

if $(test -d ${caminho}) &> /dev/null
then
	echo "O diretório ${caminho} ocupa ${tamanho} Kilobytes e tem ${itens} itens."
else
	echo "${caminho} não é um diretório!!!"
fi
