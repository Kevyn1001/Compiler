# Teste: Comparação de Float e Int

## Descrição
Este teste confere se o compilador permite comparação relacional entre um float e um int, realizando a conversão implícita de tipos quando necessário, sem exigir cast explícito.

### Código na Linguagem

```c
float F;
int I;
bool R;
R = F == I;
```
### Observações
- Ao comparar F == I, o compilador deve converter I para float antes da comparação.
- Se não houver conversão implícita, deve sinalizar erro de tipos incompatíveis.
- O temporário gerado para I deve aparecer como float Temp = (float) I; Temp2 = F == Temp;.