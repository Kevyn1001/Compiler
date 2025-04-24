%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define INT 0
#define FLOAT 1

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
    return tipo == FLOAT ? "float" : "int";
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

%token <label> TK_ID TK_NUM TK_REAL
%token TK_TIPO_INT TK_TIPO_FLOAT

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
        int tipoRes = $1.tipo;
        char* t = novaTemp(tipoRes);
        char* tr = malloc(1000);
        sprintf(tr, "%s%s%s = %s + %s;\n",
                $1.traducao, $3.traducao, t, $1.label, $3.label);
        $$.label = t;
        $$.traducao = tr;
        $$.tipo = tipoRes;
    }
  | expr '*' expr {
        int tipoRes = $1.tipo;
        char* t = novaTemp(tipoRes);
        char* tr = malloc(1000);
        sprintf(tr, "%s%s%s = %s * %s;\n",
                $1.traducao, $3.traducao, t, $1.label, $3.label);
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
;

%%
