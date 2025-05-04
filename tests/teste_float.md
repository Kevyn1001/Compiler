# Teste: Suporte ao Tipo Float

## Descrição

Este teste verifica se o compilador trata corretamente o tipo `float` em expressões. Para isso, é necessário que a tabela de símbolos armazene o tipo da variável e que o tipo resultante seja propagado entre os nós da expressão.

### Código na Linguagem

```c
int A;
A = (A + 2) * 3.0;

```

### Código Intermediário Esperado do Braida

```c

int T1;
int T2;
int T3;
float T4;
int T5;
T2 = 2;
T3 = T1 + T2;
T4 = 3.0;
T5 = T4 * T3;
A = T5;

```
### Nosso Código Intermediário Gerado 

```c
int T1;
int T2;
int T3;
float T4;
int T5;
int A;
T1 = A;
T2 = 2;
T3 = T1 + T2;
T4 = 3.0;
T5 = T3 * T4;
A = T5;

```

## Observações:

- O compilador está identificando corretamente o tipo float e propagando esse tipo no nó correspondente à constante 3.0.
- Nosso código intermediário está semanticamente correto e o tipo float é utilizado apenas onde necessário.
- A ordem das operações e a declaração das variáveis está clara e correta.
