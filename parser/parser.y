%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

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
%right TK_NOT
%left TK_AND
%left TK_OR
%left TK_EQ TK_NE TK_LT TK_LE TK_GT TK_GE
%left '+' '-'
%left '*' '/'
%type <atr> expr linha comandos bloco

%%

bloco:
    comandos {
        printf("%s", declaracoes);
        for (int i = 0; i < qtdSimbolos; i++) {
            printf("%s %s;\n", tipoToStr(tabela[i].tipo), tabela[i].nome);
        }
        printf("%s\n", $1.traducao);
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
    int tipoRes;
    char* t1 = $1.label;
    char* t2 = $3.label;
    char* tr = malloc(1000);

    if ($1.tipo == INT && $3.tipo == FLOAT) {
        tipoRes = FLOAT;
        char* convertido = novaTemp(FLOAT);
        sprintf(tr, "%s%s%s = (float) %s;\n", $1.traducao, $3.traducao, convertido, t1);
        t1 = convertido;
    } else if ($1.tipo == FLOAT && $3.tipo == INT) {
        tipoRes = FLOAT;
        char* convertido = novaTemp(FLOAT);
        sprintf(tr, "%s%s%s = (float) %s;\n", $1.traducao, $3.traducao, convertido, t2);
        t2 = convertido;
    } else {
        tipoRes = $1.tipo;
        sprintf(tr, "%s%s", $1.traducao, $3.traducao);
    }

    char* t = novaTemp(tipoRes);
    sprintf(tr + strlen(tr), "%s = %s + %s;\n", t, t1, t2);
    
    $$.label = t;
    $$.traducao = tr;
    $$.tipo = tipoRes;
    }
  | expr '-' expr {
    int tipoRes;
    char* t1 = $1.label;
    char* t2 = $3.label;
    char* tr = malloc(1000);

    if ($1.tipo == INT && $3.tipo == FLOAT) {
        tipoRes = FLOAT;
        char* convertido = novaTemp(FLOAT);
        sprintf(tr, "%s%s%s = (float) %s;\n", $1.traducao, $3.traducao, convertido, t1);
        t1 = convertido;
    } else if ($1.tipo == FLOAT && $3.tipo == INT) {
        tipoRes = FLOAT;
        char* convertido = novaTemp(FLOAT);
        sprintf(tr, "%s%s%s = (float) %s;\n", $1.traducao, $3.traducao, convertido, t2);
        t2 = convertido;
    } else {
        tipoRes = $1.tipo;
        sprintf(tr, "%s%s", $1.traducao, $3.traducao);
    }

    char* t = novaTemp(tipoRes);
    sprintf(tr + strlen(tr), "%s = %s - %s;\n", t, t1, t2);

    $$.label = t;
    $$.traducao = tr;
    $$.tipo = tipoRes;
    }
  | expr '*' expr {
    int tipoRes;
    char* t1 = $1.label;
    char* t2 = $3.label;
    char* tr = malloc(1000);

    if ($1.tipo == INT && $3.tipo == FLOAT) {
        tipoRes = FLOAT;
        char* convertido = novaTemp(FLOAT);
        sprintf(tr, "%s%s%s = (float) %s;\n", $1.traducao, $3.traducao, convertido, t1);
        t1 = convertido;
    } else if ($1.tipo == FLOAT && $3.tipo == INT) {
        tipoRes = FLOAT;
        char* convertido = novaTemp(FLOAT);
        sprintf(tr, "%s%s%s = (float) %s;\n", $1.traducao, $3.traducao, convertido, t2);
        t2 = convertido;
    } else {
        tipoRes = $1.tipo;
        sprintf(tr, "%s%s", $1.traducao, $3.traducao);
    }

    char* t = novaTemp(tipoRes);
    sprintf(tr + strlen(tr), "%s = %s * %s;\n", t, t1, t2);
    
    $$.label = t;
    $$.traducao = tr;
    $$.tipo = tipoRes;
    }
  | expr '/' expr {
    int tipoRes;
    char* t1 = $1.label;
    char* t2 = $3.label;
    char* tr = malloc(1000);

    if ($1.tipo == INT && $3.tipo == FLOAT) {
        tipoRes = FLOAT;
        char* convertido = novaTemp(FLOAT);
        sprintf(tr, "%s%s%s = (float) %s;\n", $1.traducao, $3.traducao, convertido, t1);
        t1 = convertido;
    } else if ($1.tipo == FLOAT && $3.tipo == INT) {
        tipoRes = FLOAT;
        char* convertido = novaTemp(FLOAT);
        sprintf(tr, "%s%s%s = (float) %s;\n", $1.traducao, $3.traducao, convertido, t2);
        t2 = convertido;
    } else {
        tipoRes = $1.tipo;
        sprintf(tr, "%s%s", $1.traducao, $3.traducao);
    }

    char* t = novaTemp(tipoRes);
    sprintf(tr + strlen(tr), "%s = %s / %s;\n", t, t1, t2);

    $$.label = t;
    $$.traducao = tr;
    $$.tipo = tipoRes;
    }
  | TK_ID '=' expr {
        int idx = buscarSimbolo($1);
        int tipoVar = (idx != -1) ? tabela[idx].tipo : INT;
        char* tr = malloc(500);
        sprintf(tr, "%s%s = %s;\n", $3.traducao, $1, $3.label);
        $$.label = $1;
        $$.traducao = tr;
        $$.tipo = tipoVar;
    }
  | '(' expr ')' {
        $$.label = $2.label;
        $$.traducao = $2.traducao;
        $$.tipo = $2.tipo;
    }
  | expr TK_EQ expr {
        char* t = novaTemp(BOOL);
        char* tr = malloc(1000);
        sprintf(tr, "%s%s%s = %s == %s;\n", $1.traducao, $3.traducao, t, $1.label, $3.label);
        $$.label = t;
        $$.traducao = tr;
        $$.tipo = BOOL;
    }
  | expr TK_NE expr {
        char* t = novaTemp(BOOL);
        char* tr = malloc(1000);
        sprintf(tr, "%s%s%s = %s != %s;\n", $1.traducao, $3.traducao, t, $1.label, $3.label);
        $$.label = t;
        $$.traducao = tr;
        $$.tipo = BOOL;
    }
  | expr TK_LT expr {
        char* t = novaTemp(BOOL);
        char* tr = malloc(1000);
        sprintf(tr, "%s%s%s = %s < %s;\n", $1.traducao, $3.traducao, t, $1.label, $3.label);
        $$.label = t;
        $$.traducao = tr;
        $$.tipo = BOOL;
    }
  | expr TK_GT expr {
        char* t = novaTemp(BOOL);
        char* tr = malloc(1000);
        sprintf(tr, "%s%s%s = %s > %s;\n", $1.traducao, $3.traducao, t, $1.label, $3.label);
        $$.label = t;
        $$.traducao = tr;
        $$.tipo = BOOL;
    }
  | expr TK_LE expr {
        char* t = novaTemp(BOOL);
        char* tr = malloc(1000);
        sprintf(tr, "%s%s%s = %s <= %s;\n", $1.traducao, $3.traducao, t, $1.label, $3.label);
        $$.label = t;
        $$.traducao = tr;
        $$.tipo = BOOL;
    }
  | expr TK_GE expr {
        char* t = novaTemp(BOOL);
        char* tr = malloc(1000);
        sprintf(tr, "%s%s%s = %s >= %s;\n", $1.traducao, $3.traducao, t, $1.label, $3.label);
        $$.label = t;
        $$.traducao = tr;
        $$.tipo = BOOL;
    }
  | expr TK_AND expr {
      char* t = novaTemp(BOOL);
      char* tr = malloc(1000);
      sprintf(tr, "%s%s%s = %s && %s;\n", $1.traducao, $3.traducao, t, $1.label, $3.label);
      $$.label = t;
      $$.traducao = tr;
      $$.tipo = BOOL;
    }
  | expr TK_OR expr {
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
  | '(' TK_TIPO_INT ')' expr {
      char* t = novaTemp(INT);
      char* tr = malloc(1000);
      sprintf(tr, "%s%s = (int) %s;\n", $4.traducao, t, $4.label);
      $$.label = t;
      $$.traducao = tr;
      $$.tipo = INT;
    }
  | '(' TK_TIPO_FLOAT ')' expr {
        char* t = novaTemp(FLOAT);
        char* tr = malloc(1000);
        sprintf(tr, "%s%s = (float) %s;\n", $4.traducao, t, $4.label);
        $$.label = t;
        $$.traducao = tr;
        $$.tipo = FLOAT;
    }
  | '(' TK_TIPO_CHAR ')' expr {
        char* t = novaTemp(CHAR);
        char* tr = malloc(1000);
        sprintf(tr, "%s%s = (char) %s;\n", $4.traducao, t, $4.label);
        $$.label = t;
        $$.traducao = tr;
        $$.tipo = CHAR;
    }
  | '(' TK_TIPO_BOOL ')' expr {
    char* t = novaTemp(BOOL);
      char* tr = malloc(1000);
        sprintf(tr, "%s%s = (int) %s;\n", $4.traducao, t, $4.label); // cast lógico para int
        $$.label = t;
        $$.traducao = tr;
        $$.tipo = BOOL;
    }
;

%%
