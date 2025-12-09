#!/bin/bash

# Nome do arquivo
AGENDA_FILE="agenda.db"

# Função para criar o arquivo da agenda
criar_agenda() {
    if [ ! -f "$AGENDA_FILE" ]; then
        touch "$AGENDA_FILE"
        echo "Arquivo criado!!!"
    fi
}

# Operação ADICIONAR
adicionar_usuario() {
    # Verifica se foram passados 2 argumentos (nome e e-mail)
    if [ $# -ne 2 ]; then
        echo "Uso: ./agenda.sh adicionar \"Nome Completo\" email@exemplo.com"
        exit 1
    fi

    local nome="$1"
    local email="$2"

    # Cria o arquivo se não existir
    criar_agenda

    # Formato: Nome Completo:email@exemplo.com
    echo "$nome:$email" >> "$AGENDA_FILE"
    echo "Usuário $nome adicionado."
}

# Operação REMOVER
remover_usuario() {
    # Verifica se foi passado 1 argumento (o e-mail)
    if [ $# -ne 1 ]; then
        echo "Uso: ./agenda.sh remover email@exemplo.com"
        exit 1
    fi

    local email_remover="$1"

    # Verifica se o arquivo existe
    if [ ! -f "$AGENDA_FILE" ]; then
        echo "Arquivo vazio!!!"
        exit 0
    fi

    # Conta o número de linhas com o e-mail 
    local linhas_encontradas=$(grep -c ":$email_remover$" "$AGENDA_FILE")

    if [ "$linhas_encontradas" -eq 0 ]; then
        echo "Usuário com e-mail $email_remover não encontrado. Agenda inalterada."
    else
        # Usa 'grep -v' para listar todas as linhas MENOS a que contém o e-mail,
        # e salva em um arquivo temporário.
        grep -v ":$email_remover$" "$AGENDA_FILE" > temp_agenda.db
        
        # Substitui o arquivo original pelo temporário
        mv temp_agenda.db "$AGENDA_FILE"
        
        echo "Usuário com e-mail $email_remover removido."
    fi
}

# Operação LISTAR
listar_usuarios() {
    # Verifica se o arquivo existe
    if [ ! -f "$AGENDA_FILE" ] || [ ! -s "$AGENDA_FILE" ]; then
        echo "Arquivo vazio!!!"
    else
        # Lista o conteúdo, substituindo ':' por ': ' para melhor visualização
        cat "$AGENDA_FILE" | sed 's/:/: /'
    fi
}

# Verifica se a operação foi passada
if [ $# -eq 0 ]; then
    echo "Uso: ./agenda.sh <operacao> [parametros]"
    echo "Operações suportadas: adicionar, remover, listar"
    exit 1
fi

OPERACAO="$1"
shift # Remove o primeiro argumento (operação) da lista de argumentos

case "$OPERACAO" in
    adicionar)
        # O $1 e $2 agora são os argumentos restantes (nome e email)
        adicionar_usuario "$1" "$2"
        ;;
    remover)
        # O $1 agora é o argumento restante (email)
        remover_usuario "$1"
        ;;
    listar)
        listar_usuarios
        ;;
    *)
        echo "Operação inválida: $OPERACAO"
        echo "Operações suportadas: adicionar, remover, listar"
        exit 1
        ;;
esac

exit 0