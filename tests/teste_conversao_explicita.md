# Teste: Conversão Explícita

## Descrição

Este teste verifica se o compilador gera corretamente o código intermediário para **expressões com casting explícito** (conversões forçadas entre tipos), como `(int)` ou `(float)`.

### Código na Linguagem

```c
int I;
float F;

I = (int) F;

```

### Código Intermediário Esperado do Braida

```c

float T1;
float T2;
int T3;
int T4;

T2 = T1;
T3 = (int) T2;
T4 = T3;

```
### Nosso Código Intermediário Gerado 

```c

float T1;
int T2;
int I;
float F;

T1 = F;
T2 = (int) T1;
I = T2;

```

## Observações:

- O compilador reconheceu corretamente a necessidade da conversão explícita de float para int com o uso do cast (int).
- Primeiro, o valor de F é carregado em T1, que representa a leitura da variável float.
- Depois, T1 é convertido para int com o cast, sendo armazenado em T2.
- Por fim, o resultado é atribuído à variável I, que é do tipo int.
- O código do Braida tem uma divisão um pouco mais granular nas temporárias, mas a lógica da conversão e atribuição está idêntica.
