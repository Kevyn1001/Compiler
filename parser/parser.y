%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "parser.tab.h"

#define INT 0
#define FLOAT 1
#define CHAR 2
#define BOOL 3

int tempCounter = 1;
char declaracoes[10000] = "";

typedef struct {
    char nome[50];
    int tipo;
} Simbolo;

Simbolo tabela[100];
int qtdSimbolos = 0;

int buscarSimbolo(const char* nome) {
    for (int i = 0; i < qtdSimbolos; i++) {
        if (strcmp(tabela[i].nome, nome) == 0) return i;
    }
    return -1;
}

int tiposCompativeis(int tipo1, int tipo2, int operador) {

    // Regras para Operadores Aritméticos (+, -, *, /)
    if (operador == '+' || operador == '-' || operador == '*' || operador == '/') {

        // Rejeita qualquer operação com booleano
        if (tipo1 == BOOL || tipo2 == BOOL)
            return 0;

        // Se qualquer um dos tipos for float, a operação é válida (com promoção)
        if (tipo1 == FLOAT || tipo2 == FLOAT)
            return 1;
        
        // Se chegar aqui, os tipos restantes são INT ou CHAR.
        // Qualquer combinação entre eles é válida.
        if ((tipo1 == INT || tipo1 == CHAR) && (tipo2 == INT || tipo2 == CHAR))
            return 1;
    }

    // Regras para Operadores Relacionais (==, !=, <, etc.)
    if (operador == TK_EQ || operador == TK_NE || operador == TK_LT || operador == TK_LE
        || operador == TK_GT || operador == TK_GE) {
        
        // Permite misturar tipos numéricos (int, float, char)
        if ((tipo1 == INT || tipo1 == FLOAT || tipo1 == CHAR) &&
            (tipo2 == INT || tipo2 == FLOAT || tipo2 == CHAR))
            return 1;

        // Permite comparar bool com bool
        if (tipo1 == BOOL && tipo2 == BOOL)
            return 1;
    }

    // Regras para Operadores Lógicos (&&, ||, !)
    if (operador == TK_AND || operador == TK_OR || operador == TK_NOT) {
        if (tipo1 == BOOL && tipo2 == BOOL)
            return 1;
    }

    // Se nenhuma regra permitiu, a operação é incompatível.
    return 0;
}

void declararVariavel(const char* nome, int tipo) {
    if (buscarSimbolo(nome) == -1) {
        strcpy(tabela[qtdSimbolos].nome, nome);
        tabela[qtdSimbolos++].tipo = tipo;
    }
}

char* tipoToStr(int tipo) {
    switch(tipo){
      case 0:
        return "int";
      case 1:
        return "float";
      case 2:
        return "char";
      case 3:
        return "int";
    }
}

char* novaTemp(int tipo) {
    char* t = malloc(10);
    sprintf(t, "T%d", tempCounter++);
    char decl[30];
    sprintf(decl, "%s %s;\n", tipoToStr(tipo), t);
    strcat(declaracoes, decl);
    return t;
}

int yylex(void);
void yyerror(const char *s) { fprintf(stderr, "Erro: %s\n", s); }
%}

%union {
    char* label;
    struct {
        char* label;
        char* traducao;
        int tipo;
    } atr;
}

%token <label> TK_ID TK_NUM TK_REAL TK_CHAR TK_BOOL TK_EQ TK_NE TK_LE TK_GE TK_LT TK_GT
%token TK_TIPO_INT TK_TIPO_FLOAT TK_TIPO_CHAR TK_TIPO_BOOL TK_AND TK_OR TK_NOT
%left TK_OR
%left TK_AND
%right TK_NOT
%left TK_EQ TK_NE TK_LT TK_LE TK_GT TK_GE
%left '+' '-'
%left '*' '/'
%type <atr> expr linha comandos bloco

%%

bloco:
     comandos {
        printf("#include <stdio.h>\n\n");
        printf("int main() {\n");

        printf("%s", declaracoes);

        for (int i = 0; i < qtdSimbolos; i++) {
            printf("    %s %s;\n", tipoToStr(tabela[i].tipo), tabela[i].nome);
        }

        char* linha = strtok($1.traducao, "\n");
        while (linha != NULL) {
            printf("    %s\n", linha);
            linha = strtok(NULL, "\n");
        }

        printf("    return 0;\n");
        printf("}\n");
    }
;

