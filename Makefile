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

# Nome do executável
EXEC = compilador

# Regra padrão
all: $(EXEC)

$(YACC_GEN_C) $(YACC_GEN_H): $(YACC_FILE)
	bison -d -o $(YACC_GEN_C) $(YACC_FILE)

$(LEX_GEN): $(LEX_FILE)
	flex -o $(LEX_GEN) $(LEX_FILE)

$(EXEC): $(MAIN_FILE) $(YACC_GEN_C) $(LEX_GEN)
	gcc -o $(EXEC) $(MAIN_FILE) $(YACC_GEN_C) $(LEX_GEN)

clean:
	rm -f $(EXEC) $(LEX_GEN) $(YACC_GEN_C) $(YACC_GEN_H)

test: $(EXEC)
	./$(EXEC) tests/testes.txt