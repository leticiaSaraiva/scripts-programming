# Correção: OK. 1,0 Ponto. Agora se acostume a colocar #!/bin/bash ao início de cada script.
mkdir maiorque10

find arquivos/ -size +10M -exec mv {} maiorque10/ \;

tar -czvf maiorque10.tar.gz maiorque10/

rm -r maiorque10

