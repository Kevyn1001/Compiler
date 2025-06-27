 # Teste: Conversão Implícita de Tipos

 ## Descrição

 Este teste verifica o comportamento do compilador ao realizar **conversões implícitas entre tipos**, especialmente ao atribuir valores de um tipo a uma variável de outro tipo (ex: de `integer` para `floating`). O foco está em garantir que **conversões inválidas sejam rejeitadas** com mensagens de erro apropriadas.

 ### Código na Linguagem

 ```
 // Erro
 // Mensagem: "Cannot convert type float to type char."

 letter aaa;
 aaa = 'g';
 integer bbb;
 bbb = 10;

 {
 	floating i;
 	i = 1.9;

 	i = aaa;
 }
 ```

 ```
 // Correto

 letter aaa;
 aaa = 'g';
 integer bbb;
 bbb = 10;

 {
 	floating i;
 	i = 1.9;

 	i = bbb;
 }
 ```

 ## Observações:

 - O compilador **não permite atribuir um `char` diretamente a um `float`** sem conversão explícita.
 - A conversão implícita de `integer` para `floating` é aceita, pois é considerada segura.
 - A mensagem de erro informa corretamente o tipo de origem (`char`) e o tipo de destino (`float`) incompatíveis.
 - O escopo interno (bloco `{ ... }`) é respeitado na declaração e atribuição das variáveis temporárias.
