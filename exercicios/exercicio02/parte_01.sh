# Correção: 0,75

grep -E '[0-9] A' /home/compartilhado/emailsordenados.txt

grep -E '\bA' /home/compartilhado/emailsordenados.txt

grep -E '\b.br$' /home/compartilhado/emailsordenados.txt

# Não entendi o \B. Seria melhor usar o @
grep -E '\B[0-9][^0-9 ]' /home/compartilhado/emailsordenados.txt
