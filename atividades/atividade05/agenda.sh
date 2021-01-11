#!/bin/bash
opcao=${1}
nome=${2}
email=${3}

case ${opcao} in
	adicionar)
		echo "${nome}:${email}" >> usuarios.db
		 ;;
	listar)
		cat usuarios.db
		;;
	remover)
		sed -i '/'${nome}'/d' usuarios.db
		;;
esac
