#!/bin/bash
sed -i 's/#!\/bin\/python/#!\/usr\/python3/' atividade04.py
sed -i 's/nota1\|nota2\|notaFinal/\U&/g' atividade04.py
sed -i '2a\import time' atividade04.py
sed -i '$a\   print(time.ctime())' atividade04.py
