#!/bin/bash

VERDE=$(tput setaf 2)
NORMAL=$(tput sgr0)

# Função para limpar a tela e exibir o menu
menu() {
    tput clear # 1. Limpeza e Menu: Limpa a tela
    
    echo "${VERDE}## Monitor de Desempenho Interativo ${NORMAL}" # Título do Menu
    echo "-----------------------------------"
    echo "Selecione uma opção:"
    echo "1) uptime (Tempo ligado do sistema)"
    echo "2) dmesg \\| tail -n 10 (10 últimas mensagens do Kernel)"
    echo "3) vmstat 1 10 (Estatísticas de memória virtual)"
    echo "4) mpstat -P ALL 1 5 (Uso da CPU por núcleo)"
    echo "5) pidstat 1 5 (Uso da CPU por processo)"
    echo "6) free -m (Uso da memória física em Megabytes)"
    echo "7) Sair"
    echo "-----------------------------------"
    echo -n "Opção: "
}

# Laço Principal: O script deve ser executado em um laço de repetição
while true; do
    
    # 2. Função Menu (Obrigatório): Cria uma função chamada menu para exibir o título do sistema e todas as opções disponíveis.
    menu 
    
    # 3. Processamento da Escolha: Uso do comando read para capturar a escolha do usuário.
    read escolha
    
    # Executar o comando correspondente à opção
    case $escolha in
        1)
            tput clear # Limpar a tela novamente
            echo "${VERDE}*** 1) Tempo ligado do sistema (uptime) ***${NORMAL}"
            uptime # Executar o comando
            ;;
        2)
            tput clear
            echo "${VERDE}*** 2) 10 últimas mensagens do Kernel (dmesg | tail -n 10) ***${NORMAL}"
            dmesg | tail -n 10 # Executar o comando
            ;;
        3)
            tput clear
            echo "${VERDE}*** 3) Estatísticas de memória virtual (vmstat 1 10) ***${NORMAL}"
            vmstat 1 10 # Executar o comando
            ;;
        4)
            tput clear
            echo "${VERDE}*** 4) Uso da CPU por núcleo (mpstat -P ALL 1 5) ***${NORMAL}"
            mpstat -P ALL 1 5 # Executar o comando
            ;;
        5)
            tput clear
            echo "${VERDE}*** 5) Uso da CPU por processo (pidstat 1 5) ***${NORMAL}"
            pidstat 1 5 # Executar o comando
            ;;
        6)
            tput clear
            echo "${VERDE}*** 6) Uso da memória física em Megabytes (free -m) ***${NORMAL}"
            free -m # Executar o comando
            ;;
        7)
            # A opção Sair (7) termina a execução
            echo "Encerrando o monitor de desempenho. Até logo!"
            exit 0
            ;;
        *)
            # Tratamento de opção inválida
            tput clear
            echo "Opção inválida: $escolha. Tente novamente."
            ;;
    esac
    
    # Após executar o comando (exceto para a opção 7), aguardar o usuário para retornar ao menu
    if [[ $escolha -ne 7 ]]; then
        read -n 1 -p "Pressione ENTER para voltar ao menu..."
    fi
    
done