 # Teste: Funções, Sobrecarga e Chamada de Funções

 ## Descrição

 Este teste verifica a **declaração e chamada de funções**, incluindo suporte a **sobrecarga**, **funções aninhadas** e **tratamento de tipos nos parâmetros**. Também cobre casos em que é necessário realizar **conversão explícita** antes da chamada.

 ### Código na Linguagem

 ```
 // Correto - Função simples

 funcao floating c (floating a, integer b)
 {
     var result = a + b;
     returns result;
 }
 ```

 ```
 // Correto - Acessa variável `b` do escopo externo

 funcao floating c (floating b, integer d, text e)
 {
     b = 3;
     returns b;

     funcao floating c (floating k, integer d)
     {
         b = 3;
         returns b;
     }
 }
 ```

 ```
 // Correto - Acessa variável `b` do escopo atual (sombreamento)

 funcao floating c (floating b, integer d, text e)
 {
     b = 3;
     returns b;

     funcao floating c (floating k, integer b)
     {
         b = 3;
         returns b;
     }
 }
 ```

 ```
 // Correto - Sobrecarga com parâmetros na mesma ordem, mas tipos diferentes

 funcao floating c (floating b, integer d, text e)
 {
     b = 3;
     returns b;

     funcao floating c (floating b, text e, integer d)
     {
         b = 3;
         returns b;
     }
 }
 ```

 ### Exemplo de Chamadas de Função

 ```
 // Erro
 // Mensagem: "Function c (float, float); is not found."

 funcao floating c (floating a, integer b)
 {
     var result = a + b;
     returns result;
 }

 letter a;
 a = c (2.9, 5.8);
 show(a);
 ```

 ```
 // Correto

 funcao floating c (floating a, integer b)
 {
     var result = a + b;
     returns result;
 }

 integer a;
 a = c (2.9, 5);
 show(a); // 7
 ```

 ```
 // Erro
 // Mensagem: "Cannot convert type char to type float."

 funcao floating c (floating a, integer b)
 {
     var result = a + b;
     returns result;
 }

 letter a;
 a = c (2.9, 5);
 show(a);
 ```

 ## Observações:

 - A linguagem suporta **sobrecarga de funções** com o mesmo nome, desde que os parâmetros tenham ordens ou tipos diferentes.
 - É permitido **aninhar funções** dentro de outras funções, com acesso ao escopo externo ou com sombreamento de variáveis.
 - A chamada da função deve respeitar os tipos esperados nos parâmetros.
 - Em caso de incompatibilidade de tipos, é necessário realizar **casting explícito** antes da chamada, caso contrário o compilador emite erro.
