# Teste: Atribuição com Expressão

## Descrição

Este teste verifica se o compilador gera corretamente o código intermediário para **atribuições com expressões envolvendo variáveis e constantes**.

### Código na Linguagem

```c
A = (A + 2) * 3;

```

### Código Intermediário Esperado do Braida

```c

int T1;
int T2;
int T3;
int T4;
int T5;
T1 = A;
T2 = 2;
T3 = T1 + T2;
T4 = 3;
T5 = T4 * T3;
A = T5;

```
### Nosso Código Intermediário Gerado 

```c
int T1;
int T2;
int T3;
int T4;
int T5;
T1 = A;
T2 = 2;
T3 = T1 + T2;
T4 = 3;
T5 = T3 * T4;
A = T5;

```

## Observações:

- A ordem dos operandos na multiplicação está invertida, mas o resultado é o mesmo, pois a operação é comutativa.
- A atribuição final está sendo feita corretamente na variável original A.
