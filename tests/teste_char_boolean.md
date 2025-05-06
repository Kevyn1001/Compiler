# Teste: Tipos char e boolean

## Descrição

Este teste verifica se o compilador consegue declarar e utilizar corretamente variáveis dos tipos `char` e `boolean`. O tipo `boolean` deve ser tratado como `int` no código intermediário.

### Código na Linguagem

```c
char C;
C = 'a';

bool B;
B = true;

```

### Código Intermediário Esperado do Braida

```c

char T1;
int T2;
T1 = 'a';
T2 = 1;

```
### Nosso Código Intermediário Gerado 

```c

char T1;
int T2;
char C;
int B;
T1 = 'a';
C = T1;
T2 = 1;
B = T2;

```

## Observações:

- O compilador está declarando corretamente as variáveis C e B com seus respectivos tipos.
- A variável temporária T1 armazena o caractere 'a', que depois é atribuída a C, assim como T2 com o valor booleano true (convertido para 1), que é atribuído a B.
- A abordagem está correta e mantém a rastreabilidade entre variáveis temporárias e originais.
