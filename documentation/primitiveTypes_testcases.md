# Compiler Group L Language Documentation 

## Glossary

| Reserved Word | Common Use | Obs |
|--- |--- |--- |
| integer | int | --- |
| floating | float | --- |
| letter | char | --- |
| bolean | bool | --- |
| text | string | --- |
| var | var | type inference |


### Example of Type Inference

```cpp
// Correct

var i = 40.7;
var num = 50;
var valor = 60 + 4 - 90;

```

### Examples of Primitive Types

```cpp
// Error
// Message: TK_ID 'f' is not declared. Please defines a type to 'f'.

integer a;
a = 1;

floating b;
b = 3.5;

bolean c;
c = verdadeiro;

letter d;
f = 'G';
```

```cpp
// Correct

integer a;
a = 1;

floating b;
b = 3.5;

bolean c;
c = verdadeiro;

letter d;
d = 'G';
```

```cpp
// Error
// Message: The operation is not set to string and int

text aa;
aa = "gabi";

text bb;
bb = aa;

integer cc;
cc = 1;

aa = cc;
```

```cpp
// Correct

text aa;
aa = "gabi";

text bb;
bb = aa;
```
