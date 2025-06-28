 # Teste: Comandos de Entrada e Saída (`read` / `show`)

 ## Descrição

 Este teste verifica o comportamento do compilador ao lidar com os comandos de entrada (`read`) e saída (`show`) para diferentes tipos de variáveis. Também verifica o tratamento de erros quando os parâmetros não são adequados ou quando a variável não foi declarada.

 ### Código na Linguagem

 ```
 // Correto

 text teste;
 read(teste);
 ```

 ```
 // Erro
 // Mensagem: "This function with these parameters is only accepted for the string type."

 integer teste;
 read(teste, 60);
 ```

 ```
 // Erro
 // Mensagem: "This function with these parameters not accepted bool type."

 bolean teste;
 read(teste);
 ```

 ```
 // Erro
 // Mensagem: "Variable not found."

 read(teste);
 ```

 ```
 // Correto

 text teste;
 read(teste, 60);

 text teste0;
 read(teste0);

 letter teste1;
 read(teste1);

 integer teste2;
 read(teste2);

 floating teste3;
 read(teste3);
 ```

 ```
 // Correto

 text nome;
 nome = "gabi";
 show(nome);
 ```

 ## Observações:

 - O comando `read` aceita `text`, `letter`, `integer` e `floating`, com ou sem tamanho adicional dependendo do tipo.
 - A tentativa de uso com `bolean` ou tipos não permitidos gera erro de compilação.
 - A leitura para variáveis não declaradas também gera erro: "Variable not found".
 - O comando `show` imprime corretamente valores de variáveis previamente atribuídas.
