# Ação Principal
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
        printf "%s %.1fms\n", ip, latencias[ip] | "sort -k2n"
    }
    
    # o 'sort' garante a ordenação final da saída.
}