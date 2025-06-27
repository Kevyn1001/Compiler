 # Teste: Estruturas de Repetição (`iterate`, `during`, `execute during`)

 ## Descrição

 Este teste avalia o comportamento das estruturas de laço da linguagem, incluindo o laço `iterate` (equivalente ao `for`), `during` (equivalente ao `while`) e `execute during` (equivalente ao `do while`). Também é verificado o suporte à variação `foreach` no `iterate`.

 ### Código na Linguagem

 #### iterate (For)

 ```
 // Erro
 // Mensagem: ""
 ```

 ```
 // Correto

 integer i;
 integer somador;

 iterate (i; i < 10; i = i + 1)
 {
   somador = somador + 1;
 }
 ```

 ```
 // Correto

 integer matrix[5][5];
 integer somador;
 integer result;

 iterate (var i = 0; i < 5; i++)
 {
     iterate (var j = 0; j < 5; j++)
     {
         somador++;
         matrix[i][j] = somador;
     }
 }

 iterate (var i = 0; i < 5; i++)
 {
     iterate (var j = 0; j < 5; j++)
     {
         result = matrix[i][j];
         show(result);
     }
 }
 ```

 #### iterate Foreach (For)

 ```
 // Correto

 integer vector[5];
 integer somador;
 integer result;

 iterate (integer i : vector)
 {
     somador++;
     vector[i] = somador;
     show(vector[i]);
 }
 ```

 #### during (While)

 ```
 // Erro
 // Mensagem: ""
 ```

 ```
 // Correto

 integer i;
 integer k;
 k = 10;
 integer somador;

 during (i <= k)
 {
   somador = i + 2;
   i = i + 1;
 }

 k = 0;
 ```

 #### execute during (Do While)

 ```
 // Erro
 // Mensagem: ""
 ```

 ```
 // Correto 

 integer i;
 integer k;
 k = 10;

 integer somador;

 execute 
 {
   i = i + 1;
 }
 during(i <= k)
 ```

 ## Observações:

 - A estrutura `iterate` permite tanto o estilo tradicional (`i; i < 10; i++`) quanto o estilo `foreach` com `:`.
 - O `during` representa um laço condicional equivalente ao `while`, onde a condição é testada antes da execução.
 - O `execute during` executa o bloco antes de verificar a condição, sendo equivalente ao `do while`.
 - As estruturas respeitam escopo e funcionam corretamente com variáveis previamente declaradas ou com inferência via `var`.
