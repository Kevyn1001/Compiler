 # Teste: Matrizes e Tipos de Tamanho

 ## Descrição

 Este teste verifica o comportamento do compilador ao declarar e acessar **matrizes bidimensionais**, com foco na **validação dos tamanhos das dimensões** (linhas e colunas), especialmente quanto à exigência de serem inteiros ou convertidos explicitamente.

 ### Código na Linguagem

 ```
 // Erro
 // Mensagem: "The matrix column size must be an integer type."

 integer matrix[1][2.8];

 matrix[1][1] = 8;
 ```

 ```
 // Correto

 integer matrix[1][2];

 matrix[1][1] = 8;
 ```

 ```
 // Correto

 integer size = 2.80;
 integer matrix[size][2];

 matrix[1][1] = 8;
 ```

 ```
 // Correto

 integer matrix[3.5 como integer][2];

 matrix[1][1] = 8;
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

 ```
 // Correto

 integer matrix[5][5];
 matrix[2][4] = 8;
 integer result;
 show(matrix[2][4]);
 ```

 ## Observações:

 - O compilador exige que **as dimensões das matrizes** (linhas e colunas) sejam do tipo `integer`.
 - O uso de `float` como tamanho direto gera erro, mas pode ser resolvido com conversão explícita (`como integer`).
 - O preenchimento e acesso a elementos em laços aninhados funcionam como esperado.
 - A matriz permite acesso direto por índices estáticos e exibição do valor com `show`.
