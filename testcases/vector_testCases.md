 # Teste: Vetores e Tipos de Tamanho

 ## Descrição

 Este teste verifica se o compilador reconhece corretamente o uso de vetores, especialmente quanto ao **tipo do tamanho do vetor** (que deve ser inteiro), além do uso de iterações para manipular e acessar os elementos.

 ### Código na Linguagem

 ```
 // Erro
 // Mensagem: "The vector size must be an integer type."

 integer vector[3.5];

 vector[1] = 8;
 ```

 ```
 // Correto

 integer size;
 size = 2.80;
 integer vector[2];

 vector[1] = 8;
 ```

 ```
 // Correto

 integer vector[2.8 como integer];

 vector[1] = 8;
 ```

 ```
 // Correto

 integer vector[11];
 integer somador;
 integer i;

 iterate (i; i < 10; i++)
 {
   somador = somador + 1;
   vector[i] = somador;
 }

 i = 0;

 iterate (i; i < 10; i++)
 {
   integer result;
   result = vector[i];
   show(result);
 }
 ```

 ```
 // Correto

 integer vector[11];
 integer somador;

 iterate (var i = 0; i < 10; i++)
 {
   somador = somador + 1;
   vector[i] = somador;
 }

 iterate (integer i = 0; i < 10; i++)
 {
   integer result;
   result = vector[i];
   show(result);
 }
 ```

 ## Observações:

 - O compilador **rejeita tamanhos de vetor que não sejam inteiros**, como `3.5`, com mensagem apropriada.
 - Quando se usa um valor `float` como tamanho, é necessário aplicar **casting explícito** ou usar um valor já convertido para inteiro.
 - A iteração sobre vetores com `iterate` funciona corretamente, seja com variáveis declaradas previamente ou inline (`var i`).
 - O acesso e atribuição aos índices dos vetores ocorre de forma esperada, com incremento e leitura corretos.
