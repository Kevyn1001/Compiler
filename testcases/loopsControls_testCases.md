 # Teste: Controle de Fluxo em Laços (`break` / `continue`)

 ## Descrição

 Este teste avalia o uso das instruções de controle de fluxo `break` e `continue` dentro de estruturas de repetição como `iterate`, `during` e `execute during`. O objetivo é garantir que o compilador interprete corretamente o comportamento de interrupção (`break`) e salto para a próxima iteração (`continue`).

 ### Código na Linguagem

 #### Break

 ```
 // Correto

 integer i;
 integer somador;

 iterate (i; i < 10; i = i + 1)
 {
   somador = somador + 1;
   break;
 }
 ```

 ```
 // Correto

 integer i;
 integer k;
 k = 10;
 integer somador;

 during (i >= k)
 {
   somador = i + 2;
   break;
   i = i + 1;
 }

 k = 0;
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
   break;
 }
 during(i <= k)
 ```

 #### Continue

 ```
 // Correto

 integer i;
 floating num;
 integer valor;

 iterate (i; i < 10; i = i + 1)
 {  
   check(num == 2.0)
   {
     valor = 20;
     break;
   }
   elsa
   {
     valor = 30;
   }
   num = 2.0;
   continue;
 }
 ```

 ```
 // Correto

 integer i;
 integer k;
 k = 50;
 integer somador;
 integer valor;

 during (i <= k)
 {
   i = i + 1;
   check (i == 5)
   {
     i = 50;
     continue;
   }
   valor = valor + 2;
 }

 k = 0;
 ```

 ```
 // Correto

 integer i;
 integer k;
 k = 10;

 integer somador;

 execute 
 {
   continue;
   i = i + 1;
 }
 during(i <= k)
 ```

 ## Observações:

 - O `break` interrompe a execução do laço imediatamente, ignorando qualquer instrução abaixo dele dentro do bloco.
 - O `continue` pula o restante da iteração atual e avança para a próxima.
 - Ambos os comandos funcionam em `iterate`, `during` e `execute during`.
 - O compilador deve respeitar o fluxo lógico de controle e impedir execuções após `break` e antes de `continue`.
