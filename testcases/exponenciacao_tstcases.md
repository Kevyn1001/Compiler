 # Teste: Exponenciação

 ## Descrição

 Este teste verifica o operador de exponenciação `^`, incluindo casos corretos e erros esperados de tipo.

 ### Código na Linguagem

 ```
 // Correto - Exponenciação de inteiros (int ^ int -> int)

 integer a;
 a = 2;
 integer b;
 b = 3;
 integer c;
 c = a ^ b;
 show(c); // 8
 ```

 ```
 // Correto - Exponenciação com float (float ^ int -> float)

 floating x;
 x = 2.5;
 integer y;
 y = 2;
 floating z;
 z = x ^ y;
 show(z); // 6.25
 ```

 ```
 // Correto - Mistura de tipos (int ^ float -> float)

 integer m;
 m = 3;
 floating n;
 n = 2.5;
 floating p;
 p = m ^ n;
 show(p); // ≈15.588
 ```

 ```
 // Correto - Exponenciação aninhada (associatividade à direita)

 integer u;
 u = 2 ^ 3 ^ 2; // interpreta como 2 ^ (3 ^ 2) = 2 ^ 9 = 512
 show(u); // 512
 ```

 ```
 // Erro - Exponenciação com tipo inválido

 text s;
 s = "abc";
 integer i;
 i = s ^ 2; // Mensagem esperada: type error ou syntax error
 ```

 ## Observações:

 - O operador `^` (exponenciação) respeita associatividade à direita.
 - Gera chamadas a `pow()` para operandos numéricos e produz valor `integer` ou `floating` conforme coerção.
 - Uso com tipos não-numéricos deve resultar em erro de tipo.
