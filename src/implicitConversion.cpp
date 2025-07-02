#include "../headers/implicitConversion.hpp"
#include "../headers/utils.hpp"
#include "../headers/symbols.hpp"
#include "../headers/Coercao.hpp"
#include "../headers/scope.hpp"
#include "../headers/struct.hpp"


using namespace std;


Attribute resolveTipoAtribuicao(Attribute left, string operador, Attribute right)
{
	Symbol leftSimbol = getSimboloAnywere(left.label);
	coercao coercao = getCoercao(leftSimbol.type, operador, right.type);

	Attribute actual = createActualAttribute(coercao.returnedType);	

	string newTemp = createTempCode();
	addTemporary(newTemp, coercao.conversionType);

	string message = "\t"+ leftSimbol.name + " " + operador + " ("+ coercao.conversionType +") ", result;
	

	if (leftSimbol.type != coercao.conversionType)
	{
		actual.translation = actual.translation + "\t" + leftSimbol.name + " " + operador + " (" + coercao.conversionType + ") " + actual.label + ";\n";
	}
	else if (right.type != coercao.conversionType)
	{
		message += right.label;
		result = newTemp;
	}
	else
	{
		yyerror("A operação não foi setada para " + leftSimbol.type + " e " + right.type);
	}
	
	actual.translation = left.translation + right.translation + message + ";\n";

	return actual;
}


//------------------------------------------------------------------------------

Attribute resolveTipoExpressao(Attribute left, string operador, Attribute right)
{
  if (left.type == "string" || right.type == "string")
	{ 
    return resolveTipoExpressaoString(left, operador, right);
  }
	return resolveTipoExpressaoDefault(left, operador, right);
}


Attribute resolveTipoExpressaoDefault(Attribute left, string operador, Attribute right)
{
	Coercao coercao = getCoercao(left.type, operador, right.type);
	Attribute actual = createActualAttribute(coercao.returnedType);

	if (left.type == coercao.conversionType && right.type == coercao.conversionType)
	{
		actual.translation = left.translation + right.translation + "\t" + actual.label +" = " + left.label + " " + operador + " " + right.label +";\n";
	}
	else
	{
		string newTemp = createTempCode();
		addTemporary(newTemp, coercao.conversionType);

		string message = "\t"+ newTemp + " = " "("+ coercao.conversionType +") ", result;


		if (left.type != coercao.conversionType)
		{
			message += left.label;
			result = newTemp + " " + operador + " " + right.label;
		}
		else if (right.type != coercao.conversionType)
		{
			message += right.label;
			result = left.label + " " + operador + " " + newTemp;
		}

		message += ";\n";
		actual.translation = left.translation + right.translation + message +"\t" + actual.label + " = "  + result + ";\n";
	}

	return actual;
}


Attribute resolveTipoExpressaoString(Attribute left, string operador, Attribute right)
{
	if(operador == "+")
	{ 
		return resolveArithmeticExpressionTypeString(left, operador, right); 
	}
	return resolveLogicalExpressionTypeString(left, operador, right); 
}

Attribute resolveArithmeticExpressionTypeString(Attribute left, string operador, Attribute right)
{
	Coercao coercao = getCoercao(left.type, operador, right.type);
	Attribute actual = createActualAttribute(coercao.returnedType);
	actual.type = coercao.returnedType;

	if(operador == "+")
	{
		string sizeA = createStringSizeLabel(left.label);
		string sizeB = createStringSizeLabel(right.label);
		string finalSize = createStringSizeLabel(actual.label);

		addTemporary(finalSize, "int");
		actual.translation = left.translation + right.translation
		+ "\t" + finalSize + " = " + sizeA + " + " + sizeB + ";\n"
		+ "\t" + finalSize + " = " + finalSize + " - 1;\n"
		+ "\t" + actual.label + " = (string) realloc(" + actual.label  + ", " + finalSize + " );\n"
		+ "\tstrcat("+ actual.label + ", "+ left.label +");\n"
		+ "\tstrcat("+ actual.label + ", "+ right.label +");\n"
		+ "\n";
	}
	return actual;
}

Attribute resolveLogicalExpressionTypeString(Attribute left, string operador, Attribute right)
{
	StringExpressionHelper stringExpressionHelper = getStringExpressionHelper(operador);

	Coercao coercao = getCoercao(left.type, operador, right.type);
	Attribute actual = createActualAttribute(coercao.returnedType);
	actual.type = coercao.returnedType;


	string tempLabelCompare = createTempCode();
	addTemporary(tempLabelCompare, "int");

	string tempLabelBool = createTempCode();
	addTemporary(tempLabelBool, "bool");

	string tempLabelInt = createTempCode();
	addTemporary(tempLabelInt, "int");
	
	
	actual.translation = left.translation + right.translation
	+ "\t" + tempLabelCompare + " = strcmp(" + left.label+ ", " + right.label + " );\n"
	+ "\t" + tempLabelInt + " = " + stringExpressionHelper.resultLabelStrcmpCompare + ";\n"
	+ "\t" + tempLabelBool + " = " + tempLabelCompare + " " + stringExpressionHelper.operatorToCheck + " " + tempLabelInt + ";\n"
	+ "\n";

	actual.label = tempLabelBool;

	return actual;
}
