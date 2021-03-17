#!/bin/bash
# OK

echo "Criando servidor..."

KEYNAME=${1}

# ID da AMI
IMAGEID="ami-03d315ad33b9d49c4"

# Obtendo o ID do VPC
VPCID=$(aws ec2 describe-vpcs --query  "Vpcs[0].VpcId" --output text)

# Criando um grupo de segurança e obtendo o ID
SECGROUPID=$(aws ec2 create-security-group --group-name "scripts" --description "Security group scripts" --vpc-id ${VPCID} --output text)

# Adicionando regra de liberação das portas 22 e 80 TCP
aws ec2 authorize-security-group-ingress --group-id ${SECGROUPID} --protocol tcp --port 22 --cidr 0.0.0.0/0

aws ec2 authorize-security-group-ingress --group-id ${SECGROUPID} --protocol tcp --port 80 --cidr 0.0.0.0/0

# Obtendo a Sub-rede
SUBNETID=$(aws ec2 describe-subnets --filters Name=vpc-id,Values=${VPCID} --query "Subnets[0].SubnetId" --output text)

# Criando a instância e obtendo o Id 
INSTANCEID=$(aws ec2 run-instances --image-id ${IMAGEID} --instance-type "t2.micro" --key-name ${KEYNAME} --security-group-ids ${SECGROUPID} --subnet-id ${SUBNETID} --user-data file://user_data.sh --query "Instances[0].InstanceId" --output text)

# Obtendo o estado da instância (pending or running)
STATEINSTANCE=$(aws ec2 describe-instances --instance-id ${INSTANCEID} --query "Reservations[0].Instances[0].State.Name" --output text)

while [ ${STATEINSTANCE} == 'pending' ]
do
	STATEINSTANCE=$(aws ec2 describe-instances --instance-id ${INSTANCEID} --query "Reservations[0].Instances[0].State.Name" --output text)
done

# Endereço IP Público
IP=$(aws ec2 describe-instances --filters Name=instance-id,Values=${INSTANCEID} --query "Reservations[0].Instances[0].PublicIpAddress" --output text)

echo "Acesse: http://${IP}/"
