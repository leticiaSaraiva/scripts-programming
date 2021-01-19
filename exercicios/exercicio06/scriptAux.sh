#!/bin/bash
IP_1=${1}

echo "INICIO" > ${IP_1}.txt
for i in $(seq 1 255)
do
	IP=${IP_1}.${i}
	PING=$(ping -c 1 ${IP}) >> /dev/null
	if [ $? = 0 ]
	then
		echo "${IP} on" >> ${IP_1}.txt
	fi
done
echo "FIM" >> ${IP_1}.txt

