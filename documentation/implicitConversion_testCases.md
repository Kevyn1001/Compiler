# Compiler Group L Language Documentation 

## Glossary

| Reserved Word | Common Use | Obs |
|--- |--- |--- |
| integer | int | --- |
| floating | float | --- |
| letter | char | --- |


### Examples of Implicit Convercion

```cpp
// Error
// Message: "Cannot convert type float to type char.

letter aaa;
aaa = 'g';
integer bbb;
bbb = 10;

{
	floating i;
	i = 1.9;

	i = aaa;
}
```

```cpp
// Correct

letter aaa;
aaa = 'g';
integer bbb;
bbb = 10;

{
	floating i;
	i = 1.9;

	i = bbb;
}
```