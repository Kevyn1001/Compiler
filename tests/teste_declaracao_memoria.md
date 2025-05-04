# Teste: Operadores Aritméticos

## Descrição

Este teste verifica se o compilador gera corretamente o código intermediário para **expressões que misturam operadores aritméticos com diferentes precedências**, como soma e multiplicação.

### Código na Linguagem

```c
1 + 2 * 3;

```

### Código Intermediário Esperado do Braida

```c

T1 = 2;
T2 = 3;
T3 = T1 * T2;
T4 = 1;
T5 = T4 + T3;
```
### Nosso Código Intermediário Gerado 

```c
int T1;
int T2;
int T3;
int T4;
int T5;
T1 = 1;
T2 = 2;
T3 = 3;
T4 = T2 * T3;
T5 = T1 + T4;
```

## Observações:

- O compilador respeita corretamente a precedência dos operadores.
- A multiplicação é realizada antes da soma, mesmo com ordem diferente de criação das variáveis temporárias.
- O resultado final é semanticamente equivalente ao esperado.
