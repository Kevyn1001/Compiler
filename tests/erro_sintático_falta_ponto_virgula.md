# Teste: Erro Sintático por Falta de Ponto‐e‐Vírgula

## Descrição
Este teste garante que o compilador detecta corretamente a falta de ; ao final de uma declaração, interrompendo a análise sintática.

### Código na Linguagem
```c
Copiar
Editar
int A
A = 5;
```
### Observações
- Ao ler int A sem o ;, o parser deve emitir erro de sintaxe (“esperado ; após declaração”) e não continuar com A = 5;.
- Não deve gerar código intermediário nem declarar variáveis após o erro.
- Serve para validar as regras de finalização de cada linha no grammar.