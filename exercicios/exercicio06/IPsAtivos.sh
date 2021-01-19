#!/bin/bash
IP=${1}

chmod +x scriptAux.sh
echo "Iniciando análise da rede ${IP}.0/24."
echo "O resultado estará em ${IP}.txt"
./scriptAux.sh ${IP} &
