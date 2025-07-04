#ifndef SYSTEM_H
#define SYSTEM_H

#include <iostream>
#include <unordered_map>
#include <cmath>
#include "utils.hpp"
#include "type.hpp"
#include "symbols.hpp"
#include "coercao.hpp"
#include "assignment.hpp"
#include "expression.hpp"
#include "explicitConversion.hpp"
#include "scope.hpp"
#include "decisionCommands.hpp"
#include "loopCommands.hpp"
#include "loopUtils.hpp"
#include "foreach.hpp"
#include "loopControls.hpp"
#include "ioCommands.hpp"
#include "functionDefinition.hpp"
#include "functionDeclaration.hpp"
#include "functionCall.hpp"
#include "vector.hpp"
#include "matrix.hpp"

using namespace std;

string iniciate();
string getDefines();
string getTemps();
string getGlobalVariabels();
string getCurrentBlockSymbols();
string getVisibleSymbols();

#endif