.PHONY: all run test

all: 	
	@clear
	@lex lexica.l
	@yacc -d sintatica.y

run: all
	@g++ -o compilador y.tab.c src/*.cpp -ll -lm
	@./compilador < entrada.L--

test:
	@reset
	@rm -f test
	@./compilador < entrada.L-- debug.cpp | tee test.cpp
	@g++ test.cpp -o test -lm
	@echo "\nExecutando o codigo intermediario\n"
	@./test
