# Compiler Group L Language Documentation 

## Glossary

| Reserved Word | Common Use | Obs |
|--- |--- |--- |
| integer | int | --- |


### Examples of Scope

```cpp
// Error
// Message: "Error! TK_ID 'i' declared twice."

integer i;
i = 1;

integer i;
```

```cpp
// Correct

integer i;
i = 1;

{
  integer i;
  i = 2;
}
```