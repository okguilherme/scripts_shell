#!/bin/bash

#grep [opções] 'padrão' [arquivo]

echo -e "\n1. Um comando grep que encontre todas as linhas com mensagens que não são do sshd.\n"
#pausa o script até o usuário pressionar Enter
read -p "Pressione Enter para continuar..."

# A opção '-v' inverte a busca, mostrando linhas que *não* correspondem ao padrão.
#.* significa qualquer caractere repetido zero ou mais vezes
grep -v 'sshd.*' /home/guilhermeo.lima/Documentos/atividades/atividade03/auth.log

echo -e "\n_________________________________________________________________________________________\n
2. Um comando grep que encontre todas as linhas com mensagens que indicam um login de sucesso via sshd cujo 
nome do usuário começa com a letra j.\n"
read -p "Pressione Enter para continuar..."

grep 'sshd.*: Accepted .* for j' /home/guilhermeo.lima/Documentos/atividades/atividade03/auth.log

echo -e "\n_________________________________________________________________________________________\n
3. Comando grep que encontre todas as vezes que alguém tentou fazer login via root através do sshd.\n"
read -p "Pressione Enter para continuar..."

grep 'sshd.* root' /home/guilhermeo.lima/Documentos/atividades/atividade03/auth.log

echo -e "\n_________________________________________________________________________________________\n
4. Comando grep que encontre todas as vezes que alguém conseguiu fazer login com sucesso no dia 29 de Setembro.\n"
read -p "Pressione Enter para continuar..."

grep '09-29.* Accepted' /home/guilhermeo.lima/Documentos/atividades/atividade03/auth.log


