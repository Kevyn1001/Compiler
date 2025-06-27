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


### Examples of switch/case


```cpp
// Correct

integer x;
x = 20;
integer z;

switch (x) 
{
  case 10 :
  { 
    z = 3; 
  }
  case 20 :
  { 
    z = 56; 
  }
  default :
  { 
    z = 0;
  }
}
```

```cpp
// Correct

integer x;
x = 20;
integer z;

switch (x) 
{
  case > 10 :
  { 
    z = 1; 
  }
  case < 20 :
  { 
    z = 2; 
  }
  case <= 30 :
  { 
    z = 3; 
  }
  case >= 40 :
  { 
    z = 4; 
  }
  case 50 :
  { 
    z = 5;
  }
  default :
  { 
    z = 0; 
  }
}
```