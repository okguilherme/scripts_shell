#!/bin/bash

# Define o nome do arquivo de log
LOG_FILE="dirSensors.log"

# 1. Validação de Parâmetros
if [ "$#" -ne 2 ]; then
    echo "Uso: $0 <intervalo_segundos> <caminho_diretorio>"
    exit 1
fi

INTERVALO=$1
DIRETORIO=$2

# Verifica se o intervalo é um número inteiro
if ! [[ "$INTERVALO" =~ ^[0-9]+$ ]]; then
    echo "Erro: O intervalo deve ser um número inteiro."
    exit 1
fi

# Verifica se o diretório existe
if [ ! -d "$DIRETORIO" ]; then
    echo "Erro: O diretório '$DIRETORIO' não existe."
    exit 1
fi

# 2. Função para Obter o Estado Atual do Diretório
# O comando 'ls -A1' lista os nomes de arquivos (incluindo ocultos, exceto . e ..), um por linha.
# O comando 'sort' garante que a ordem seja sempre a mesma para comparação.
# A função retorna o estado em stdout e o número de arquivos em $?
getEstado() {
    local estado=$(ls -A1 "$1" 2>/dev/null | sort)
    local contagem=$(echo "$estado" | wc -l)
    echo "$estado"
    return "$contagem"
}

# 3. Estado Inicial
ESTADO_ANTERIOR=$(getEstado "$DIRETORIO")
ARQUIVOS_ANTERIORES=$?

echo "Monitorando diretório: $DIRETORIO"

# 4. Laço principal de monitoramento
while true; do
    
    # 5. Obtém o estado atual
    ESTADO_ATUAL=$(getEstado "$DIRETORIO")
    ARQUIVOS_ATUAIS=$?
    
    # 6. Verifica se houve alteração no número de arquivos ou nos nomes
    if [ "$ESTADO_ANTERIOR" != "$ESTADO_ATUAL" ]; then
        
        DATA_HORA=$(date +"%d-%m-%Y %H:%M:%S")
        MENSAGEM_BASE="[$DATA_HORA] Alteração! $ARQUIVOS_ANTERIORES->$ARQUIVOS_ATUAIS."
        
        # 7. Identifica as diferenças (arquivos removidos/adicionados/alterados)
        # Usa 'comm' para comparar os estados ordenados
        
        # Cria arquivos temporários para a comparação
        TEMP_ANTERIOR=$(mktemp)
        TEMP_ATUAL=$(mktemp)
        echo "$ESTADO_ANTERIOR" > "$TEMP_ANTERIOR"
        echo "$ESTADO_ATUAL" > "$TEMP_ATUAL"
        
        # comm -12: Arquivos inalterados (em ambos)
        # comm -13: Arquivos adicionados/novos (somente na lista atual)
        ADICIONADOS=$(comm -13 "$TEMP_ANTERIOR" "$TEMP_ATUAL" | tr '\n' ' ')
        # comm -23: Arquivos removidos (somente na lista anterior)
        REMOVIDOS=$(comm -23 "$TEMP_ANTERIOR" "$TEMP_ATUAL" | tr '\n' ' ')
        
        # Limpa arquivos temporários
        rm "$TEMP_ANTERIOR" "$TEMP_ATUAL"
        
        # Verifica se houve ADIÇÃO/REMOÇÃO/ALTERAÇÃO (alteração de conteúdo não é capturada aqui, 
        # o script foca em ADIÇÃO/REMOÇÃO e reaparecimento de nome)
        
        DETALHE=""
        
        if [ -n "$REMOVIDOS" ]; then
            DETALHE="Removidos: $REMOVIDOS"
        fi
        
        if [ -n "$ADICIONADOS" ]; then
            if [ -n "$DETALHE" ]; then
                DETALHE="$DETALHE Adicionados: $ADICIONADOS"
            else
                DETALHE="Adicionados: $ADICIONADOS"
            fi
        fi
        
        # Para simplificar, "alterados" será representado pela combinação de removidos e adicionados,
        # ou se o número de arquivos for o mesmo mas a lista de nomes mudou.
        # No exemplo, 'Removidos: notas.txt' e 'Adicionados: a.txt, b.txt' já cobrem o solicitado.
        
        MENSAGEM_FINAL="$MENSAGEM_BASE $DETALHE"
        
        # 8. Exibe a mensagem e registra no log
        echo "$MENSAGEM_FINAL"
        echo "$MENSAGEM_FINAL" >> "$LOG_FILE"

        # 9. Atualiza o estado anterior
        ESTADO_ANTERIOR="$ESTADO_ATUAL"
        ARQUIVOS_ANTERIORES="$ARQUIVOS_ATUAIS"
    fi
    
    # 10. Espera o intervalo de tempo
    sleep "$INTERVALO"
    
done