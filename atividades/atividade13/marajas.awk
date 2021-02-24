BEGIN{
	
}
NR != 1{
	nome = $(NF - 2)
	valor = $NF  
	if (valor > cursos[$(NF - 1)]){
		cursos[$(NF - 1)] = valor 
		nomes[$(NF - 1)] =  nome
	}
}
END{
	for (curso in cursos){
		print curso": ", nomes[curso]", ", cursos[curso] | "sort"
	}
}
