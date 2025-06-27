# Compiler Group L Language Documentation 

## Glossary

| Reserved Word | Common Use | Obs |
|--- |--- |--- |
| integer | int | --- |
| iterate | for | --- |
| during | while | --- |

### Examples of Loops

#### iterate (For)

```cpp
// Error
// Message: ""

```

```cpp
// Correct

integer i;
integer somador;

iterate (i; i < 10; i = i + 1)
{
  somador = somador + 1;
}
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

#### iterate Foreach (For)
```cpp
// Correct

integer vector[5];
integer somador;
integer result;

iterate (integer i : vector)
{
    somador++;
    vector[i] = somador;
    show(vector[i]);
}

```


#### during (While)

```cpp
// Error
// Message: ""

```

```cpp
// Correct

integer i;
integer k;
k = 10;
integer somador;

during (i <= k)
{
  somador = i + 2;
  i = i + 1;
}

k = 0;
```


#### execute during (Do While)

```cpp
// Error
// Message: ""

```

```cpp
// Correct 

integer i;
integer k;
k = 10;

integer somador;

execute 
{
  i = i + 1;
}
during(i <= k)
```
