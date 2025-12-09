#!/bin/bash

tput clear

TITULO="Relatório de Status"
VERSAO="1.0"

echo -n "$(tput setaf 4)$(tput bold)"
echo "$TITULO"
tput sgr0 # Restaura as configurações após o título

# tput cup [linha] [coluna]
tput cup 5 10

# tput setaf 1: Define a cor de foreground como vermelho
# tput smul: Define o estilo como sublinhado (Start UnderLine)
echo -n "Versão: $(tput setaf 1)$(tput smul)$VERSAO"

tput sgr0

tput cup 8 10
echo -n "Data e Hora Atual: "
date

tput cup 10 10
echo -n "Usuário Atual: "
whoami

#Posiciona o cursor em uma linha limpa no final para um prompt organizado
tput cup 12 0