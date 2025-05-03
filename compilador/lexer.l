%{
#include "parser.tab.h"
#include <stdlib.h>
#include <string.h>
%}

%%

"int"            { return TK_TIPO_INT; }
"float"          { return TK_TIPO_FLOAT; }
"char"           { return TK_TIPO_CHAR; }
"bool"           { return TK_TIPO_BOOL; }
"true"           { yylval.label = strdup(yytext); return TK_BOOL; }
"false"          { yylval.label = strdup(yytext); return TK_BOOL; }
[0-9]+"."[0-9]+  { yylval.label = strdup(yytext); return TK_REAL; }
[0-9]+           { yylval.label = strdup(yytext); return TK_NUM; }
[A-Za-z]([A-Za-z0-9])* { yylval.label = strdup(yytext); return TK_ID; }
\'[A-Za-z0-9]\'  {yylval.label = strdup(yytext); return TK_CHAR; }
[+\-*/=]         { return *yytext; }
[();]            { return *yytext; }
[ \t\r\n]        ; // ignora espaços e quebras

%%

int yywrap() { return 1; }
