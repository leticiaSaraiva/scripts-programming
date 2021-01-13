#!/bin/bash
IPS=${1}

for ip in $(cat ${IPS})
do
	VALOR1=$(echo "$ip" | cut -f1 -d'.' )
	VALOR2=$(echo "$ip" | cut -f2 -d'.' )
	VALOR3=$(echo "$ip" | cut -f3 -d'.' )
	VALOR4=$(echo "$ip" | cut -f4 -d'.' )

	if [ ${VALOR1} -lt "0" ] || [ ${VALOR1} -gt "255" ]
        then
                echo "${ip}" >> invalidos.txt
        elif [ ${VALOR2} -lt "0" ] || [ ${VALOR2} -gt "255" ]
        then
                echo "${ip}" >> invalidos.txt
        elif [ ${VALOR3} -lt "0" ] || [ ${VALOR3} -gt "255" ]
        then
                echo "${ip}" >> invalidos.txt
        elif [ ${VALOR4} -lt "0" ] || [ ${VALOR4} -gt "255" ]
        then
                echo "${ip}" >> invalidos.txt
        else
                echo "${ip}" >> validos.txt
        fi
done

echo "Endereços válidos:" > ips_classificados.txt
cat validos.txt >> ips_classificados.txt
echo -e "\nEndereços inválidos:" >> ips_classificados.txt
cat invalidos.txt >> ips_classificados.txt

rm validos.txt invalidos.txt
