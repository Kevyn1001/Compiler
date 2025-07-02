#ifndef COERCAO_H
#define COERCAO_H

#include <string>
#include <map>

using namespace std;

typedef struct coercao
{
  string returnedType;
  string conversionType;
} Coercao;

typedef struct stringExpressionHelper
{
  string resultLabelStrcmpCompare;
  string operatorToCheck;
} StringExpressionHelper;


typedef tuple<string, string, string> TripleKey;
extern map<TripleKey, Coercao> coercaoTable;
extern map<string, StringExpressionHelper> stringExpressionHelperTable;


TripleKey generateKey(string , string, string);
void iniciarCoercaoTable();
Coercao getCoercao(string type1, string operation, string type2);

Coercao resolveString(string type1, string operation, string type2);
Coercao resolveDefault(string type1, string operation, string type2);

void iniciarStringExpressionHelperTable();
StringExpressionHelper getStringExpressionHelper(string operation);

#endif