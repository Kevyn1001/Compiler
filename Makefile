# Caminhos
SRC_DIR = src
PARSER_DIR = parser

# Arquivos fonte
LEX_FILE = $(PARSER_DIR)/lexer.l
YACC_FILE = $(PARSER_DIR)/parser.y
MAIN_FILE = $(SRC_DIR)/main.c

# Arquivos gerados
LEX_GEN = $(PARSER_DIR)/lex.yy.c
YACC_GEN_C = $(PARSER_DIR)/parser.tab.c
YACC_GEN_H = $(PARSER_DIR)/parser.tab.h

# Nome do executável e auxiliares
EXEC = compilador
GENERATED_C = gerado.c
TEST_PROGRAM = programa

.PHONY: all test clean

# Regra padrão
all: $(EXEC)

# Geração de parser com Bison
$(YACC_GEN_C) $(YACC_GEN_H): $(YACC_FILE)
	bison -d -o $(YACC_GEN_C) $(YACC_FILE)

# Geração de lexer com Flex
$(LEX_GEN): $(LEX_FILE)
	flex -o $(LEX_GEN) $(LEX_FILE)

# Compilação do executável principal
$(EXEC): $(MAIN_FILE) $(YACC_GEN_C) $(LEX_GEN)
	gcc -o $(EXEC) $(MAIN_FILE) $(YACC_GEN_C) $(LEX_GEN)

# Alvo de teste: imprime o código intermediário, gera gerado.c, compila e executa
test: $(EXEC)
	@echo "=== Código intermediário gerado pelo compilador ==="
	./$(EXEC) tests/testes.txt
	@echo
	@echo "=== Salvando em $(GENERATED_C) ==="
	./$(EXEC) tests/testes.txt > $(GENERATED_C)
	@echo "=== Compilando $(GENERATED_C) ==="
	gcc -o $(TEST_PROGRAM) $(GENERATED_C)
	@echo "=== Executando $(TEST_PROGRAM) ==="
	./$(TEST_PROGRAM)

# Limpeza dos artefatos gerados
clean:
	rm -f $(EXEC) $(LEX_GEN) $(YACC_GEN_C) $(YACC_GEN_H) $(GENERATED_C) $(TEST_PROGRAM)
