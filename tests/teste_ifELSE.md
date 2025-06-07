# Teste: Comando `if-else`

## Descrição

Este teste valida a estrutura completa do comando condicional `if-else`. O foco é verificar o comportamento do compilador na geração da lógica de desvio, garantindo que, dependendo da condição booleana, apenas um dos blocos (o do `if` ou o do `else`) seja executado.

### Código na Linguagem
```c
int B;
B = 5;
if (B > 100) {
  B = 1;
} else {
  B = 0;
}
```

## Observações
- A gramática deve reconhecer a sintaxe if (condição) { bloco_if } else { bloco_else } como um comando único e válido.
- A avaliação da condição (B > 100) deve gerar um salto condicional para o rótulo que inicia o bloco else (ex: if_false T_cond goto L_else).
- Após o bloco de código do if, um salto incondicional (goto L_fim) deve ser gerado para pular o bloco else e continuar a execução normal.
- O compilador precisa gerar e gerenciar dois rótulos distintos: um para o início do else e outro para o fim de toda a estrutura condicional.
- Um erro comum a ser verificado é se o compilador gera o goto L_fim no final do bloco if. Sem ele, ambos os blocos poderiam ser executados quando a condição é verdadeira.