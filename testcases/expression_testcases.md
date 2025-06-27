 # Teste: Expressões e Operadores

 ## Descrição

 Este teste abrange diferentes tipos de expressões suportadas pela linguagem, incluindo o uso do operador lógico `!`, **concatenação e comparação de strings**, **operadores compostos** (`+=`, `-=`, etc.) e **operadores unários** (`++`, `--`) aplicados a diversos tipos.

 ### Código na Linguagem

 ```
 // Correto - Operador "!" com inteiro

 integer valor;
 valor = 1;
 integer var;
 var = !valor;
 ```

 ```
 // Correto - Operador "!" com inteiro atribuído a boleano

 integer valor;
 valor = 1;
 bolean var;
 var = !valor;
 ```

 ```
 // Correto - Operador "!" com boleano atribuído a inteiro

 bolean valor;
 valor = 1;
 integer var;
 var = !valor;
 ```

 ```
 // Correto - Concatenação de strings

 text a;
 text b;
 text c;
 text d;

 a = "text";
 b = " da ";
 c = "gabi.";
 d = a + b + c;
 ```

 ```
 // Correto - Comparação de strings com >=

 text a;
 text b;
 bolean c;

 a = "text.";
 b = "text";
 c = a >= b; // verdadeiro
 ```

 ```
 // Correto - Comparação de strings com ==

 text a;
 text b;
 bolean c;

 a = "text";
 b = "text";
 c = a == b; // verdadeiro
 ```

 ```
 // Correto - Comparação de strings com resultado falso

 text a;
 text b;
 bolean c;

 a = "text";
 b = "text";
 c = a == b; // falso
 ```

 ```
 // Erro - Operador composto com expressão
 // Mensagem: syntax error

 integer a;
 integer b;
 b = 30;

 a += b + 1;
 ```

 ```
 // Correto - Operadores compostos

 integer c;
 integer d;
 c = 2;
 d = 30;

 c += d;
 show(c); // 32

 integer e;
 integer f;
 e = 3;
 f = 30;

 e -= f;
 show(e); // -27

 integer g;
 integer h;
 g = 4;
 h = 30;

 g *= h;
 show(g); // 120

 integer i;
 integer j;
 i = 5;
 j = 30;

 i /= j;
 show(i); // 0
 ```

 ```
 // Correto - Operadores unários

 integer a;
 a = 20;

 a ++;
 a --;

 show(a); // 20

 floating b;
 b = 10.5;

 b--;
 show(b); // 9.5

 letter c;
 c = 'G';

 c--;
 show(c); // F

 bolean d;
 d = verdadeiro;

 d--;
 show(d); // 0 == falso
 ```

 ## Observações:

 - O operador `!` pode ser aplicado a `integer` ou `bolean`, retornando o valor negado logicamente.
 - Strings suportam concatenação com `+` e comparações com `==` e `>=`, funcionando como esperado.
 - Operadores compostos funcionam para `+`, `-`, `*` e `/`, mas exigem expressões simples do lado direito.
 - Operadores unários (`++`, `--`) funcionam com tipos como `integer`, `floating`, `letter` e `bolean`, respeitando coerção e resultados esperados.
