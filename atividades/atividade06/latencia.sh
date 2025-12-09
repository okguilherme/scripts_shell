#!/bin/bash

# Verifica se foi passado o nome do arquivo
if [ -z "$1" ]; then
    echo "Uso: $0 <arquivo_com_ips.txt>"
    exit 1
fi

arquivo="$1"

# Verifica se o arquivo existe
if [ ! -f "$arquivo" ]; then
    echo "Erro: arquivo '$arquivo' não encontrado."
    exit 1
fi

echo "Calculando latência média de cada IP (10 pacotes ICMP)..."
echo "----------------------------------------------------------"

# Arquivo temporário para armazenar os resultados
temp=$(mktemp)

# Loop para cada IP do arquivo
while read -r ip; do
    # Ignora linhas vazias
    [ -z "$ip" ] && continue

    echo "Pingando $ip..."
    
    # Executa o ping e extrai o tempo médio (avg) sem usar awk
    media=$(ping -c 10 "$ip" 2>/dev/null | grep "rtt" | cut -d'/' -f5)

    # Se o ping falhar (sem resposta)
    if [ -z "$media" ]; then
        media="N/A"
    fi

    echo "$ip $media" >> "$temp"
done < "$arquivo"

echo
echo "Resultados (ordenados por tempo de resposta):"
echo "---------------------------------------------"

# Filtra apenas linhas com número, ordena numericamente e depois mostra as que falharam
grep -v "N/A" "$temp" | sort -k2 -n
grep "N/A" "$temp"

# Remove o arquivo temporário
rm -f "$temp"
