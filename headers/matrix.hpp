#ifndef MATRIX_H
#define MATRIX_H

#include "struct.hpp"
#include <unordered_map>


using namespace structs;

Attribute getMatrizPosition(Attribute actual, Attribute variable, Attribute linePosition, Attribute columnPosition);
Attribute makeMatriz(Attribute actual, Attribute type, Attribute variable, Attribute left, Attribute right);
Attribute setValorMatriz(Attribute actual, Attribute variable, Attribute linePosition, Attribute columnPosition, Attribute expression);
Attribute makeAtribuicaoMatriz(Attribute actual, Attribute left, Attribute right, Attribute linePosition, Attribute columnPosition);

#endif