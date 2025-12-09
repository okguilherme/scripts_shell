#!/bin/bash

echo "Informe o arquivo:"
read NOME_ARQUIVO

if [ ! -f "$NOME_ARQUIVO" ]; then
    echo "Erro: Arquivo '$NOME_ARQUIVO' não encontrado."
    exit 1
fi

cat "$NOME_ARQUIVO" |
# 2. Usa 'sed' para substituir a pontuação (ponto e vírgula) por espaço.
sed 's/[.,;:]/ /g' |
# 3. Converte para minúsculas
tr '[:upper:]' '[:lower:]' |
# 4. Substitui todos os caracteres que NÃO SÃO letras minúsculas,
#    incluindo acentuadas, por salto de linha. 
tr -s ' ' '\n' | # Transforma cada espaço/múltiplos espaços em um único salto de linha.
grep -v '^$' |
sort |
uniq -c |
sort -rn |
while read COUNT WORD; do
    if [ ! -z "$WORD" ]; then
        echo "$WORD: $COUNT"
    fi
done