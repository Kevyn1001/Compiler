%{
#include "parser.tab.h"
#include <stdlib.h>
#include <string.h>
%}

%%

"//".*            { /* ignora comentário de linha até o fim */ }
"/*"([^*]|\*+[^*/])*\*+"/" { /* ignora comentário em bloco */ }

"switch"         { return TK_SWITCH; } 
"case"           { return TK_CASE; }   
"default"        { return TK_DEFAULT; }
"break"          { return TK_BREAK; }
"while"          { return TK_WHILE; }
"do"             { return TK_DO; }
"for"            { return TK_FOR; }
"int"            { return TK_TIPO_INT; }
"float"          { return TK_TIPO_FLOAT; }
"char"           { return TK_TIPO_CHAR; }
"bool"           { return TK_TIPO_BOOL; }
"true"           { yylval.label = strdup(yytext); return TK_BOOL; }
"false"          { yylval.label = strdup(yytext); return TK_BOOL; }
[0-9]+"."[0-9]+  { yylval.label = strdup(yytext); return TK_REAL; }
[0-9]+           { yylval.label = strdup(yytext); return TK_NUM; }
"if"             { return TK_IF; }
"else"           { return TK_ELSE; }
"print"      		 { return TK_PRINT; }
[A-Za-z]([A-Za-z0-9])* { yylval.label = strdup(yytext); return TK_ID; }
\'[A-Za-z0-9]\'  {yylval.label = strdup(yytext); return TK_CHAR; }
"=="             { return TK_EQ; }
"!="             { return TK_NE; }
"<="             { return TK_LE; }
">="             { return TK_GE; }
"<"              { return TK_LT; }
">"              { return TK_GT; }
"&&"             { return TK_AND; }
"||"             { return TK_OR; }
"!"              { return TK_NOT; }
[+\-*/=]         { return *yytext; }
[();:{}]         { return *yytext; }
[ \t\r\n]        ; // ignora espaços e quebras

%%

int yywrap() { return 1; }
