# Compiler Group L Language Documentation 

## Glossary

### Types
| Reserved Word | Common Use | Obs |
|--- |--- |--- |
| integer | int | --- |
| floating | float | --- |
| letter | char | --- |
| bolean | bool | --- |
| text | string | --- |

### Logical operators
| Reserved Word | Name | Obs |
|--- |--- |--- |
| ! | not | --- |
| || | or | --- |
| && | and | --- |

### Relational operators
| Reserved Word | Name | Obs |
|--- |--- |--- |
| == | equal | --- |
| != | different | --- |
| > | bigger | --- |
| < | smaller | --- |
| >= | bigger or equal | --- |
| <= | less or equal | --- |

### Arithmetic operators
| Reserved Word | Name | Obs |
|--- |--- |--- |
| + | sum | --- |
| - | subtraction | --- |
| * | multiplication | --- |
| / | division | --- |
| % | module | --- |

### String operators
| Reserved Word | Name | Obs |
|--- |--- |--- |
| + | concatenation | --- |
| == | equal | It is case sensitive. |
| != | different | It is case sensitive. |
| > | bigger | --- |
| < | smaller | --- |
| >= | bigger or equal | --- |
| <= | less or equal | --- |


### Examples Expressions

#### Operador "!" - Not

```cpp
// Correct

integer valor;
valor = 1;
integer var;
var = !valor;

```

```cpp
// Correct

integer valor;
valor = 1;
bolean var;
var = !valor;

```

```cpp
// Correct

bolean valor;
valor = 1;
integer var;
var = !valor;

```

### String concatenation

```cpp
// Correct

text a;
text b;
text c;
text d;

a = "text";
b = " da ";
c = "gabi.";
d = a + b + c;

```

### String operations

```cpp
// Correct

text a;
text b;
bolean c;

a = "text.";
b = "text";
c = a >= b; // verdadeiro

```

```cpp
// Correct

text a;
text b;
bolean c;

a = "text";
b = "text";
c = a == b; // verdadeiro

```


```cpp
// Correct

text a;
text b;
bolean c;

a = "text";
b = "text";
c = a == b; // falso

```

### Compoused operator

```cpp
// Error
// Message: syntax error 

integer a;
integer b;
b = 30;

a += b + 1;

```

```cpp
// Correct

integer c;
integer d;
c = 2;
d = 30;

c += d;

show(c); // 32



integer e;
integer f;
e = 3;
f = 30;

e -= f;

show(e); // -27



integer g;
integer h;
g = 4;
h = 30;

g *= h;

show(g); // 120



integer i;
integer j;
i = 5;
j = 30;

i /= j;

show(i); // 0

```

### Unary operator

```cpp
// Correct

integer a;
a = 20;

a ++;
a --;

show(a); // 20

floating b;
b = 10.5;

b--;

show(b); // 9.5

letter c;
c = 'G';

c--;

show(c); // F

bolean d;
d = verdadeiro;

d--;
show(d); // 0 == falso

```
