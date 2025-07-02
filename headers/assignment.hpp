// assignment.hpp

#ifndef ASSIGNMENT_H
#define ASSIGNMENT_H

#include "struct.hpp"


using namespace structs;

Attribute verificarSeEhString(Symbol leftSymbol, Attribute actual, Attribute left, Attribute right, string operation);
void verificarSeNaoFoiDeclarado(Attribute attribute);

Attribute makeAtribuicao(Attribute actual, Attribute left, Attribute right, string operation);
Attribute makeDeclaracaoVarAtribuicao(Attribute actual, Attribute left, Attribute right, string operation);

Attribute makeAtribuicaoDefault(Attribute actual, Attribute left, Attribute right, Symbol leftSimbol, string operation);
Attribute makeAtribuicaoString(Attribute actual, Attribute left, Attribute right, Symbol leftSimbol, string operation);

Attribute makeOperadorComposto(Attribute actual, Attribute left, string operation, Attribute right);
Attribute makeOperadorUnario(Attribute actual, Attribute left, string operation);

#endif