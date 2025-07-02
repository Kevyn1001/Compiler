#include "../headers/assignment.hpp"
#include "../headers/utils.hpp"
#include "../headers/symbols.hpp"
#include "../headers/scope.hpp"
#include "../headers/type.hpp"


using namespace std;

extern Attribute resolveTipoAtribuicao(Attribute left, string operation, Attribute right);


void verificarSeNaoFoiDeclarado(Attribute attribute)
{
	Symbol symbol = getSimboloAnywere(attribute.label);
	string message = "TK_ID '" +  attribute.label + "' não foi declarado. Por favor defina um tipo para '" + attribute.label + "'.\n";
	variableHasNotBeenDeclared(symbol, message);
}

Attribute verificarSeEhString(Symbol leftSymbol, Attribute actual, Attribute left, Attribute right, string operation)
{
	if(leftSymbol.type == "string") 
	{ 
		return makeAtribuicaoString(actual, left, right, leftSymbol, operation); 
	}
	else
	{
		return makeAtribuicaoDefault(actual, left, right, leftSymbol, operation);
	}
}



Attribute makeAtribuicao(Attribute actual, Attribute left, Attribute right, string operation)
{
	verificarSeNaoFoiDeclarado(actual);

	Symbol leftSymbol = getSimboloAnywere(left.label);
	return verificarSeEhString(leftSymbol, actual, left, right, operation);
}

Attribute makeDeclaracaoVarAtribuicao(Attribute actual, Attribute left, Attribute right, string operation)
{
	declareTK_TYPE_SetNotDefaultValue(actual, left, right.type);
	declareTK_TYPE_SetNotDefaultValue(actual, right, right.type);
									
	Symbol leftSymbol = getSimboloAnywere(left.label);
	return verificarSeEhString(leftSymbol, actual, left, right, operation);
}



Attribute makeAtribuicaoDefault(Attribute actual, Attribute left, Attribute right, Symbol leftSimbol, string operation)
{
	if(leftSimbol.type == right.type)
	{
		actual.translation += left.translation + right.translation + "\t" + leftSimbol.name + " " + operation + " " + right.label + ";\n";
	}
	else 
	{
		Attribute newActual = resolveTipoAtribuicao(left, operation, right);
		return newActual;
	}
	return actual;
}

Attribute makeAtribuicaoString(Attribute actual, Attribute left, Attribute right, Symbol leftSimbol, string operation)
{
	if(leftSimbol.type != right.type)
	{
		yyerror("A operação não foi setada para " + leftSimbol.type + " e " + right.type);
	}

	string type= "string";
	string leftStringSizeLabel = createStringSizeLabel(leftSimbol.name);
	addTemporary(leftStringSizeLabel, "int");

	string rightStringSizelabel = "size_"+right.label;

	actual.translation = left.translation + right.translation
	+ "\t" + leftStringSizeLabel +  " = " + rightStringSizelabel + ";\n"
	+ "\t" + leftSimbol.name + " = (" + type + ") realloc(" + leftSimbol.name + ", " + leftStringSizeLabel  + ");\n"
	+ "\tstrcpy( " + leftSimbol.name + ", " + right.label + " );\n"
	+ "\n"; 

	return actual;
}



Attribute makeOperadorComposto(Attribute actual, Attribute left, string operation, Attribute right)
{
  Symbol leftSimbol = getSimboloAnywere(left.label);
	left.type = leftSimbol.type;

	Symbol rightSimbol = getSimboloAnywere(right.label);
	right.type = rightSimbol.type;
	right.label = rightSimbol.name;

	string message =  "= (" + leftSimbol.name + " " + operation + " " + right.label + ") "
	+ " /*operador composto*/";

	right.label = "";

	return makeAtribuicao(actual, left, right, message);
}

Attribute makeOperadorUnario(Attribute actual, Attribute left, string operation)
{
  	Symbol leftSimbol = getSimboloAnywere(left.label);
	Attribute auxAttribute = createActualAttribute(leftSimbol.type);

	actual.translation = "\t" + auxAttribute.label + " = " + "1;\n";
	string message =  "= (" + leftSimbol.name + " " + operation + " "  + auxAttribute.label + ") ";

	auxAttribute.label = "";

	return makeAtribuicao(actual, left, auxAttribute, message);
}
