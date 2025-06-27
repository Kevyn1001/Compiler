 # Teste: Escopo de Variáveis

 ## Descrição

 Este teste verifica se o compilador reconhece corretamente **declarações duplicadas de variáveis** no mesmo escopo e **permite sombreamento de variáveis** em escopos internos. O objetivo é garantir que variáveis declaradas em blocos internos não entrem em conflito com declarações externas.

 ### Código na Linguagem

 ```
 // Erro
 // Mensagem: "Error! TK_ID 'i' declared twice."

 integer i;
 i = 1;

 integer i;
 ```

 ```
 // Correto

 integer i;
 i = 1;

 {
   integer i;
   i = 2;
 }
 ```

 ## Observações:

 - O compilador deve impedir que uma mesma variável seja declarada **duas vezes no mesmo escopo**.
 - A declaração de uma variável com o mesmo nome em **bloco interno** é permitida e representa um **sombreamento de escopo**.
 - Cada bloco `{ ... }` deve criar um novo escopo isolado para variáveis locais.
