# Teste: Comando `if` Simples

## Descrição

Este teste verifica a funcionalidade básica do comando condicional `if` (sem o `else`). O objetivo é garantir que o compilador consiga analisar a sintaxe do `if`, avaliar a expressão booleana da condição e gerar o código intermediário correspondente, incluindo o salto condicional e o bloco de comandos a ser executado.

### Código na Linguagem
```c
int A;
A = 10;
if (A == 10) {
  A = 20;
}
```
 
## Observações
- O compilador deve reconhecer a estrutura if (condição) { bloco } como um comando válido.
- A expressão da condição (A == 10) deve ser avaliada primeiro, e seu resultado booleano deve ser armazenado em uma variável temporária.
- Deve ser gerado um código de salto condicional (ex: if_false T_cond goto L_fim) para pular o bloco caso a condição seja falsa.
- O código dentro do bloco (A = 20;) deve ser traduzido e inserido entre a verificação da condição e o rótulo de fim.
- Um erro de sintaxe ocorrerá se a gramática para if ou bloco_comandos estiver incorreta.