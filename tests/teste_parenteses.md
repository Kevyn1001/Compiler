# Teste: Uso de Parênteses

## Descrição

Este teste verifica se o compilador respeita corretamente os parênteses nas expressões, forçando a **soma ser avaliada antes da multiplicação**.

### Código na Linguagem

```c
(1 + 2) * 3;

```

### Código Intermediário Esperado do Braida

```c

int T1;
int T2;
int T3;
int T4;
int T5;
T1 = 1;
T2 = 2;
T3 = T1 + T2;
T4 = 3;
T5 = T4 * T3;

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
T3 = T1 + T2;
T4 = 3;
T5 = T3 * T4;

```

## Observações:

- O compilador está respeitando corretamente os parênteses e a ordem de avaliação.
- Apesar da ordem dos operandos na multiplicação estar invertida, a operação é comutativa, logo o resultado é o mesmo.
