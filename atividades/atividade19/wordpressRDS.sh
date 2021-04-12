#!/bin/bash
# Correção: 2,5
echo "Criando instância de Banco de Dados no RDS..."

KEYNAME=${1}
USER=${2}
PASSWORD=${3}

# Obtendo o ID do VPC
VPCID=$(aws ec2 describe-vpcs --query  "Vpcs[0].VpcId" --output text)

# Criando um grupo de segurança e obtendo o ID
SECGROUPID=$(aws ec2 create-security-group --group-name "scriptsAtv19" --description "Security group scripts" --vpc-id ${VPCID} --output text)

# Obtendo IP visível
IPVISIVEL=$(curl ifconfig.me/ip 2> /dev/null)

# Adicionando regra de liberação das portas 22 e 80 TCP
aws ec2 authorize-security-group-ingress --group-id ${SECGROUPID} --protocol tcp --port 22 --cidr ${IPVISIVEL}/32

aws ec2 authorize-security-group-ingress --group-id ${SECGROUPID} --protocol tcp --port 80 --cidr 0.0.0.0/0

aws ec2 authorize-security-group-ingress --group-id ${SECGROUPID} --protocol tcp --port 3306 --source-group ${SECGROUPID}

SUBNETRDS=$(aws rds describe-db-subnet-groups --filters Name=vpc-id,Values=${VPCID} --query "DBSubnetGroups[0].DBSubnetGroupName" --output text)

# Criando instância no RDS
RDS=$(aws rds create-db-instance --db-instance-identifier scriptsAtv19 --engine mysql --master-username ${USER} --master-user-password ${PASSWORD} --allocated-storage 20 --no-publicly-accessible --db-subnet-group-name ${SUBNETRDS} --vpc-security-group-ids ${SECGROUPID} --db-instance-class db.t2.micro)

STATUSRDS=$(aws rds describe-db-instances --query "DBInstances[].DBInstanceStatus" --output text)

while [ "${STATUSRDS}" != "available" ]
do
	STATUSRDS=$(aws rds describe-db-instances --query "DBInstances[].DBInstanceStatus" --output text)
	sleep 10
done

ENDPOINT=$(aws rds describe-db-instances --query "DBInstances[].Endpoint.Address" --output text)

echo "Endpoint do RDS: ${ENDPOINT}"

echo ""

echo "Criando Servidor de Aplicação..."

# ID da AMI
IMAGEID="ami-03d315ad33b9d49c4"

# Obtendo a Sub-rede
SUBNETID=$(aws ec2 describe-subnets --filters Name=vpc-id,Values=${VPCID} --query "Subnets[0].SubnetId" --output text)

# Alterando o usuário e senha do banco, e endpoint do rds
sed -i "s/usuario/${USER}/" user_data.sh
sed -i "s/senha/${PASSWORD}/" user_data.sh
sed -i "s/endpoint/${ENDPOINT}/" user_data.sh

# Criando a instância e obtendo o Id 
INSTANCEID=$(aws ec2 run-instances --image-id ${IMAGEID} --instance-type "t2.micro" --key-name ${KEYNAME} --security-group-ids ${SECGROUPID} --subnet-id ${SUBNETID} --user-data file://user_data.sh --query "Instances[0].InstanceId" --output text)

# Obtendo o estado da instância (pending or running)
STATEINSTANCE=$(aws ec2 describe-instances --instance-id ${INSTANCEID} --query "Reservations[0].Instances[0].State.Name" --output text)

while [ "${STATEINSTANCE}" == "pending" ]
do
	STATEINSTANCE=$(aws ec2 describe-instances --instance-id ${INSTANCEID} --query "Reservations[0].Instances[0].State.Name" --output text)
done

# Endereço IP Público do Servidor de aplicação
IP_PUB=$(aws ec2 describe-instances --filters Name=instance-id,Values=${INSTANCEID} --query "Reservations[0].Instances[0].PublicIpAddress" --output text)

sleep 50
echo "IP Público do Servidor de Aplicação: ${IP_PUB}"
echo ""
echo "Acesse http://${IP_PUB}/wordpress para finalizar a configuração"
