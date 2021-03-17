#!/bin/bash

sudo echo "#!/bin/bash

DATA_HORARIO=\$(date +%H:%M:%S-%D)

MAQ_ATIVA=\$(uptime -p)
        
CARGA_MEDIA=\$(mpstat | awk '{ if (NR != 1 && NR != 2){ printf \"%s %s %s %s %s %s\n\", \$2, \$3, \$4, \$5, \$6, \$12 } }')

MEM_LIVRE=\$(echo \"\$(free -m)\" | grep \"Mem\" | awk '{ print \$4}')

MEM_OCUPADA=\$(echo \"\$(free -m)\" | grep \"Mem\" | awk '{ print \$3}')

BYTES_RECEBIDOS=\$(cat /proc/net/dev | grep eth0: | awk '{printf \"Recebidos: %s bytes;\", \$2}')
BYTES_ENVIADOS=\$(cat /proc/net/dev | grep eth0: | awk '{printf \"Enviados: %s bytes;\", \$10 }')


cat << EOF > /var/www/html/index.html
<!doctype html>
<html>
<head>
	<meta charset=\"utf-8\" />
	<meta http-equiv=\"refresh\" content=\"60\" >
</head>
<body>
	<table border=\"1\">
	    <tr>
		<td><b>Informações</b></td>
		<td><b>Resultados</b></td>
	    </tr>
	    <tr>
		<td>Horário e data da coleta</td>
		<td>\${DATA_HORARIO}</td>
	    </tr>
	    <tr>
		<td>Tempo que a máquina está ativa</td>
		<td>\${MAQ_ATIVA}</td>
	    </tr>
	    <tr>
		<td>Carga média do sistema</td>
		<td>\$(echo \${CARGA_MEDIA} | sed -s \"s/idle/idle<br\/>/g\")</td>
	    </tr>
	    <tr>
		<td>Quantidade de memória livre e ocupada</td>
		<td>\${MEM_LIVRE} livre; <br>\${MEM_OCUPADA} ocupada;</td>
	    </tr>
	     <tr>
		<td>Quantidade de <i>bytes</i> recebidos e enviados através da interface <i>eth0</i></td>
		<td>\${BYTES_RECEBIDOS} <br> \${BYTES_ENVIADOS}</td>
	    </tr>
	</table>
</body>
</html>
EOF" > /usr/local/bin/monitorar.sh

sudo chmod 744 /usr/local/bin/monitorar.sh
sudo apt-get update
sudo apt install sysstat -y
sudo apt install apache2 -y
sudo chmod -R 777 /var/www

sudo echo "*/1 *    * * *   root   /usr/local/bin/monitorar.sh" >> /etc/crontab

