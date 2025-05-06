# Teste: Operadores Lógicos

## Descrição

Este teste verifica se o compilador gera corretamente o código intermediário para **expressões com operadores lógicos**, incluindo a negação (`!`) e a conjunção (`&&`), respeitando a compatibilidade de tipos booleanos.

### Código na Linguagem

```c
bool B1;
bool B2;
bool R;

R = B1 && !B2;

```

### Código Intermediário Esperado do Braida

```c

int T1;
int T2;
int T3;
int T4;
int T5;

T2 = !T1;
T4 = T3 && T2;
T5 = T4;

```
### Nosso Código Intermediário Gerado 

```c

int T1;
int T2;
int T3;
int T4;
int B1;
int B2;
int R;

T1 = B1;
T2 = B2;
T3 = !T2;
T4 = T1 && T3;
R = T4;

```

## Observações:

- No nosso compilador, primeiro salvamos o valor de B1 na variável T1 e o valor de B2 na T2.
- Depois, usamos T2 para fazer !B2, que significa "não B2", e guardamos isso em T3.
- Em seguida, fazemos B1 && !B2 (ou seja, T1 && T3) e guardamos o resultado em T4, que depois é usado para atualizar R.
- No código do professor Braida, ele usa nomes de variáveis temporárias diferentes, mas a lógica é igual: ele também faz B1 && !B2.
- Conclusão: o resultado final do nosso compilador está certo — ele entende e executa corretamente a operação lógica, mesmo que escreva os passos de maneira diferente.
