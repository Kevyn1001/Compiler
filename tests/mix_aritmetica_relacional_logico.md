# Teste: Mix de Aritmética, Relacional e Lógico

## Descrição

Este teste verifica se o compilador respeita corretamente a precedência entre operadores aritméticos (* antes de +), operadores relacionais (>=, <) e operadores lógicos (&&), além de testar a mistura de tipos int e float dentro de uma mesma expressão.

### Código na Linguagem
```c
int A;
float B;
bool R;
R = (A + 2 * B) >= 10.5 && A < (B - 1);
```

## Observações
- O compilador deve gerar temporários para A, 2, B, 10.5, (B - 1), etc.
- Deve aplicar conversão implícita de int para float quando 2 * B for calculado.
- O parser precisa avaliar 2 * B antes de A + (resultado), depois comparar (A + 2*B) >= 10.5 e A < (B-1) antes de aplicar o &&.
- Caso a precedência ou a conversão falhe, deve emitir erro de tipos ou gerar árvore incorreta.