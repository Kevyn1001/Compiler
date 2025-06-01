#include <stdio.h>

extern FILE *yyin;  /* Variável usada pelo Flex para indicar a fonte de entrada */
int yyparse();

int main(int argc, char **argv) {
    if (argc > 1) {
        yyin = fopen(argv[1], "r");
        if (!yyin) {
            perror("Erro ao abrir arquivo de testes");
            return 1;
        }
    }
    yyparse();
    return 0;
}
