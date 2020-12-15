#!/bin/bash
# Correção: OK

echo "Olá $(whoami), Hoje é dia $(date +%d), do mês $(date +%m) do ano de $(date +%Y)" | tee -a saudacao.log
