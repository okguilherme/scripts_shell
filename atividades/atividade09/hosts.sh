#!/bin/bash

# Arquivo de persistência de dados.
DB_FILE="hosts.db"

# Variáveis globais para argumentos das opções.
ACTION=""
HOSTNAME=""
IP=""

# Garante que o arquivo de dados exista.
touch "$DB_FILE"

# Funções de Manipulação 

# Adiciona um novo mapeamento Hostname/IP.
add_entry() {
    # Verifica se os argumentos -a e -i foram fornecidos corretamente.
    if [ -z "$HOSTNAME" ] || [ -z "$IP" ]; then
        echo "Erro: A operação de Adicionar (-a -i) requer um hostname e um IP." >&2
        exit 1
    fi
    
    # Prevenção: verifica se o hostname ou IP já estão em uso.
    if grep -qE "^$HOSTNAME\s" "$DB_FILE"; then
        echo "Erro: Hostname '$HOSTNAME' já registrado." >&2
        return
    fi
    if grep -qE "\s$IP$" "$DB_FILE"; then
        echo "Erro: IP '$IP' já registrado." >&2
        return
    fi

    # Adiciona a entrada ao arquivo.
    echo "$HOSTNAME $IP" >> "$DB_FILE"
    echo "Registro adicionado: $HOSTNAME -> $IP"
}

# Remove uma entrada usando o Hostname como chave.
remove_entry() {
    if [ -z "$HOSTNAME" ]; then
        echo "Erro: A opção -d requer um hostname." >&2
        exit 1
    fi

    # Verifica se o hostname existe antes de tentar remover.
    if ! grep -qE "^$HOSTNAME\s" "$DB_FILE"; then
        echo "Aviso: Hostname '$HOSTNAME' não encontrado." >&2
        return
    fi

    # Deleta a linha que começa com o hostname.
    # O .bak é para compatibilidade, removido logo em seguida.
    sed -i.bak "/^$HOSTNAME\s/d" "$DB_FILE"
    rm -f "$DB_FILE.bak" 
    echo "Registro removido: $HOSTNAME"
}

# Exibe todo o conteúdo do arquivo de mapeamento.
list_entries() {
    if [ ! -s "$DB_FILE" ]; then
        echo "O banco de dados está vazio."
        return
    fi
    # Formata a saída em colunas para legibilidade.
    column -t "$DB_FILE"
}

# Procura o IP correspondente a um Hostname.
find_ip() {
    if [ -z "$HOSTNAME" ]; then
        # Este erro é tratado pela lógica principal se nenhum argumento for fornecido.
        return 1
    fi
    
    # Procura a linha com o hostname e isola o segundo campo (IP).
    IP_FOUND=$(grep -E "^$HOSTNAME\s" "$DB_FILE" | cut -d ' ' -f 2)

    if [ -n "$IP_FOUND" ]; then
        echo "$IP_FOUND"
    else
        echo "Erro: IP não encontrado para '$HOSTNAME'." >&2
        return 1
    fi
}

# Procura reversa: encontra o Hostname associado a um IP.
reverse_find_hostname() {
    if [ -z "$IP" ]; then
        echo "Erro: A Procura Reversa (-r) requer um IP." >&2
        exit 1
    fi

    # Procura a linha que termina com o IP e isola o primeiro campo (Hostname).
    HOSTNAME_FOUND=$(grep -E "\s$IP$" "$DB_FILE" | cut -d ' ' -f 1)
    
    if [ -n "$HOSTNAME_FOUND" ]; then
        echo "$HOSTNAME_FOUND"
    else
        echo "Erro: Hostname não encontrado para o IP '$IP'." >&2
        return 1
    fi
}

# ---------------- Processamento de Opções ----------------

# Uso de getopts em loop while.
while getopts "a:i:d:lr:" opt; do
    case "$opt" in
        a)
            ACTION="ADD"
            HOSTNAME="$OPTARG" 
            ;;
        i)
            # Opção -i é válida apenas se -a já tiver sido definida.
            if [ "$ACTION" != "ADD" ]; then
                echo "Erro: A opção -i (IP) deve seguir -a (Hostname)." >&2
                exit 1
            fi
            IP="$OPTARG" 
            ;;
        d)
            ACTION="REMOVE"
            HOSTNAME="$OPTARG" 
            ;;
        l)
            ACTION="LIST"
            ;;
        r)
            ACTION="REVERSE_FIND"
            IP="$OPTARG" 
            ;;
        \?|:)
            # getopts captura opções inválidas ou argumentos faltantes.
            echo "Erro de Sintaxe: Opção inválida ou argumento ausente. Consulte a documentação." >&2
            exit 1
            ;;
    esac
done

# Desloca os parâmetros posicionais para ignorar as opções já processadas.
shift "$((OPTIND-1))"

# ---------------- Execução Principal ----------------

if [ -n "$ACTION" ]; then
    # Executa a função baseada na opção getopts.
    case "$ACTION" in
        ADD)
            add_entry
            ;;
        REMOVE)
            remove_entry
            ;;
        LIST)
            list_entries
            ;;
        REVERSE_FIND)
            reverse_find_hostname
            ;;
    esac
elif [ "$#" -eq 1 ]; then
    # Se nenhuma opção foi usada, e há um argumento posicional, assume-se "Procurar IP por Hostname".
    HOSTNAME="$1"
    find_ip
else
    # Caso nenhuma operação válida seja fornecida.
    echo "Erro: Nenhuma operação válida (-a, -d, -l, -r) ou hostname de busca fornecido." >&2
    exit 1
fi

