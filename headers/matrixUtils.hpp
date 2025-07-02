#ifndef MATRIXUTILS_H
#define MATRIXUTILS_H

#include "struct.hpp"
#include <unordered_map>


using namespace structs;

typedef struct matrix
{
    string name;
    string numLines;
    string numColumns;
} Matrix;

typedef unordered_map<string,Matrix> MatrixMap;

Attribute calculateMatrizPosition(Matrix matrix, Attribute linePosition, Attribute columnPosition);
void validateMatriz(string lineType, string sizeLine, string columnType, string sizeColumn);
void pushMatriz(Matrix matrixStruct);
Matrix searchMatriz(string name);
Matrix createMatriz(string name, string numLines, string numColumns);
Attribute removeBracketMatriz(Attribute matrixWithPosition);

#endif