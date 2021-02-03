#!/bin/bash
# Correção: 1,0
trap "clear; echo 'Até a próxima!'; exit" 2

menu()
{	
	clear
	echo "Opções:"
	echo "1 - Tempo ligado"
	echo "2 - Últimas mensagens do kernel"
	echo "3 - Memória virtual"
	echo "4 - Uso da CPU por núcleo" 
	echo "5 - Uso da CPU por processos" 
	echo "6 - Uso da memória física"
	
	read -p "Digite o número referente a opção desejada: " OPCAO	
}

tempo_ligado()
{
	clear
	uptime
}

ultimas_msg_kernel()
{
	clear
	dmesg | tail -n 10
}

memoria_virtual()
{
	clear
	vmstat 1 10
}

uso_da_cpu_por_nucleo()
{
	clear
	mpstat -P ALL 1 5
}

uso_da_cpu_por_processos()
{
	clear
	pidstat 1 5
}

uso_memoria_fisica()
{
	clear
	free -m
}

while true
do
	menu
	
	if [[ ${OPCAO} -eq 1 ]]
	then
		tempo_ligado
	elif [[ ${OPCAO} -eq 2 ]]  
	then
		ultimas_msg_kernel
	elif [[ ${OPCAO} -eq 3 ]]  
	then
		memoria_virtual
	elif [[ ${OPCAO} -eq 4 ]]  
	then
		uso_da_cpu_por_nucleo
	elif [[ ${OPCAO} -eq 5 ]]  
	then
		uso_da_cpu_por_processos
	elif [[ ${OPCAO} -eq 6 ]]  
	then
		uso_memoria_fisica
	else
		clear
		echo "Opção inválida"
	fi
	
	echo ""
	read -p "Pressione enter para retornar ao menu inicial..."
done
