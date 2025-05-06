# Teste: Soma de Inteiros

## Descrição

Este teste verifica se o compilador gera corretamente o código intermediário para **expressões com soma encadeada de inteiros**.

### Código na Linguagem

```c
1 + 2 + 3;
```

### Código Intermediário Esperado do Braida

```c

T1 = 2;
T2 = 3;
T3 = T1 + T2;
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
T3 = T1 + T2;
T4 = 3;
T5 = T3 + T4;
```

## Observações:

- O compilador está funcionando corretamente, embora a ordem das atribuições esteja diferente.
- Ambas as versões geram o mesmo resultado final e respeitam a semântica da soma.
