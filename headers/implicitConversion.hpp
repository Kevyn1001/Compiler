#ifndef IMPLICITCONVERSION_H
#define IMPLICITCONVERSION_H


#include "struct.hpp"


using namespace structs;


Attribute resolveTipoAtribuicao(Attribute left, string operation, Attribute right);
Attribute resolveTipoExpressao(Attribute left, string operador, Attribute right);

Attribute resolveTipoExpressaoDefault(Attribute left, string operation, Attribute right);
Attribute resolveTipoExpressaoString(Attribute left, string operador, Attribute right);

Attribute resolveArithmeticExpressionTypeString(Attribute left, string operador, Attribute right);
Attribute resolveLogicalExpressionTypeString(Attribute left, string operador, Attribute right);

#endif