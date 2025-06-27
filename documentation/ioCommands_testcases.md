# Compiler Group L Language Documentation 

## Glossary

| Reserved Word | Common Use | Obs |
|--- |--- |--- |
| text | string | --- |
| read | cout | --- |
| show | cin.getline | --- |


### Examples of IO Commands

```cpp
// Correct

text teste;
read(teste);
```

```cpp
// Error
// Message: "This function with these parameters is only accepted for the string type."

integer teste;
read(teste, 60);
```

```cpp
// Error
// Message: "This function with these parameters not accepted bool type."

bolean teste;
read(teste);
```


```cpp
// Error
// Message: "Variable not found."

read(teste);
```

```cpp
// Correct

text teste;
read(teste, 60);

text teste0;
read(teste0);


letter teste1;
read(teste1);

integer teste2;
read(teste2);

floating teste3;
read(teste3);
```

```cpp
// Correct

text nome;
nome = "gabi";
show(nome);
```
