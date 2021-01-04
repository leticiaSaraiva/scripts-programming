#!/bin/bash
opcao=${1}
nome=${2}
email=${3}

if $(test ${opcao} = "adicionar") &> /dev/null 
then 
	echo "${nome}:${email}" >> usuarios.db
else
	if $(test ${opcao} = "listar") &> /dev/null
	then
		cat usuarios.db
	else
		echo "Erro"
	fi
fi

