# Ação Principal 
NR > 1 {
    # $1 = Produto, $2 = PrecoUnitario, $3 = Quantidade
    
    # 1. Cálculo por Linha
    valor_total = $2 * $3
    
    # 2. Filtragem
    if (valor_total >= 200) {
        # 3. Formatação
        print $1 ": " valor_total
    }
}