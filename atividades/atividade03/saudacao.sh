#!/bin/bash

# whoami retorna o nome do usuário logado no sistema
usuario=$(whoami) 

dia=$(date +%d)
mes=$(date +%m)
ano=$(date +%Y)

mensagem="Olá $usuario,
Hoje é dia $dia, do mês $mes do ano de $ano."
echo -e "$mensagem"

#O operador >> acrescenta (append) o conteúdo ao final do arquivo sem apagar o que já existe.
echo -e "$mensagem" >> /mnt/sda3_dados/#/UFC/repository/scripts_shell/atividades/atividade03/saudacao.log
