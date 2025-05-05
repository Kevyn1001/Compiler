# Teste: Conversão Implícita

## Descrição

Este teste verifica se o compilador gera corretamente o código intermediário para **expressões mistas com `int` e `float`**, aplicando a **conversão implícita de `int` para `float`** quando necessário.

### Código na Linguagem

```c
float F;
int I;

F = I + 2.5;

```

### Código Intermediário Esperado do Braida

```c

int T1;
float T2;
float T3;
float T4;
float T5;

T2 = (float) T1;
T3 = 2.5;
T4 = T2 + T3;
T5 = T4;

```
### Nosso Código Intermediário Gerado 

```c

int T1;
float T2;
float T3;
float T4;
float F;
int I;

T1 = I;
T2 = 2.5;
T3 = (float) T1;
T4 = T3 + T2;
F = T4;

```

## Observações:

- O compilador gerou corretamente os temporários com os tipos certos (int, float).
- O valor inteiro da variável I foi armazenado em T1 e depois convertido para float em T3.
- A constante 2.5 foi atribuída diretamente a T2, e a soma foi feita em T4 com dois valores float.
- A variável F recebeu corretamente o resultado final em T4.
- A ordem das instruções está diferente da usada pelo professor Braida, mas a lógica e o tipo final estão corretos.
- O compilador está funcionando corretamente para este teste de conversão implícita int → float.
