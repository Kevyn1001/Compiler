all: 	
	@clear
	@lex lexica.l
	@yacc -d sintatica.y

run: all
	@g++ -o glf y.tab.c src/*.cpp -ll
	@./glf < entrada.L--

test:
	@reset
	@./glf < entrada.L-- debug.cpp | tee test.cpp
	@g++ test.cpp -o test
	@echo "\nExecutando o codigo intermediario\n"
	@./test