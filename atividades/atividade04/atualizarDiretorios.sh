#!/bin/bash
cp /etc/passwd /home/alunos/leticiasaraiva/leticiasaraivascripts20202/atividades/atividade04/passwd.new
sed -i 's/\/home\/alunos/\/srv\/students/g' passwd.new
