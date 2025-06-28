 # Teste: Inferência de Tipos e Tipos Primitivos

 ## Descrição

 Este teste verifica o uso da **inferência de tipos com `var`**, além de validar o comportamento do compilador ao trabalhar com **tipos primitivos** como `integer`, `floating`, `letter`, `bolean` e `text`. Também são testadas situações de erro relacionadas à tipagem e atribuições incompatíveis.

 ### Código na Linguagem

 #### Inferência de Tipo

 ```
 // Correto

 var i = 40.7;
 var num = 50;
 var valor = 60 + 4 - 90;
 ```

 #### Tipos Primitivos

 ```
 // Erro
 // Mensagem: TK_ID 'f' is not declared. Please defines a type to 'f'.

 integer a;
 a = 1;

 floating b;
 b = 3.5;

 bolean c;
 c = verdadeiro;

 letter d;
 f = 'G';
 ```

 ```
 // Correto

 integer a;
 a = 1;

 floating b;
 b = 3.5;

 bolean c;
 c = verdadeiro;

 letter d;
 d = 'G';
 ```

 ```
 // Erro
 // Mensagem: The operation is not set to string and int

 text aa;
 aa = "gabi";

 text bb;
 bb = aa;

 integer cc;
 cc = 1;

 aa = cc;
 ```

 ```
 // Correto

 text aa;
 aa = "gabi";

 text bb;
 bb = aa;
 ```

 ## Observações:

 - A inferência de tipo com `var` permite ao compilador deduzir o tipo com base no valor atribuído.
 - Todos os tipos primitivos (`integer`, `floating`, `bolean`, `letter`, `text`) devem ser declarados corretamente antes do uso.
 - A tentativa de atribuir tipos incompatíveis, como `integer` a `text`, sem conversão, resulta em erro de compilação.
 - O uso de identificadores não declarados gera mensagens claras sobre a falta de definição de tipo.
