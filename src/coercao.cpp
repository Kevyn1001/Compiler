#include "../headers/coercao.hpp"
#include "../headers/utils.hpp"

using namespace std;

map<TripleKey, Coercao> coercaoTable;
Coercao removeWarning();
map<string, StringExpressionHelper> stringExpressionHelperTable;


TripleKey generateKey(string a , string b, string c)
{
	TripleKey key(a , b, c);

	return key;
}

Coercao getCoercao(string type1, string operation, string type2)
{
	if (type1 == "string" || type2 == "string")
	{
		return resolveString(type1, operation, type2);
	}
	return resolveDefault(type1, operation, type2);
}

Coercao resolveString(string type1, string operation, string type2)
{
	TripleKey key(type1, operation, type2);
	if (coercaoTable.find(key) != coercaoTable.end())
	{
		return coercaoTable[key];
	}
	yyerror("Não foi possivel converter o tipo " + type1 + " para o tipo " + type2 + ".");
	return removeWarning();
}

Coercao resolveDefault(string type1, string operation, string type2)
{
	TripleKey key(type1, operation, type2);
	if (type1 == type2 )
	{
		Coercao coercao = {type1, type2};
		return coercao;
	}
	if (coercaoTable.find(key) != coercaoTable.end())
	{
		return coercaoTable[key];
	}
	yyerror("Não foi possivel converter o tipo" + type1 + " para o tipo " + type2 + ".");
	return removeWarning();
}

Coercao removeWarning()
{
	// Just to remove the warning, it will never run.
	Coercao notFound = {"NULL", "NULL"};
	return notFound;
}

