# Bloco de Ação Principal
{
    # 1. Armazenamento em Vetor: usa $1 (IP) como chave e $2 (Latência) como valor.
    # O AWK usa o ESPAÇO como separador padrão, então não é necessário usar -F.
    latencias[$1] = $2
}

# 2. Processamento Final (END)
END {
    # 3. Ordenação com Pipe: Redireciona a saída (print) para o comando 'sort -k2n'.
    # O | "comando" é a sintaxe do AWK para pipe externo.
    for (ip in latencias) {
        # 4. Formatação de Saída: Adiciona "ms" ao valor da latência.
        # Usa printf para garantir que a saída tenha dois campos para o sort.
        printf "%s %.1fms\n", ip, latencias[ip] | "sort -k2n"
    }
    
    # NOTA: O 'sort' é executado uma vez, recebendo todas as linhas.
    # A ordem em que o for itera sobre o array não é garantida,
    # mas o 'sort' garante a ordenação final da saída.
}