 # Teste: Comandos switch/case

 ## Descrição

 Este teste verifica se o compilador reconhece corretamente os comandos `switch/case`, incluindo **casos simples e casos condicionais** com operadores relacionais como `>`, `<`, `<=` e `>=`.

 ### Código na Linguagem

 ```
 // Teste com igualdade direta

 integer x;
 x = 20;
 integer z;

 switch (x) 
 {
   case 10 :
   { 
     z = 3; 
   }
   case 20 :
   { 
     z = 56; 
   }
   default :
   { 
     z = 0;
   }
 }
 ```

 ```
 // Teste com operadores relacionais

 integer x;
 x = 20;
 integer z;

 switch (x) 
 {
   case > 10 :
   { 
     z = 1; 
   }
   case < 20 :
   { 
     z = 2; 
   }
   case <= 30 :
   { 
     z = 3; 
   }
   case >= 40 :
   { 
     z = 4; 
   }
   case 50 :
   { 
     z = 5;
   }
   default :
   { 
     z = 0; 
   }
 }
 ```

 ## Observações:

 - O compilador reconhece corretamente a estrutura `switch` com múltiplos `case`.
 - O suporte a **comparações condicionais** (`>`, `<`, `<=`, `>=`) dentro dos `case` é uma extensão útil além do `case` por valor.
 - O `default` é utilizado de forma padrão, executando quando nenhum `case` é atendido.
 - O comportamento está de acordo com a lógica esperada, e a sintaxe foi interpretada corretamente pelo compilador.
