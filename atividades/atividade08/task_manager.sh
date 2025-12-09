#!/bin/bash

# Variáveis Globais
NOME_TAREFA=""
TEMPO_EXECUCAO=0
ARQUIVO_TEMP=""

# Função para Limpeza 
limpar() {
    echo -e "\nTarefa interrompida. Limpando..."

    # 1. Verifica se o arquivo temporário existe antes de tentar removê-lo
    if [ -n "$ARQUIVO_TEMP" ] && [ -f "$ARQUIVO_TEMP" ]; then
        rm -f "$ARQUIVO_TEMP"
        echo "O arquivo temporário $ARQUIVO_TEMP foi removido."
    fi

    # 2. Sai do script após a limpeza
    exit 1
}

# Configura o trap para o sinal (Ctrl+C)
# Quando o sinal for recebido, a função 'limpar' será executada.
trap 'limpar' SIGINT

# Função Principal da Tarefa
executar_tarefa() {
    local nome_tarefa=$1
    local tempo_execucao=$2

    # 1. Cria o nome do arquivo temporário
    ARQUIVO_TEMP="${nome_tarefa}.tmp"
    
    # 2. Cria o arquivo temporário (conteúdo opcional, mas o arquivo deve existir)
    touch "$ARQUIVO_TEMP"

    echo "Iniciando tarefa: $nome_tarefa (PID [$$])"

    # 3. Executa a tarefa (simulada com sleep)
    # Usa 'sleep' com o tempo fornecido
    sleep "$tempo_execucao"

    
    echo "Tarefa '$nome_tarefa' concluída com sucesso"

    # 5. Remove o arquivo temporário (somente em caso de sucesso)
    if [ -f "$ARQUIVO_TEMP" ]; then
        rm -f "$ARQUIVO_TEMP"
    fi
}

# Processamento de Opções (getopts)
while getopts "n:t:" opt; do
    case $opt in
        n)
            NOME_TAREFA=$OPTARG
            ;;
        t)
            TEMPO_EXECUCAO=$OPTARG
            ;;
        \?)
            # Caso de opção inválida
            echo "Uso: $0 -n <nome_da_tarefa> -t <tempo_em_segundos>" >&2
            exit 1
            ;;
    esac
done

# Validação e Execução

# 1. Validação de Opções Obrigatórias
if [ -z "$NOME_TAREFA" ] || [ -z "$TEMPO_EXECUCAO" ]; then
    echo "Erro: As opções -n (nome da tarefa) e -t (tempo de execução) são obrigatórias." >&2
    echo "Uso: $0 -n <nome_da_tarefa> -t <tempo_em_segundos>" >&2
    exit 1
fi

# 2. Validação do Tempo de Execução (máximo 15s)
if ! [[ "$TEMPO_EXECUCAO" =~ ^[0-9]+$ ]] || [ "$TEMPO_EXECUCAO" -le 0 ] || [ "$TEMPO_EXECUCAO" -gt 15 ]; then
    echo "Erro: O tempo de execução (-t) deve ser um número inteiro positivo entre 1 e 15." >&2
    exit 1
fi

# 3. Execução da Tarefa
executar_tarefa "$NOME_TAREFA" "$TEMPO_EXECUCAO"

# 4. Encerramento normal do script
exit 0