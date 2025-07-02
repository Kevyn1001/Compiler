#include "../headers/expression.hpp"
#include "../headers/symbols.hpp"
#include <cmath>


using namespace std;


extern Attribute resolveTipoExpressao(Attribute left, string operation, Attribute right);



Attribute makeExpression(Attribute left, string operation, Attribute right)
{
	Attribute newActual = resolveTipoExpressao(left, operation, right);
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
    Attribute actual = resolveTipoExpressao(left, "^", right);

    actual.translation  = left.translation;
    actual.translation += right.translation;
    // temp para o resultado
    string temp = actual.label; 
    actual.translation += "\t" + temp
                       + " = pow(" + left.label + ", " + right.label + ");\n";
    return actual;
}