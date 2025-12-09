# Ação Principal 
NR > 1 {
    # $1 = Produto, $2 = PrecoUnitario, $3 = Quantidade
    
    # Cálculo por Linha
    valor_total = $2 * $3
    
    # Filtragem
    if (valor_total >= 200) {
        
        print $1 ": " valor_total
    }
}