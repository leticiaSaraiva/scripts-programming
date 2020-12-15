#!/bin/bash
# Correção: OK
cat compras.txt | cut -d' ' -f2 | tr -s '\n' '+' | sed 's/+$/\n/' | bc


