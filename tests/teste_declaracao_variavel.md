# Teste: Declaração de Variável

## Descrição

Este teste verifica se o compilador cria corretamente uma **tabela de símbolos** e gera a declaração das cédulas de memória (variáveis) antes da utilização em expressões.

### Código na Linguagem

```c
int A;
A = (A + 2) * 3;

```

### Código Intermediário Esperado do Braida

```c

int T1;
int T2;
int T3;
int T4;
int T5;
T2 = 2;
T3 = T1 + T2;
T4 = 3;
T5 = T4 * T3;
T1 = T5;

```
### Nosso Código Intermediário Gerado 

```c
int T1;
int T2;
int T3;
int T4;
int T5;
int A;
T1 = A;
T2 = 2;
T3 = T1 + T2;
T4 = 3;
T5 = T3 * T4;
A = T5;

```

## Observações:

- A declaração explícita da variável A está sendo feita corretamente com o uso da tabela de símbolos.
- O compilador utiliza T1 para carregar o valor de A, e depois realiza a atribuição final corretamente.
