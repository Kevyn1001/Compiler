 # Teste: Conversão Implícita com `como`

 ## Descrição

 Este teste verifica se o compilador reconhece corretamente a **conversão implícita com o uso da palavra-chave `como`**, permitindo que valores de um tipo sejam convertidos para outro, como de `float` para `int`, de forma controlada.

 ### Código na Linguagem

 ```
 // Correto

 floating valor;
 valor = 10.50;

 {
 	integer var;
 	var = valor como integer - 20;
 }
 ```

 ## Observações:

 - A conversão `valor como integer` indica ao compilador que o valor de `valor` (float) deve ser convertido para `integer`.
 - O compilador deve gerar código intermediário que aplique o cast antes de subtrair `20`.
 - Esse padrão evita erros de tipo ao misturar expressões de tipos diferentes, promovendo segurança e clareza.
 - O uso de `como` é uma forma explícita, porém amigável, de se realizar conversões.