void iniciarCoercaoTable()
{
	coercaoTable[generateKey("int", "=", "float")] = {"int", "int"};
	coercaoTable[generateKey("float", "=", "int")] = {"float", "float"};
	coercaoTable[generateKey("int" , "=", "bool")] = {"int","int"};
	coercaoTable[generateKey("bool" , "=", "int")] = {"bool","bool"};

	coercaoTable[generateKey("int" , "%" , "int")] = {"int", "int"};

	coercaoTable[generateKey("int" , "+" , "int")] = {"int", "int"};
	coercaoTable[generateKey("int" , "-" , "int")] = {"int", "int"};
	coercaoTable[generateKey("int" , "*" , "int")] = {"int", "int"};
	coercaoTable[generateKey("int" , "/" , "int")] = {"int", "int"};

	coercaoTable[generateKey("float", "+", "float")] = {"float", "float"};
	coercaoTable[generateKey("float", "-", "float")] = {"float", "float"};
	coercaoTable[generateKey("float", "*", "float")] = {"float", "float"};
	coercaoTable[generateKey("float", "/", "float")] = {"float", "float"};

	coercaoTable[generateKey("int", "+", "float")] = {"float", "float"};
	coercaoTable[generateKey("int", "-", "float")] = {"float", "float"};
	coercaoTable[generateKey("int", "*", "float")] = {"float", "float"};
	coercaoTable[generateKey("int", "/", "float")] = {"float", "float"};

	coercaoTable[generateKey("float", "+", "int")] = {"float", "float"};
	coercaoTable[generateKey("float", "-", "int")] = {"float", "float"};
	coercaoTable[generateKey("float", "*", "int")] = {"float", "float"};
	coercaoTable[generateKey("float", "/", "int")] = {"float", "float"};



	coercaoTable[generateKey("bool" , "&&", "bool")] = {"bool","bool"};
	coercaoTable[generateKey("bool" , "||", "bool")] = {"bool","bool"};
	coercaoTable[generateKey("bool" , "==", "bool")] = {"bool","bool"};
	coercaoTable[generateKey("bool" , "!=", "bool")] = {"bool","bool"};



	coercaoTable[generateKey("int" , "<", "int")] = {"bool","int"};
	coercaoTable[generateKey("int" , ">", "int")] = {"bool","int"};
	coercaoTable[generateKey("int" , ">=", "int")] = {"bool","int"};
	coercaoTable[generateKey("int" , "<=", "int")] = {"bool","int"};
	coercaoTable[generateKey("int" , "==", "int")] = {"bool","int"};
	coercaoTable[generateKey("int" , "!=", "int")] = {"bool","int"};


	coercaoTable[generateKey("float" , "<", "float")] = {"bool","float"};
	coercaoTable[generateKey("float" , ">", "float")] = {"bool","float"};
	coercaoTable[generateKey("float" , ">=", "float")] = {"bool","float"};
	coercaoTable[generateKey("float" , "<=", "float")] = {"bool","float"};
	coercaoTable[generateKey("float" , "==", "float")] = {"bool","float"};
	coercaoTable[generateKey("float" , "!=", "float")] = {"bool","float"};


	coercaoTable[generateKey("char" , "<", "char")] = {"bool", "char"};
	coercaoTable[generateKey("char" , ">", "char")] = {"bool", "char"};
	coercaoTable[generateKey("char" , ">=", "char")] = {"bool", "char"};
	coercaoTable[generateKey("char" , "<=", "char")] = {"bool", "char"};
	coercaoTable[generateKey("char" , "==", "char")] = {"bool","char"};
	coercaoTable[generateKey("char" , "!=", "char")] = {"bool","char"};


	coercaoTable[generateKey("int" , "<", "float")] = {"bool","float"};
	coercaoTable[generateKey("int" , ">", "float")] = {"bool","float"};
	coercaoTable[generateKey("int" , ">=", "float")] = {"bool","float"};
	coercaoTable[generateKey("int" , "<=", "float")] = {"bool","float"};
	coercaoTable[generateKey("int" , "==", "float")] = {"bool","float"};
	coercaoTable[generateKey("int" , "!=", "float")] = {"bool","float"};

	coercaoTable[generateKey("float" , "<", "int")] = {"bool","float"};
	coercaoTable[generateKey("float" , ">", "int")] = {"bool","float"};
	coercaoTable[generateKey("float" , ">=", "int")] = {"bool","float"};
	coercaoTable[generateKey("float" , "<=", "int")] = {"bool","float"};
	coercaoTable[generateKey("float" , "==", "int")] = {"bool","float"};
	coercaoTable[generateKey("float" , "!=", "int")] = {"bool","float"};

	coercaoTable[generateKey("string" , "+" , "string")] = {"string","string"};
	coercaoTable[generateKey("string", "==", "string")] = {"bool","string"};
	coercaoTable[generateKey("string", "!=", "string")] = {"bool","string"};
	coercaoTable[generateKey("string", "<", "string")] = {"bool","string"};
	coercaoTable[generateKey("string", ">", "string")] = {"bool","string"};
	coercaoTable[generateKey("string", "<=", "string")] = {"bool","string"};
	coercaoTable[generateKey("string", ">=", "string")] = {"bool","string"};

	coercaoTable[generateKey("int", "^", "int")]    = {"int",   "int"};
  coercaoTable[generateKey("int", "^", "float")]  = {"float", "float"};
  coercaoTable[generateKey("float", "^", "int")]  = {"float", "float"};
  coercaoTable[generateKey("float", "^", "float")] = {"float", "float"};
}

//------------------------------------------------------------------------------


StringExpressionHelper getStringExpressionHelper(string operation)
{
	return stringExpressionHelperTable[operation];
}

void iniciarStringExpressionHelperTable()
{
	stringExpressionHelperTable["=="] = {"0", "=="};
	stringExpressionHelperTable["!="] = {"0", "!="};
	stringExpressionHelperTable["<"] = {"-1", "<="};
	stringExpressionHelperTable[">"] = {"1", ">="};
	stringExpressionHelperTable["<="] = {"0", "<="};
	stringExpressionHelperTable[">="] = {"0", ">="};
}
