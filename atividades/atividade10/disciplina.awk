BEGIN {
    print "Aluno: Situação: Média"
}

# Ação Principal 
NR > 1 {
    
    media = ($2 + $3 + $4) / 3

    # Situação do Aluno
    if (media >= 7.0) {
        situacao = "Aprovado"
    } else if (media >= 5.0 && media < 7.0) {
        situacao = "Final"
    } else {
        situacao = "Reprovado"
    }

    # Acumula as notas para o cálculo da média geral (END)
    soma_nota1 += $2
    soma_nota2 += $3
    soma_nota3 += $4
    
    # Imprime o relatório do aluno
    printf "%s: %s: %.1f\n", $1, situacao, media
}

# Média Geral das Provas
END {
    # O número de registros de alunos é (NR - 1), pois a primeira linha é o cabeçalho.
    num_alunos = NR - 1
    
    # Previne divisão por zero caso o arquivo esteja vazio.
    if (num_alunos > 0) {
        media_p1 = soma_nota1 / num_alunos
        media_p2 = soma_nota2 / num_alunos
        media_p3 = soma_nota3 / num_alunos
        
        printf "Média das Provas: %.1f %.1f %.1f\n", media_p1, media_p2, media_p3
    }
}