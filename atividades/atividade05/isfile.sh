#!/bin/bash
parametro=${1}

if $(test -d ${parametro}) &> /dev/null
then
	echo "É um diretório."
elif $(test -f ${parametro}) &> /dev/null
then
	echo "É um arquivo."
else
	echo "Não é arquivo, nem diretório."
fi

if $(test -r ${parametro}) &> /dev/null
then
	echo "Tem permissão de leitura."
else
	echo "Não tem permissão de leitura."
fi

if $(test -w ${parametro}) &> /dev/null
then
	echo "Tem permissão de escrita."
else
	echo "Não tem permissão de escrita."
fi

