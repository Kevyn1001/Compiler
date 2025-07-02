#include "../headers/vector.hpp"
#include "../headers/vectorUtils.hpp"
#include "../headers/utils.hpp"
#include "../headers/symbols.hpp"
#include "../headers/type.hpp"
#include "../headers/scope.hpp"
#include "../headers/assignment.hpp"


using namespace std;


Attribute makeVector(Attribute actual, Attribute type, Attribute variable, Attribute expression)
{
    validateVector(expression.type);
    declareTK_TYPE(type.translation+"*", actual, variable);
    Symbol newSymbol = getSimboloAnywere(variable.label);
    
    actual.translation = 
    expression.translation
    + "\t" + newSymbol.name + " = ( " + type.translation + "* ) malloc( sizeof(" + type.translation + ") * " + expression.label + " );\n";
    
    pushVector(createVector(type.translation, variable.label, newSymbol.name, expression.label));
    return actual;
}

Attribute setValueInVector(Attribute actual, Attribute variable, Attribute position, Attribute expression)
{
    Symbol variableSymbol = getSimboloAnywere(variable.label);

    Attribute aux = createCopyToMakeVectorAssignment(actual, variableSymbol);
    Attribute newAttribute = makeAtribuicao(actual, aux, expression, "=");

    Symbol auxSymbol = getSimboloAnywere(aux.label);

    actual.translation =
    variable.translation
    + position.translation
    + newAttribute.translation
    + "\t" + variableSymbol.name + " [ " + position.label + " ] = " + auxSymbol.name + ";" + "\n";
    return actual;
}

Attribute makeAssignmentVector(Attribute actual, Attribute left, Attribute right, Attribute position)
{
    Symbol variableSymbol = getSimboloAnywere(right.label);
    Symbol newSymbol = getSimboloAnywere(left.label);

    Attribute aux = createCopyToMakeVectorAssignment(actual, variableSymbol);
    Attribute newAttribute = makeAtribuicao(actual, left, aux, "=");

    actual.translation =
    left.translation
    + right.translation
    + position.translation
    + "\t" + newSymbol.name + " = " + variableSymbol.name + " [ " + position.label + " ];" + "\n";
    return actual;
}


Attribute getVectorPosition(Attribute actual, Attribute variable, Attribute position)
{
    Symbol variableSymbol = getSimboloAnywere(variable.label);

    actual.translation = position.translation;
    actual.label = variableSymbol.name + " [ " + position.label + " ]";
    actual.type = removePointerOfVectorType(variableSymbol).type;
    return actual;
}
