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
int labelCounter = 1;
int stateCounter = 0;
char declaracoes[10000] = "";

char* novaLabel() {
    char* l = malloc(16);
    sprintf(l, "L%d", labelCounter++);
    return l;
}

typedef struct {
    char nome[50];
    int tipo;
} Simbolo;

typedef struct {
  Simbolo tabela[100];
  int qtdSimbolos;
} PilhaEstados;

PilhaEstados estado[100];

void novoContexto(){
  if(stateCounter < 99){
    stateCounter++;
    estado[stateCounter].qtdSimbolos = 0;
  }
}

void encerraContexto(){
  estado[stateCounter].qtdSimbolos = 0;
  stateCounter--;
}

int buscarSimbolo(const char* nome, int contexto) {
  for(int i = 0; i < estado[contexto].qtdSimbolos; i++){
    if(strcmp(estado[contexto].tabela[i].nome, nome) == 0) return i;
  }

  return -1;
}

int buscarContexto(const char* nome){
  for(int i = stateCounter; i >=0; i--){
    if(buscarSimbolo(nome, i) != -1)
      return i;
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

char* novoRotulo() {
    char* l = malloc(10);
    sprintf(l, "L%d", labelCounter++);
    return l;
}

void declararVariavel(const char* nome, int tipo) {
    if (buscarSimbolo(nome, stateCounter) == -1) {
      strcpy(estado[stateCounter].tabela[estado[stateCounter].qtdSimbolos].nome, nome);
      estado[stateCounter].tabela[estado[stateCounter].qtdSimbolos++].tipo = tipo;
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
%token TK_TIPO_INT TK_TIPO_FLOAT TK_TIPO_CHAR TK_TIPO_BOOL TK_AND TK_OR TK_NOT TK_IF TK_ELSE TK_WHILE TK_PRINT TK_DO TK_FOR TK_SWITCH TK_CASE TK_DEFAULT TK_BREAK
%left TK_OR
%left TK_AND
%right TK_NOT
%left TK_EQ TK_NE TK_LT TK_LE TK_GT TK_GE
%left '+' '-'
%left '*' '/'
%type <atr> expr linha comandos bloco bloco_comandos comandos_opt case_clauses case_clause sentenca sentenca_fechada sentenca_aberta

%%

bloco:
     comandos{
        printf("#include <stdio.h>\n\n");
        printf("int main() {\n");
        printf("%s", declaracoes);

        for (int i = 0; i < estado[stateCounter].qtdSimbolos; i++) {
            printf("    %s %s;\n", tipoToStr(estado[stateCounter].tabela[i].tipo), estado[stateCounter].tabela[i].nome);
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
    sentenca { 
        $$.traducao = $1.traducao; 
    }
  | expr ';' {
        $$.traducao = $1.traducao;
        $$.label = $1.label;
        $$.tipo = $1.tipo;
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
  | TK_PRINT '(' expr ')' ';' {
      char* tr = malloc(strlen($3.traducao) + 64);
      sprintf(tr, "%s    printf(\"%%d\\n\", %s);\n",
        $3.traducao,
        $3.label
      );
      $$.traducao = tr;
    }
;

sentenca:
    sentenca_fechada { $$.traducao = $1.traducao; }
  | sentenca_aberta  { $$.traducao = $1.traducao; }
;

sentenca_fechada:
    TK_IF '(' expr ')' sentenca_fechada TK_ELSE sentenca_fechada {
        if ($3.tipo != BOOL) { yyerror("A condição de um if deve ser um valor booleano."); YYERROR; }
        char* rotulo_else = novoRotulo();
        char* rotulo_fim = novoRotulo();
        char* tr = malloc(strlen($3.traducao) + strlen($5.traducao) + strlen($7.traducao) + 256);
        sprintf(tr, "%s    if (!%s) goto %s;\n%s    goto %s;\n%s:\n%s%s:\n",
                $3.traducao, $3.label, rotulo_else,
                $5.traducao,
                rotulo_fim,
                rotulo_else,
                $7.traducao,
                rotulo_fim);
        $$.traducao = tr;
    }
  | TK_WHILE '(' expr ')' sentenca_fechada {
      char* start = novaLabel();
      char* end   = novaLabel();
      char* tr = malloc(strlen($3.traducao) + strlen($5.traducao) + 128);
      sprintf(tr, "%s:\n%s    if (!%s) goto %s;\n%s    goto %s;\n%s:\n",
              start, $3.traducao, $3.label, end, $5.traducao, start, end);
      $$.traducao = tr;
  }
  | TK_SWITCH '(' expr ')' '{' case_clauses '}' {
      if ($3.tipo != INT && $3.tipo != CHAR) {
          yyerror("Expressão do switch deve ser do tipo int ou char.");
          YYERROR;
      }
      char* tr = malloc(strlen($3.traducao) + strlen($6.traducao) + 128);
      sprintf(tr, "%sswitch (%s) {\n%s}\n", $3.traducao, $3.label, $6.traducao);
      $$.traducao = tr;
      free($6.traducao); // Adicionado para liberar memória de case_clauses
  }
  | TK_FOR '(' expr ';' expr ';' expr ')' sentenca_fechada {
      char* start = novaLabel();
      char* end   = novaLabel();
      char* tr = malloc(strlen($3.traducao) + strlen($5.traducao) + strlen($7.traducao) + strlen($9.traducao) + 256);
      sprintf(tr, "%s%s:\n%s    if (!%s) goto %s;\n%s%s    goto %s;\n%s:\n",
              $3.traducao, start, $5.traducao, $5.label, end, $9.traducao, $7.traducao, start, end);
      $$.traducao = tr;
  }
  | TK_DO sentenca_fechada TK_WHILE '(' expr ')' ';' {
      char* start = novaLabel();
      char* tr = malloc(strlen($2.traducao) + strlen($5.traducao) + 128);
      sprintf(tr, "%s:\n%s%s    if (%s) goto %s;\n",
              start, $2.traducao, $5.traducao, $5.label, start);
      $$.traducao = tr;
  }
  | bloco_comandos { $$.traducao = $1.traducao; }
  ;

sentenca_aberta:
    TK_IF '(' expr ')' sentenca { // IF sem ELSE
        if ($3.tipo != BOOL) { yyerror("A condição de um if deve ser um valor booleano."); YYERROR; }
        char* rotulo_fim = novoRotulo();
        char* tr = malloc(strlen($3.traducao) + strlen($5.traducao) + 128);
        sprintf(tr, "%s    if (!%s) goto %s;\n%s%s:\n",
                $3.traducao, $3.label, rotulo_fim,
                $5.traducao,
                rotulo_fim);
        $$.traducao = tr;
    }
  | TK_IF '(' expr ')' sentenca_fechada TK_ELSE sentenca_aberta { // IF com ELSE aberto
        if ($3.tipo != BOOL) { yyerror("A condição de um if deve ser um valor booleano."); YYERROR; }
        char* rotulo_else = novoRotulo();
        char* rotulo_fim = novoRotulo();
        char* tr = malloc(strlen($3.traducao) + strlen($5.traducao) + strlen($7.traducao) + 256);
        sprintf(tr, "%s    if (!%s) goto %s;\n%s    goto %s;\n%s:\n%s%s:\n",
                $3.traducao, $3.label, rotulo_else, $5.traducao,
                rotulo_fim, rotulo_else, $7.traducao, rotulo_fim);
        $$.traducao = tr;
    }
;

//==============================================================
//           REGRAS PARA BLOCOS E COMANDOS DE CONTROLE
//==============================================================

bloco_comandos:
    inicio_contexto comandos fim_contexto {
      $$.traducao = $2.traducao;
    }
;

comandos_opt:
    comandos {
        // Se houver comandos, apenas passe a tradução para cima
        $$.traducao = $1.traducao;
    }
  | %empty {
        // Se não houver comandos, crie uma string vazia
        $$.traducao = strdup("");
    }
;

case_clauses:
    /* Uma lista de cláusulas case/default/break */
    case_clauses case_clause {
        // Concatena as cláusulas anteriores com a nova
        char* tr = malloc(strlen($1.traducao) + strlen($2.traducao) + 1);
        sprintf(tr, "%s%s", $1.traducao, $2.traducao);
        $$.traducao = tr;
        free($1.traducao);
        free($2.traducao);
    }
  | %empty {
        $$.traducao = strdup("");
    }
;

case_clause:
    TK_CASE TK_NUM ':' comandos_opt { // Alterado para comandos_opt
        char* tr = malloc(strlen($2) + strlen($4.traducao) + 16);
        // Cuidado! O token de comandos agora é $4
        sprintf(tr, "    case %s:\n%s", $2, $4.traducao);
        $$.traducao = tr;
        // Lembre-se de liberar a memória da sub-regra opcional
        free($4.traducao);
    }
  | TK_CASE TK_CHAR ':' comandos_opt { // Alterado para comandos_opt
        char* tr = malloc(strlen($2) + strlen($4.traducao) + 16);
        // Cuidado! O token de comandos agora é $4
        sprintf(tr, "    case %s:\n%s", $2, $4.traducao);
        $$.traducao = tr;
        free($4.traducao);
    }
  | TK_DEFAULT ':' comandos_opt { // Alterado para comandos_opt
        char* tr = malloc(strlen($3.traducao) + 16);
        // Cuidado! O token de comandos agora é $3
        sprintf(tr, "    default:\n%s", $3.traducao);
        $$.traducao = tr;
        free($3.traducao);
    }
  | TK_BREAK ';' {
        $$.traducao = strdup("        break;\n");
    }
;

inicio_contexto:
  '{'{
    novoContexto();
  }
;

fim_contexto:
  '}' {
    encerraContexto();
  }
;

//==============================================================
//                 INÍCIO DAS REGRAS DE EXPRESSÃO
//==============================================================

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
        int idx = buscarSimbolo($1, buscarContexto($1));
        int tipo = (idx != -1) ? estado[stateCounter].tabela[idx].tipo : INT;
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
    int contextoId = buscarContexto($1);
    int idx = buscarSimbolo($1, contextoId);
    if (idx == -1) {
        char* error_msg = (char*) malloc(strlen($1) + 25);
        sprintf(error_msg, "Variável '%s' não declarada", $1);
        yyerror(error_msg);
        free(error_msg);
        YYERROR;
    }

    int tipoVar = estado[stateCounter].tabela[idx].tipo; // Tipo da variável à esquerda (ex: I -> INT)
    int tipoExpr = $3.tipo;         // Tipo da expressão à direita (ex: F -> FLOAT)
    char* labelExpr = $3.label;     // Label da expressão (ex: T1)
    char* traducaoExpr = $3.traducao; // Tradução da expressão
    char* tr;

    if (tipoVar == tipoExpr) {
        tr = malloc(strlen(traducaoExpr) + strlen($1) + strlen(labelExpr) + 10);
        (contextoId == 0)?sprintf(tr, "%s%s = %s;\n", traducaoExpr, $1, labelExpr):sprintf(tr, "%s", traducaoExpr);
    } else if (tipoVar == INT && tipoExpr == FLOAT) {
        char* t_cast = novaTemp(INT); // Nova temporária para guardar o resultado do cast
        tr = malloc(strlen(traducaoExpr) + strlen(t_cast) + strlen(labelExpr) + strlen($1) + 30);
        (contextoId == 0)?sprintf(tr, "%s%s = (int) %s;\n%s = %s;\n", traducaoExpr, t_cast, labelExpr, $1, t_cast):sprintf(tr, "%s%s = (int) %s;\n", traducaoExpr, t_cast, labelExpr);
    } else if (tipoVar == FLOAT && tipoExpr == INT) {
        char* t_cast = novaTemp(FLOAT);
        tr = malloc(strlen(traducaoExpr) + strlen(t_cast) + strlen(labelExpr) + strlen($1) + 30);
        (contextoId == 0)?sprintf(tr, "%s%s = (float) %s;\n%s = %s;\n", traducaoExpr, t_cast, labelExpr, $1, t_cast):sprintf(tr, "%s%s = (float) %s;\n", traducaoExpr, t_cast, labelExpr);
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
