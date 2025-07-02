#ifndef SCOPE_H
#define SCOPE_H

#include <iostream>
#include <vector>
#include <unordered_map>
#include "symbols.hpp"


using namespace std;


typedef unordered_map<string, Symbol> VariableTable; // <actualScope, Symbol>

typedef struct stackMap
{
  vector<VariableTable> scopes;
  int actualScope;
} StackMap;

typedef StackMap* StackMapPtr;


void pushScope(StackMapPtr, VariableTable);
VariableTable popScope(StackMapPtr);
StackMapPtr createMapStack();

Symbol addSimboloScope (StackMapPtr stack, string label, string type, Attribute actual);
Symbol addSimboloScopeSuperior (StackMapPtr stack, string label, string type, Attribute actual);
Symbol addSimboloScopeGlobal (StackMapPtr stack, string label, string type, Attribute actual);

Symbol getSimboloAnywere(string label);
Symbol getSimboloTop(string label);
Symbol getSimboloGlobal(string label);

string getAllSymbols();


extern StackMapPtr StackContext;

#endif