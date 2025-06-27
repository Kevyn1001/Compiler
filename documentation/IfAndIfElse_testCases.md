# Compiler Group L Language Documentation 

## Glossary

| Reserved Word | Common Use | Obs |
|--- |--- |--- |
| integer | int | --- |
| floating | float | --- |
| letter | char | --- |
| bolean | bool | --- |
| check | if | --- |
| elsa | else | --- |


### Examples of if/else (check/elsa)


```cpp
// Error
// Message: "TK_ID 't' is not declared. Please defines a type to 't'."

integer i;
i = 1;
check(i == 1)
{
  integer valor;
  valor = 2;
}
elsa
{
  bolean t;
}
floating b;
b = 10.0;
t = verdadeiro;
```

```cpp
// Correct

integer i;
i = 1;
check(i == 1)
{
  integer valor;
  valor = 2;
}
elsa
{
  bolean t;
  t = verdadeiro;
}
floating b;
b = 10.0;
```

### if/else (check/elsa) using ternary operator 

```cpp
// Correct

floating valor;
integer i;
i = 5;

valor = (i != 5) ? 2.7 : 3;

show(valor); // 3

```

```cpp
// Correct

floating valor;
integer i;
i = 5;

valor = (i == 5) ? 2.7 : 3;

show(valor); // 2.7

```

```cpp
// Correct

floating valor;
floating a;
integer b;
integer i;

a = 2.7;
b = 3;
i = 5;

valor = (i == 5) ? a : b;

show(valor); // 2.7
```