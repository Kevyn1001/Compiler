# Compiler Group L Language Documentation 

## Glossary

| Reserved Word | Common Use | Obs |
|--- |--- |--- |
| integer | int | --- |


### Examples of Vectors

```cpp
// Errpr
// Message: "The vector size must be an integer type."

integer vector[3.5];

vector[1] = 8;
```

```cpp
// Correct

integer size;
size = 2.80;
integer vector[2];

vector[1] = 8;
```

```cpp
// Correct

integer vector[2.8 como integer];

vector[1] = 8;
```

```cpp
// Correct

integer vector[11];
integer somador;
integer i;

iterate (i; i < 10; i++)
{
  somador = somador + 1;
  vector[i] = somador;
}

i = 0;

iterate (i; i < 10; i++)
{
  integer result;
  result = vector[i];
  show(result);
}
```

```cpp
// Correct

integer vector[11];
integer somador;

iterate (var i = 0; i < 10; i++)
{
  somador = somador + 1;
  vector[i] = somador;
}

iterate (integer i = 0; i < 10; i++)
{
  integer result;
  result = vector[i];
  show(result);
}
```
