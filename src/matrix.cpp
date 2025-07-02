#include "../headers/matrix.hpp"
#include "../headers/vectorUtils.hpp"
#include "../headers/matrixUtils.hpp"
#include "../headers/utils.hpp"
#include "../headers/symbols.hpp"
#include "../headers/type.hpp"
#include "../headers/scope.hpp"
#include "../headers/assignment.hpp"

#include <string.h>
#include <stdlib.h>


using namespace std;


Attribute makeMatriz(Attribute actual, Attribute type, Attribute variable, Attribute left, Attribute right)
{
    validateMatriz(left.type, "line", right.type, "column");

    createTK_ID(actual, variable);
	declareTK_TYPE(type.translation+"*", actual, variable);
    Symbol newSymbol = getSimboloAnywere(variable.label);

    Attribute aux = createActualAttribute("int");

    actual.translation = 
    left.translation
    + right.translation
    + "\t" + aux.label + " = " + left.label + " * " + right.label + ";\n"
    + "\t" + newSymbol.name + " = ( " + type.translation + "* ) malloc( sizeof(" + type.translation + ") * " + aux.label + " );\n";
    
    pushMatriz(createMatriz(newSymbol.name, left.label, right.label));
    return actual;
}

Attribute setValorMatriz(Attribute actual, Attribute variable, Attribute linePosition, Attribute columnPosition, Attribute expression)
{
    Symbol variableSymbol = getSimboloAnywere(variable.label);
    Attribute aux = createCopyToMakeVectorAssignment(actual, variableSymbol);
    Attribute newAttribute = makeAtribuicao(actual, aux, expression, "=");

    Symbol auxSymbol = getSimboloAnywere(aux.label);
    Symbol newSymbol = getSimboloAnywere(variable.label);

    Matrix matrix = searchMatriz(newSymbol.name);
    Attribute positionCalculated = calculateMatrizPosition(matrix, linePosition, columnPosition);
    
    actual.translation =
    variable.translation
    + linePosition.translation
    + columnPosition.translation
    + positionCalculated.translation
    + newAttribute.translation
    + "\t" + newSymbol.name + " [ " + positionCalculated.label + " ] = " + auxSymbol.name + ";" + "\n";
    return actual;
}

Attribute makeAtribuicaoMatriz(Attribute actual, Attribute left, Attribute right, Attribute linePosition, Attribute columnPosition)
{
    Symbol variableSymbol = getSimboloAnywere(right.label);
    Symbol newSymbol = getSimboloAnywere(left.label);

    Attribute aux = createCopyToMakeVectorAssignment(actual, variableSymbol);
    Attribute newAttribute = makeAtribuicao(actual, left, aux, "=");

    Matrix matrix = searchMatriz(variableSymbol.name);
    Attribute positionCalculated = calculateMatrizPosition(matrix, linePosition, columnPosition);

    actual.translation =
    left.translation
    + right.translation
    + linePosition.translation
    + columnPosition.translation
    + positionCalculated.translation
    + "\t" + newSymbol.name + " = " + variableSymbol.name + " [ " + positionCalculated.label + " ];" + "\n";
    return actual;
}


Attribute getMatrizPosition(Attribute actual, Attribute variable, Attribute linePosition, Attribute columnPosition)
{
    Symbol variableSymbol = getSimboloAnywere(variable.label);

    Matrix matrix = searchMatriz(variableSymbol.name);
    Attribute positionCalculated = calculateMatrizPosition(matrix, linePosition, columnPosition);
    
    actual.translation = 
    linePosition.translation 
    + columnPosition.translation 
    + positionCalculated.translation;
    actual.label = variableSymbol.name + " [ " + positionCalculated.label + " ]";
    actual.type = removePointerOfVectorType(variableSymbol).type;
    return actual;
}
