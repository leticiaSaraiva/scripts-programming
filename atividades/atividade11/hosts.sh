#!/bin/bash
hostname="vazio"
ip="vazio"
acao="vazio"

if [[ $1 != "-a" && $1 != "-i" && $1 != "-d" && $1 != "-l" && $1 != "" ]]
then
	hostname=$1
	acao="procurar"
fi

while getopts "a:i:d:l" OPTVAR
do
	if [ "$OPTVAR" == "a" ]
	then
		hostname=$OPTARG
	fi
	if [ "$OPTVAR" == "i" ]
	then
		ip=$OPTARG
		acao="adicionar"
	fi
	if [ "$OPTVAR" == "d" ]
	then
		hostname=$OPTARG
		acao="remover"
	fi
	if [ "$OPTVAR" == "l" ]
	then
		acao="listar"
	fi
done

adicionar()
{
	echo "${1} ${2}" >> hosts.db
}

remover()
{
	sed -i "/$1/d" hosts.db
}

procurar()
{
	grep $1 hosts.db | cut -d' ' -f2

}

listar()
{
	cat hosts.db	
}

case $acao in
	adicionar)
		adicionar ${hostname} ${ip}
		;;
	remover)
		remover ${hostname}
		;;
	procurar)
		procurar ${hostname}
		;;
	listar)
		listar
		;;
	*)
		echo "Erro"
		;;
esac

