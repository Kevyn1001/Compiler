 # Teste: Estruturas Condicionais `check`/`elsa` e Operador Ternário

 ## Descrição

 Este teste verifica o funcionamento das **estruturas condicionais `check` e `elsa`** (equivalentes a `if` e `else`) e também o uso do **operador ternário**, que permite decidir entre dois valores com base em uma condição.

 ### Código na Linguagem

 ```
 // Erro
 // Mensagem: "TK_ID 't' is not declared. Please defines a type to 't'."

 integer i;
 i = 1;
 check(i == 1)
 {
   integer valor;
   valor = 2;
 }
 elsa
 {
   bolean t;
 }
 floating b;
 b = 10.0;
 t = verdadeiro;
 ```

 ```
 // Correto

 integer i;
 i = 1;
 check(i == 1)
 {
   integer valor;
   valor = 2;
 }
 elsa
 {
   bolean t;
   t = verdadeiro;
 }
 floating b;
 b = 10.0;
 ```

 ### Uso do operador ternário com `check`/`elsa`

 ```
 // Correto

 floating valor;
 integer i;
 i = 5;

 valor = (i != 5) ? 2.7 : 3;

 show(valor); // 3
 ```

 ```
 // Correto

 floating valor;
 integer i;
 i = 5;

 valor = (i == 5) ? 2.7 : 3;

 show(valor); // 2.7
 ```

 ```
 // Correto

 floating valor;
 floating a;
 integer b;
 integer i;

 a = 2.7;
 b = 3;
 i = 5;

 valor = (i == 5) ? a : b;

 show(valor); // 2.7
 ```

 ## Observações:

 - A estrutura `check` funciona como um `if`, e `elsa` como `else`.
 - Toda variável usada nos blocos deve ser **declarada antes de ser utilizada**, mesmo após um `elsa`.
 - O operador ternário `(condição) ? valor1 : valor2` permite definir valores com base em expressões booleanas.
 - A linguagem aceita tipos mistos no ternário, desde que haja coerção implícita ou explícita.
