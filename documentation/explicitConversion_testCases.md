# Compiler Group L Language Documentation 

## Glossary

| Reserved Word | Common Use | Obs |
|--- |--- |--- |
| integer | int | --- |
| floating | float | --- |
| como | as | --- |


### Examples of Implicit Convercion

```cpp
// Correct

floating valor;
valor = 10.50;

{
	integer var;
	var = valor como integer - 20;
}

```