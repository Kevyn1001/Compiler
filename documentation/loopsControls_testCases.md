# Compiler Group L Language Documentation 

## Glossary

| Reserved Word | Common Use | Obs |
|--- |--- |--- |
| integer | int | --- |
| floating | float | --- |
| iterate | for | --- |
| during | while | --- |

### Examples of Loops Control

#### Break

```cpp
// Correct

integer i;
integer somador;

iterate (i; i < 10; i = i + 1)
{
  somador = somador + 1;
  break;
}
```

```cpp
// Correct

integer i;
integer k;
k = 10;
integer somador;

during (i >= k)
{
  somador = i + 2;
  break;
  i = i + 1;
}

k = 0;
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
  break;
}
during(i <= k)
```


#### Continue


```cpp
// Correct

integer i;
floating num;
integer valor;

iterate (i; i < 10; i = i + 1)
{  
  check(num == 2.0)
  {
    valor = 20;
    break;
  }
  elsa
  {
    valor = 30;
  }
  num = 2.0;
  continue;
}
```

```cpp
// Correct


integer i;
integer k;
k = 50;
integer somador;
integer valor;

during (i <= k)
{
  i = i + 1;
  check (i == 5)
  {
    i = 50;
    continue;
  }
  valor = valor + 2;
}

k = 0;
```


```cpp
// Correct 

integer i;
integer k;
k = 10;

integer somador;

execute 
{
  continue;
  i = i + 1;
}
during(i <= k)
```
