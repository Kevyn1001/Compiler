#include "../headers/matrixUtils.hpp"
#include "../headers/vectorUtils.hpp"
#include "../headers/utils.hpp"
#include "../headers/symbols.hpp"
#include "../headers/type.hpp"
#include "../headers/scope.hpp"
#include "../headers/assignment.hpp"
#include <sstream>


using namespace std;

MatrixMap matrixMap;


Attribute calculateMatrizPosition(Matrix matrix, Attribute linePosition, Attribute columnPosition)
{
    Attribute position = createActualAttribute("int");
    Attribute positionCalculated = createActualAttribute("int");
    positionCalculated.translation = 
    "\t" + position.label + " = " + linePosition.label + " * " + matrix.numColumns + ";\n\t" 
    + positionCalculated.label + " = " + position.label + " + " + columnPosition.label + ";\n";
    
    return positionCalculated;
}

void validateMatriz(string lineType, string sizeLine, string columnType, string sizeColumn)
{
    if(lineType != "int") { yyerror("O tamanho das linhas da matriz deve ser do tipo inteiro."); }
    if(columnType != "int") { yyerror("O tamanho da coluna da matriz deve ser do tipo inteiro."); }
}


void pushMatriz(Matrix matrix)
{
	string name = matrix.name;
    matrixMap[name] = matrix;
}

Matrix searchMatriz(string name)
{
	return matrixMap[name];
}

Matrix createMatriz(string name, string numLines, string numColumns)
{
    Matrix matrix;
    matrix.name = name;
    matrix.numLines = numLines;
    matrix.numColumns = numColumns;
    return matrix;
}

Attribute removeBracketMatriz(Attribute matrixWithPosition)
{
    // remove bracket of matrix. ex: v3[t7] to v3
    stringstream sstream(matrixWithPosition.label);
    string label;
    getline(sstream, label, ' ');
    matrixWithPosition.label = label;
    return matrixWithPosition;
}