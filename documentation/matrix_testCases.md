# Compiler Group L Language Documentation 

## Glossary

| Reserved Word | Common Use | Obs |
|--- |--- |--- |
| integer | int | --- |


### Examples of Matrices

```cpp
// Error
// Message: "The matrix column size must be an integer type."

integer matrix[1][2.8];

matrix[1][1] = 8;
```

```cpp
// Correct

integer matrix[1][2];

matrix[1][1] = 8;
```


```cpp
// Correct

integer size = 2.80;
integer matrix[size][2];

matrix[1][1] = 8;
```


```cpp
// Correct

integer matrix[3.5 como integer][2];

matrix[1][1] = 8;
```


```cpp
// Correct

integer matrix[5][5];
integer somador;
integer result;

iterate (var i = 0; i < 5; i++)
{
    iterate (var j = 0; j < 5; j++)
    {
        somador++;
        matrix[i][j] = somador;
    }
}

iterate (var i = 0; i < 5; i++)
{
    iterate (var j = 0; j < 5; j++)
    {
        result = matrix[i][j];
        show(result);
    }
}
```

```cpp
// Correct

integer matrix[5][5];
matrix[2][4] = 8;
integer result;
show(matrix[2][4]);
```