# Teste: Atribuição de Float a Int Sem Cast

## Descrição
Verifica se o compilador recusa atribuição direta de um float a uma variável int, exigindo cast explícito ou sinalizando erro de tipos.

### Código na Linguagem
```c
int I;
float F;
I = F;
```

### Observações
- O compilador deve alertar “Tipos incompatíveis para atribuição: float → int” se não houver cast.
- Se permitir conversão implícita sem cast, gerará temporário de F e converterá (int) F.
- Caso contrário, interrompe a compilação com mensagem de erro.