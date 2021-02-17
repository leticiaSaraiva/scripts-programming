gsub(/\/home\/alunos/, "/srv/students")1 {
	print > "passwd.new"
}
