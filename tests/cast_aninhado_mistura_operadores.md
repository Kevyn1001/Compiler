# Teste: Cast Aninhado e Mistura de Operadores

## Descrição
Confirma que o compilador reconhece casts aninhados e combinações de operadores * e +, aplicando corretamente cada conversão de tipo.

### Código na Linguagem
```c
float F;
int I;
char C;
I = (int)(F * (float) I) + (char) C;
```

### Observações
- Deve primeiro fazer (float) I e multiplicar F * (float) I, armazenar em temporário de float.
- Em seguida, converter esse resultado para int via (int)(...).
- Depois gerar char temporário para C e converter para int ao somar com o outro lado.
- Qualquer erro de precedência ou de tiposCompativeis no cast aninhado deve ser sinalizado.