comandos:
    comandos linha {
        char* all = malloc(10000);
        sprintf(all, "%s%s", $1.traducao, $2.traducao);
        $$.traducao = all;
    }
  | linha {
        $$.traducao = $1.traducao;
    }
;

linha:
    expr ';' {
        $$.label = $1.label;
        $$.traducao = $1.traducao;
    }
  | TK_TIPO_INT TK_ID ';' {
        declararVariavel($2, INT);
        $$.traducao = strdup("");
    }
  | TK_TIPO_FLOAT TK_ID ';' {
        declararVariavel($2, FLOAT);
        $$.traducao = strdup("");
    }
  | TK_TIPO_CHAR TK_ID ';' {
        declararVariavel($2, CHAR);
        $$.traducao = strdup("");
    }
  | TK_TIPO_BOOL TK_ID ';' {
        declararVariavel($2, BOOL);
        $$.traducao = strdup("");
    }
;

expr:
    TK_NUM {
        char* t = novaTemp(INT);
        char* tr = malloc(100);
        sprintf(tr, "%s = %s;\n", t, $1);
        $$.label = t;
        $$.traducao = tr;
        $$.tipo = INT;
    }
  | TK_REAL {
        char* t = novaTemp(FLOAT);
        char* tr = malloc(100);
        sprintf(tr, "%s = %s;\n", t, $1);
        $$.label = t;
        $$.traducao = tr;
        $$.tipo = FLOAT;
    }
  | TK_CHAR {
        char* t = novaTemp(CHAR);
        char* tr = malloc(100);
        sprintf(tr, "%s = %s;\n", t, $1);
        $$.label = t;
        $$.traducao = tr;
        $$.tipo = CHAR;
      }
  | TK_BOOL {
        char* t = novaTemp(BOOL);
        char* tr = malloc(100);
        ($1 && strcmp($1, "true") == 0)?sprintf(tr, "%s = 1;\n", t):sprintf(tr, "%s = 0;\n", t);
        $$.label = t;
        $$.traducao = tr;
        $$.tipo = BOOL;
    }
  | TK_ID {
        int idx = buscarSimbolo($1);
        int tipo = (idx != -1) ? tabela[idx].tipo : INT;
        char* t = novaTemp(tipo);
        char* tr = malloc(100);
        sprintf(tr, "%s = %s;\n", t, $1);
        $$.label = t;
        $$.traducao = tr;
        $$.tipo = tipo;
    }
  | expr '+' expr {
    if (!tiposCompativeis($1.tipo, $3.tipo, '+')) {
        yyerror("Tipos incompatíveis para operação +");
        YYERROR;
    }

    int tipoRes;
    char* t1 = $1.label;
    char* t2 = $3.label;
    char* traducao_extra = malloc(512); // Para guardar casts, se necessário
    traducao_extra[0] = '\0';

    // 1. Define o tipo do resultado
    if ($1.tipo == FLOAT || $3.tipo == FLOAT) {
        tipoRes = FLOAT;
    } else { // int+int, int+char, char+char -> resultado é int
        tipoRes = INT;
    }

    // 2. Se o resultado for float, converte quem não for
    if (tipoRes == FLOAT) {
        if ($1.tipo != FLOAT) {
            char* c = novaTemp(FLOAT);
            sprintf(traducao_extra + strlen(traducao_extra), "    %s = (float)%s;\n", c, t1);
            t1 = c; // t1 agora aponta para a nova temporária
        }
        if ($3.tipo != FLOAT) {
            char* c = novaTemp(FLOAT);
            sprintf(traducao_extra + strlen(traducao_extra), "    %s = (float)%s;\n", c, t2);
            t2 = c; // t2 agora aponta para a nova temporária
        }
    }
    // Não é preciso cast para int+char, pois a promoção é implícita em C

    // 3. Gera o código final
    char* t_res = novaTemp(tipoRes);
    char* tr = malloc(2048);
    sprintf(tr, "%s%s%s    %s = %s + %s;\n", $1.traducao, $3.traducao, traducao_extra, t_res, t1, t2);

    $$.label = t_res;
    $$.traducao = tr;
    $$.tipo = tipoRes;
    
    // Libera a memória que não será mais usada
    free(traducao_extra);
}
  | expr '-' expr {
    if (!tiposCompativeis($1.tipo, $3.tipo, '-')) {
        yyerror("Tipos incompatíveis para operação -");
        YYERROR;
    }

    int tipoRes;
    char* t1 = $1.label;
    char* t2 = $3.label;
    char* traducao_extra = malloc(512); // Para guardar casts, se necessário
    traducao_extra[0] = '\0';           // Inicia como string vazia

    // 1. Define o tipo do resultado
    if ($1.tipo == FLOAT || $3.tipo == FLOAT) {
        tipoRes = FLOAT;
    } else { // int+int, int+char, char+char -> resultado é int
        tipoRes = INT;
    }

    // 2. Se o resultado for float, converte quem não for
    if (tipoRes == FLOAT) {
        if ($1.tipo != FLOAT) {
            char* c = novaTemp(FLOAT);
            sprintf(traducao_extra + strlen(traducao_extra), "    %s = (float)%s;\n", c, t1);
            t1 = c; // t1 agora aponta para a nova temporária
        }
        if ($3.tipo != FLOAT) {
            char* c = novaTemp(FLOAT);
            sprintf(traducao_extra + strlen(traducao_extra), "    %s = (float)%s;\n", c, t2);
            t2 = c; // t2 agora aponta para a nova temporária
        }
    }

    // 3. Gera o código final
    char* t_res = novaTemp(tipoRes);
    char* tr = malloc(2048);
    sprintf(tr, "%s%s%s    %s = %s - %s;\n", $1.traducao, $3.traducao, traducao_extra, t_res, t1, t2);

    $$.label = t_res;
    $$.traducao = tr;
    $$.tipo = tipoRes;
    
    free(traducao_extra);
}
  | expr '*' expr {
    if (!tiposCompativeis($1.tipo, $3.tipo, '*')) {
        yyerror("Tipos incompatíveis para operação *");
        YYERROR;
    }

    int tipoRes;
    char* t1 = $1.label;
    char* t2 = $3.label;
    char* traducao_extra = malloc(512);
    traducao_extra[0] = '\0';

    if ($1.tipo == FLOAT || $3.tipo == FLOAT) {
        tipoRes = FLOAT;
    } else {
        tipoRes = INT;
    }

    if (tipoRes == FLOAT) {
        if ($1.tipo != FLOAT) {
            char* c = novaTemp(FLOAT);
            sprintf(traducao_extra + strlen(traducao_extra), "    %s = (float)%s;\n", c, t1);
            t1 = c;
        }
        if ($3.tipo != FLOAT) {
            char* c = novaTemp(FLOAT);
            sprintf(traducao_extra + strlen(traducao_extra), "    %s = (float)%s;\n", c, t2);
            t2 = c;
        }
    }

    char* t_res = novaTemp(tipoRes);
    char* tr = malloc(2048);
    sprintf(tr, "%s%s%s    %s = %s * %s;\n", $1.traducao, $3.traducao, traducao_extra, t_res, t1, t2);

    $$.label = t_res;
    $$.traducao = tr;
    $$.tipo = tipoRes;

    free(traducao_extra);
}
  | expr '/' expr {
    if (!tiposCompativeis($1.tipo, $3.tipo, '/')) {
        yyerror("Tipos incompatíveis para operação /");
        YYERROR;
    }

    int tipoRes;
    char* t1 = $1.label;
    char* t2 = $3.label;
    char* traducao_extra = malloc(512);
    traducao_extra[0] = '\0';

    if ($1.tipo == FLOAT || $3.tipo == FLOAT) {
        tipoRes = FLOAT;
    } else {
        tipoRes = INT;
    }

    if (tipoRes == FLOAT) {
        if ($1.tipo != FLOAT) {
            char* c = novaTemp(FLOAT);
            sprintf(traducao_extra + strlen(traducao_extra), "    %s = (float)%s;\n", c, t1);
            t1 = c;
        }
        if ($3.tipo != FLOAT) {
            char* c = novaTemp(FLOAT);
            sprintf(traducao_extra + strlen(traducao_extra), "    %s = (float)%s;\n", c, t2);
            t2 = c;
        }
    }

    char* t_res = novaTemp(tipoRes);
    char* tr = malloc(2048);
    sprintf(tr, "%s%s%s    %s = %s / %s;\n", $1.traducao, $3.traducao, traducao_extra, t_res, t1, t2);

    $$.label = t_res;
    $$.traducao = tr;
    $$.tipo = tipoRes;

    free(traducao_extra);
}
  | TK_ID '=' expr {
    int idx = buscarSimbolo($1);
    if (idx == -1) {
        char* error_msg = (char*) malloc(strlen($1) + 25);
        sprintf(error_msg, "Variável '%s' não declarada", $1);
        yyerror(error_msg);
        free(error_msg);
        YYERROR;
    }

    int tipoVar = tabela[idx].tipo; // Tipo da variável à esquerda (ex: I -> INT)
    int tipoExpr = $3.tipo;         // Tipo da expressão à direita (ex: F -> FLOAT)
    char* labelExpr = $3.label;     // Label da expressão (ex: T1)
    char* traducaoExpr = $3.traducao; // Tradução da expressão
    char* tr;

    if (tipoVar == tipoExpr) {
        tr = malloc(strlen(traducaoExpr) + strlen($1) + strlen(labelExpr) + 10);
        sprintf(tr, "%s%s = %s;\n", traducaoExpr, $1, labelExpr);
    } else if (tipoVar == INT && tipoExpr == FLOAT) {
        char* t_cast = novaTemp(INT); // Nova temporária para guardar o resultado do cast
        tr = malloc(strlen(traducaoExpr) + strlen(t_cast) + strlen(labelExpr) + strlen($1) + 30);
        sprintf(tr, "%s%s = (int) %s;\n%s = %s;\n", traducaoExpr, t_cast, labelExpr, $1, t_cast);
    } else if (tipoVar == FLOAT && tipoExpr == INT) {
        char* t_cast = novaTemp(FLOAT);
        tr = malloc(strlen(traducaoExpr) + strlen(t_cast) + strlen(labelExpr) + strlen($1) + 30);
        sprintf(tr, "%s%s = (float) %s;\n%s = %s;\n", traducaoExpr, t_cast, labelExpr, $1, t_cast);
    } else {
        yyerror("Tipos incompatíveis para atribuição");
        YYERROR;
    }

    $$.label = $1; 
    $$.traducao = tr;
    $$.tipo = tipoVar;

    free(traducaoExpr);
    free(labelExpr);
}
  | expr TK_EQ expr {
        if (!tiposCompativeis($1.tipo, $3.tipo, TK_EQ)) {
            yyerror("Tipos incompatíveis para operação ==");
            YYERROR;
        }

        char* t1 = $1.label;
        char* t2 = $3.label;
        char* t = novaTemp(BOOL);
        char* tr = malloc(1000);

        if ($1.tipo == INT && $3.tipo == FLOAT) {
            char* convertido = novaTemp(FLOAT);
            sprintf(tr, "%s%s%s = (float) %s;\n", $1.traducao, $3.traducao, convertido, t1);
            t1 = convertido;
            sprintf(tr + strlen(tr), "%s = %s == %s;\n", t, t1, $3.label);
        } else if ($1.tipo == FLOAT && $3.tipo == INT) {
            char* convertido = novaTemp(FLOAT);
            sprintf(tr, "%s%s%s = (float) %s;\n", $1.traducao, $3.traducao, convertido, t2);
            t2 = convertido;
            sprintf(tr + strlen(tr), "%s = %s == %s;\n", t, $1.label, t2);
        } else {
            sprintf(tr, "%s%s", $1.traducao, $3.traducao);
            sprintf(tr + strlen(tr), "%s = %s == %s;\n", t, $1.label, $3.label);
        }

        $$.label = t;
        $$.traducao = tr;
        $$.tipo = BOOL;
    }
  | expr TK_NE expr {
        if (!tiposCompativeis($1.tipo, $3.tipo, TK_NE)) {
            yyerror("Tipos incompatíveis para operação !=");
            YYERROR;
        }

        char* t = novaTemp(BOOL);
        char* tr = malloc(1000);

        char* t1 = $1.label;
        char* t2 = $3.label;

        if ($1.tipo == INT && $3.tipo == FLOAT) {
            char* convertido = novaTemp(FLOAT);
            sprintf(tr, "%s%s%s = (float) %s;\n", $1.traducao, $3.traducao, convertido, t1);
            t1 = convertido;
            sprintf(tr + strlen(tr), "%s = %s != %s;\n", t, t1, $3.label);
        } else if ($1.tipo == FLOAT && $3.tipo == INT) {
            char* convertido = novaTemp(FLOAT);
            sprintf(tr, "%s%s%s = (float) %s;\n", $1.traducao, $3.traducao, convertido, t2);
            t2 = convertido;
            sprintf(tr + strlen(tr), "%s = %s != %s;\n", t, $1.label, t2);
        } else {
            sprintf(tr, "%s%s", $1.traducao, $3.traducao);
            sprintf(tr + strlen(tr), "%s = %s != %s;\n", t, $1.label, $3.label);
        }

        $$.label = t;
        $$.traducao = tr;
        $$.tipo = BOOL;
    }
  | expr TK_LT expr {
        if (!tiposCompativeis($1.tipo, $3.tipo, TK_LT)) {
        yyerror("Tipos incompatíveis para operação <");
        YYERROR;
        }

        char* t1 = $1.label;
        char* t2 = $3.label;
        char* t = novaTemp(BOOL);
        char* tr = malloc(1000);

        if ($1.tipo == INT && $3.tipo == FLOAT) {
            char* convertido = novaTemp(FLOAT);
            sprintf(tr, "%s%s%s = (float) %s;\n", $1.traducao, $3.traducao, convertido, t1);
            t1 = convertido;
            sprintf(tr + strlen(tr), "%s = %s < %s;\n", t, t1, $3.label);
        } else if ($1.tipo == FLOAT && $3.tipo == INT) {
            char* convertido = novaTemp(FLOAT);
            sprintf(tr, "%s%s%s = (float) %s;\n", $1.traducao, $3.traducao, convertido, t2);
            t2 = convertido;
            sprintf(tr + strlen(tr), "%s = %s < %s;\n", t, $1.label, t2);
        } else if($1.tipo == $3.tipo){
            sprintf(tr, "%s%s", $1.traducao, $3.traducao);
            sprintf(tr + strlen(tr), "%s = %s < %s;\n", t, $1.label, $3.label);
        }

        $$.label = t;
        $$.traducao = tr;
        $$.tipo = BOOL;
    }
  | expr TK_GT expr {
        if (!tiposCompativeis($1.tipo, $3.tipo, TK_GT)) {
        yyerror("Tipos incompatíveis para operação >");
        YYERROR;
        }

        char* t1 = $1.label;
        char* t2 = $3.label;
        char* t = novaTemp(BOOL);
        char* tr = malloc(1000);

        if ($1.tipo == INT && $3.tipo == FLOAT) {
            char* convertido = novaTemp(FLOAT);
            sprintf(tr, "%s%s%s = (float) %s;\n", $1.traducao, $3.traducao, convertido, t1);
            t1 = convertido;
            sprintf(tr + strlen(tr), "%s = %s > %s;\n", t, t1, $3.label);
        } else if ($1.tipo == FLOAT && $3.tipo == INT) {
            char* convertido = novaTemp(FLOAT);
            sprintf(tr, "%s%s%s = (float) %s;\n", $1.traducao, $3.traducao, convertido, t2);
            t2 = convertido;
            sprintf(tr + strlen(tr), "%s = %s > %s;\n", t, $1.label, t2);
        } else if($1.tipo == $3.tipo){
            sprintf(tr, "%s%s", $1.traducao, $3.traducao);
            sprintf(tr + strlen(tr), "%s = %s > %s;\n", t, $1.label, $3.label);
        }

        $$.label = t;
        $$.traducao = tr;
        $$.tipo = BOOL;
    }
  | expr TK_LE expr {
        if (!tiposCompativeis($1.tipo, $3.tipo, TK_LE)) {
        yyerror("Tipos incompatíveis para operação <=");
        YYERROR;
        }

        char* t1 = $1.label;
        char* t2 = $3.label;
        char* t = novaTemp(BOOL);
        char* tr = malloc(1000);

        if ($1.tipo == INT && $3.tipo == FLOAT) {
            char* convertido = novaTemp(FLOAT);
            sprintf(tr, "%s%s%s = (float) %s;\n", $1.traducao, $3.traducao, convertido, t1);
            t1 = convertido;
            sprintf(tr + strlen(tr), "%s = %s <= %s;\n", t, t1, $3.label);
        } else if ($1.tipo == FLOAT && $3.tipo == INT) {
            char* convertido = novaTemp(FLOAT);
            sprintf(tr, "%s%s%s = (float) %s;\n", $1.traducao, $3.traducao, convertido, t2);
            t2 = convertido;
            sprintf(tr + strlen(tr), "%s = %s <= %s;\n", t, $1.label, t2);
        } else if($1.tipo == $3.tipo){
            sprintf(tr, "%s%s", $1.traducao, $3.traducao);
            sprintf(tr + strlen(tr), "%s = %s <= %s;\n", t, $1.label, $3.label);
        }

        $$.label = t;
        $$.traducao = tr;
        $$.tipo = BOOL;
    }
  | expr TK_GE expr {
        if (!tiposCompativeis($1.tipo, $3.tipo, TK_GE)) {
            yyerror("Tipos incompatíveis para operação >=");
            YYERROR;
        }

        char* t1 = $1.label;
        char* t2 = $3.label;
        char* t = novaTemp(BOOL);
        char* tr = malloc(1000);

        if ($1.tipo == INT && $3.tipo == FLOAT) {
            char* convertido = novaTemp(FLOAT);
            sprintf(tr, "%s%s%s = (float) %s;\n", $1.traducao, $3.traducao, convertido, t1);
            t1 = convertido;
            sprintf(tr + strlen(tr), "%s = %s >= %s;\n", t, t1, $3.label);
        } else if ($1.tipo == FLOAT && $3.tipo == INT) {
            char* convertido = novaTemp(FLOAT);
            sprintf(tr, "%s%s%s = (float) %s;\n", $1.traducao, $3.traducao, convertido, t2);
            t2 = convertido;
            sprintf(tr + strlen(tr), "%s = %s >= %s;\n", t, $1.label, t2);
        } else if ($1.tipo == $3.tipo){
            sprintf(tr, "%s%s", $1.traducao, $3.traducao);
            sprintf(tr + strlen(tr), "%s = %s >= %s;\n", t, $1.label, $3.label);
        }

        $$.label = t;
        $$.traducao = tr;
        $$.tipo = BOOL;
    }
  | expr TK_AND expr {
        if ($1.tipo != BOOL || $3.tipo != BOOL) {
        yyerror("Operador lógico '&&' só aceita operandos booleanos");
        YYERROR;
        }

        char* t = novaTemp(BOOL);
        char* tr = malloc(1000);

        sprintf(tr, "%s%s%s = %s && %s;\n", $1.traducao, $3.traducao, t, $1.label, $3.label);
        $$.label = t;
        $$.traducao = tr;
        $$.tipo = BOOL;
    }
  | expr TK_OR expr {
        if ($1.tipo != BOOL || $3.tipo != BOOL) {
            yyerror("Operador lógico '||' só aceita operandos booleanos");
            YYERROR;
        }

        char* t = novaTemp(BOOL);
        char* tr = malloc(1000);
        sprintf(tr, "%s%s%s = %s || %s;\n", $1.traducao, $3.traducao, t, $1.label, $3.label);
        $$.label = t;
        $$.traducao = tr;
        $$.tipo = BOOL;
    }
  | TK_NOT expr {
      char* t = novaTemp(BOOL);
      char* tr = malloc(1000);
      sprintf(tr, "%s%s = !%s;\n", $2.traducao, t, $2.label);
      $$.label = t;
      $$.traducao = tr;
      $$.tipo = BOOL;
    }
  | '(' TK_TIPO_INT ')' expr %prec TK_NOT {
      char* t = novaTemp(INT);
      char* tr = malloc(1000);
      sprintf(tr, "%s%s = (int) %s;\n", $4.traducao, t, $4.label);
      $$.label = t;
      $$.traducao = tr;
      $$.tipo = INT;
    }
  | '(' TK_TIPO_FLOAT ')' expr %prec TK_NOT {
        char* t = novaTemp(FLOAT);
        char* tr = malloc(1000);
        sprintf(tr, "%s%s = (float) %s;\n", $4.traducao, t, $4.label);
        $$.label = t;
        $$.traducao = tr;
        $$.tipo = FLOAT;
    }
  | '(' TK_TIPO_CHAR ')' expr %prec TK_NOT {
        char* t = novaTemp(CHAR);
        char* tr = malloc(1000);
        sprintf(tr, "%s%s = (char) %s;\n", $4.traducao, t, $4.label);
        $$.label = t;
        $$.traducao = tr;
        $$.tipo = CHAR;
    }
  | '(' TK_TIPO_BOOL ')' expr %prec TK_NOT {
    char* t = novaTemp(BOOL);
      char* tr = malloc(1000);
        sprintf(tr, "%s%s = (int) %s;\n", $4.traducao, t, $4.label); // cast lógico para int
        $$.label = t;
        $$.traducao = tr;
        $$.tipo = BOOL;
    } | '(' expr ')' {
        $$.label = $2.label;
        $$.traducao = $2.traducao;
        $$.tipo = $2.tipo;
    }
;

%%
