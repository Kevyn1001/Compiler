#include "../headers/decisionCommands.hpp"
#include "../headers/utils.hpp"
#include "../headers/symbols.hpp"
#include "../headers/assignment.hpp"

#include <stack>
#include <iostream>
#include "../headers/scope.hpp"
#include "../headers/implicitConversion.hpp"


using namespace std;


Attribute makeIf(Attribute actual, Attribute expression, Attribute blockCommand)
{
  string endLabel = createGotoLabel();
	actual.translation = expression.translation 
  + "\t" + expression.label + " = !" + expression.label + ";\n" 
  + "\tif( " + expression.label + " ) goto " + endLabel + ";\n" 
  + blockCommand.translation 
  + "\t" + endLabel + ":\n"; 

  return actual;
}

Attribute makeIfElse(Attribute actual, Attribute expression, Attribute blockCommandIf, Attribute blockCommandElse)
{
  string midLabel = createGotoLabel();
  string endLabel = createGotoLabel();
  actual.translation = expression.translation 
  + "\t" + expression.label + " = !" + expression.label + ";\n" 
  + "\tif( " + expression.label + " ) goto " + midLabel + ";\n" 
  + blockCommandIf.translation + "\tgoto " + endLabel+ ";\n" 
  + "\t" + midLabel + ":\n" + blockCommandElse.translation 
  + "\t" +endLabel + ":\n";

  return actual;
}


Attribute makeIfTernary(Attribute actual, Attribute left, Attribute expression, Attribute right1,  Attribute right2)
{
  Symbol symbol = getSimboloAnywere(left.label);
  left.label = symbol.label; left.type = symbol.type;

  Attribute auxActual = createActualAttribute(left.type);
  addSimboloScope(StackContext, auxActual.label, auxActual.type, actual);

  Attribute blockCommandIf = makeAtribuicao(auxActual, left, right1, "=");
  Attribute blockCommandElse = makeAtribuicao(auxActual, left, right2, "=");

  return makeIfElse(actual, expression, blockCommandIf, blockCommandElse);  
}


// Switch Case ______________________________________________________________________________

stack<Switcher> switcherStack;

Attribute iniciarSwitch(Attribute actual, Attribute blockSwitch)
{
  actual.translation = blockSwitch.translation;
  switcherStack.pop();
  return actual;
}

void createSwicher(Attribute searchVariable)
{
  Switcher switcher;
  switcher.endLabel = createGotoLabel();
  switcher.nextLabel = createGotoLabel();

  Symbol symbol = getSimboloAnywere(searchVariable.label);
  
  switcher.searchVariable = symbol;
  switcherStack.push(switcher);
}

void finalizeSwitcher()
{
  switcherStack.pop();
}

Attribute resolveBlockSwitch(Attribute actual, Attribute cases, Attribute blockCommand)
{
  actual.translation = "\t//*switch init*//\n"
  + cases.translation
  + "\t//*default*//\n"
  + blockCommand.translation
  + "\t" + switcherStack.top().endLabel + ":\n"
  + "\t//*switch end*//\n";
  return actual;
}

Attribute resolveCasesSwitch(Attribute actual, Attribute variableSwitch, Attribute blockCommandCase, Attribute cases)
{
  Switcher topStack = switcherStack.top();

  actual.translation = variableSwitch.translation
  + "\t" + variableSwitch.label + " = !" + variableSwitch.label + ";\n"
  + "\tif(" + variableSwitch.label + ") goto " + topStack.nextLabel + ";\n"
  + blockCommandCase.translation
  + "\tgoto " + topStack.endLabel + ";\n"
  + "\t" + topStack.nextLabel + ":\n" + cases.translation;

  switcherStack.top().nextLabel = createGotoLabel();

  return actual;
}

Attribute resolveCheckerSwitch(Attribute actual, string operador, Attribute variable)
{
  Switcher topStack = switcherStack.top();

  Attribute comparator;
  comparator.type = topStack.searchVariable.type;
  comparator.label = getSimboloAnywere(topStack.searchVariable.label).name;

  return resolveTipoExpressao(comparator, operador, variable);
}
