# Teste: Operadores Relacionais

## Descrição

Este teste verifica se o compilador lida corretamente com **operadores relacionais** (`<`, `<=`, `>`, `>=`, `==`, `!=`). O resultado de uma operação relacional deve ser tratado como um valor lógico (`int`).

### Código na Linguagem

```c
bool R;
R = 3 < 5;

```

### Código Intermediário Esperado do Braida

```c

int T1;
int T2;
int T3;
int T4;
T1 = 3;
T2 = 5;
T3 = T1 < T2;
T4 = T3;

```
### Nosso Código Intermediário Gerado 

```c
int T1;
int T2;
int T3;
int R;
T1 = 3;
T2 = 5;
T3 = T1 < T2;
R = T3;

```

## Observações:

- O compilador está gerando corretamente os valores temporários para cada parte da comparação.
- A variável R é atribuída com o valor lógico T3, representando o resultado de 3 < 5.
- O código está semanticamente correto, e a diferença entre int T4 e int R é apenas uma escolha de nomes.
