#include "../headers/expression.hpp"
#include "../headers/symbols.hpp"
#include <cmath>


using namespace std;


extern Attribute resolveExpressionType(Attribute left, string operation, Attribute right);



Attribute makeExpression(Attribute left, string operation, Attribute right)
{
	Attribute newActual = resolveExpressionType(left, operation, right);
	return newActual;
}

Attribute makeTK_NOT(Attribute actual, Attribute right)
{
  Attribute newActual = createActualAttribute("bool");

  newActual.translation = right.translation + "\t" + newActual.label + " = !" + right.label + ";\n";
  return newActual;
}

Attribute makeExponent(Attribute left, Attribute right)
{
    Attribute actual = resolveExpressionType(left, "^", right);

    actual.translation  = left.translation;
    actual.translation += right.translation;
    // temp para o resultado
    string temp = actual.label; 
    actual.translation += "\t" + temp
                       + " = pow(" + left.label + ", " + right.label + ");\n";
    return actual;
}