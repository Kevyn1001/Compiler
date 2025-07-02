#ifndef COERCION_H
#define COERCION_H

#include <string>
#include <map>

using namespace std;

typedef struct coercion
{
  string returnedType;
  string conversionType;
} Coercion;

typedef struct stringExpressionHelper
{
  string resultLabelStrcmpCompare;
  string operatorToCheck;
} StringExpressionHelper;


typedef tuple<string, string, string> TripleKey;
extern map<TripleKey, Coercion> coercionTable;
extern map<string, StringExpressionHelper> stringExpressionHelperTable;


TripleKey generateKey(string , string, string);
void iniciarCoercionTable();
Coercion getCoercion(string type1, string operation, string type2);

Coercion resolveString(string type1, string operation, string type2);
Coercion resolveDefault(string type1, string operation, string type2);

void iniciarStringExpressionHelperTable();
StringExpressionHelper getStringExpressionHelper(string operation);

#endif