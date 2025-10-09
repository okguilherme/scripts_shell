#!/bin/bash

# Um script chamado loja.sh que mostre o nome da loja que teve o produto mais caro.

_compras="/mnt/sda3_dados/#/UFC/repository/scripts_shell/atividades/atividade04/compras.txt"

#tail -n +2 → tira o cabeçalho.
#sort -t',' -k2 -nr → ordena por campo 2 numericamente e em ordem decrescente (use -k2,2 para maior precisão).
#head -n1 → pega o produto mais caro.
#cut -d',' -f3 → extrai a loja (mas pode trazer espaços).


# Ignora o cabeçalho e ordena pelo valor (campo 2), pegando o maior, depois mostra a loja (campo 3)
_loja=$(tail -n +2 "$_compras" | sort -t',' -k2 -nr | head -n 1 | cut -d',' -f3)

echo "Loja com o produto mais caro:$_loja"