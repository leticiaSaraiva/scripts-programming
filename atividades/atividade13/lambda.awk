# OK
BEGIN{
	FS=" "
}
{	
	if ($5 == "Task"){
		invoc_falha = invoc_falha + 1
	}
	
	if ($3 == "START"){
		invoc_sucesso = invoc_sucesso + 1
	}
	
	invocacoes = invoc_falha + invoc_sucesso
	
	if ($6 == "Duration:"){
		duracao_total = duracao_total + $7
	}
	tempo_medio = duracao_total / invoc_sucesso
}
END{
	printf "RELATÓRIO \n"
	printf "Total de invocações: %d \n", invocacoes
	printf "Invocações com sucesso: %d \n", invoc_sucesso
	printf "Invocações com falha: %d \n", invoc_falha
	printf "Tempo médio das invocações com sucesso: %.2f ms \n", tempo_medio
}
