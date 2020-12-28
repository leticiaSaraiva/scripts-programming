#!/bin/bash
# Correção: 1,0. Ok, mas tente não usar caminhos completos. Bastava colocar passwd.new
cp /etc/passwd /home/alunos/leticiasaraiva/leticiasaraivascripts20202/atividades/atividade04/passwd.new
sed -i 's/\/home\/alunos/\/srv\/students/g' passwd.new
