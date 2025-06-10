# Teste: Uso de Variável Antes da Declaração

## Descrição
Este teste verifica se o compilador detecta o uso de uma variável (A) antes de sua declaração, ou, alternativamente, se assume tipo int por padrão, dependendo da semântica definida.

### Código na Linguagem
```c
A = 5;
int A;
```

### Observações
- O compilador deve sinalizar erro semântico (“variável A não declarada”) ao tentar atribuir antes de declarar.
- Caso a semântica seja “assumir int por padrão”, deve inserir int A; na tabela de símbolos automaticamente e gerar temporário para 5.
- Se não houver verificação de declaração antecipada, pode gerar resultados inesperados.