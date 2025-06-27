# Compiler Group L Language Documentation 

## Glossary

| Reserved Word | Common Use | Obs |
|--- |--- |--- |
| integer | int | --- |
| floating | float | --- |
| text | string | --- |
| var | var | type inference |
| funcao | function | --- |


### Example of Functions

##### Accepts function overloading and nested functions.

- Simple function

```cpp
//Correct

funcao floating c (floating a, integer b)
{
    var result = a + b;
    returns result;
}
```

Access variable 'b' from outside scope.
```cpp
// Correct 

funcao floating c (floating b, integer d, text e)
{
    b = 3;
    returns b;

    funcao floating c (floating k, integer d)
    {
        b = 3;
        returns b;
    }
}
```

Access variable 'b' from current scope.
```cpp
// Correct 

funcao floating c (floating b, integer d, text e)
{
    b = 3;
    returns b;

    funcao floating c (floating k, integer b)
    {
        b = 3;
        returns b;
    }
}
```

- Function with the same name and the same parameters, but with parameters in different orders.

```cpp
// Correct

funcao floating c (floating b, integer d, text e)
{
    b = 3;
    returns b;

    funcao floating c (floating b, text e, integer d)
    {
        b = 3;
        returns b;
    }
}
```

### Example of Function Calls

##### You must first explicitly convert the argument to the type expected by the function, if necessary.

```cpp
// Error
// Message: "Function c (float, float); is not found."

funcao floating c (floating a, integer b)
{
    var result = a + b;
    returns result;
}

letter a;
a = c (2.9, 5.8);
show(a);

```

```cpp
// Correct

funcao floating c (floating a, integer b)
{
    var result = a + b;
    returns result;
}

integer a;
a = c (2.9, 5);
show(a); // 7

```

```cpp
// Error
// Message: "Cannot convert type char to type float."

funcao floating c (floating a, integer b)
{
    var result = a + b;
    returns result;
}

letter a;
a = c (2.9, 5);
show(a);

```
