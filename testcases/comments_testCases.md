 # Teste: Comentários na Linguagem

 ## Descrição

 Este teste verifica se o compilador trata corretamente **comentários de linha (`//`) e comentários de múltiplas linhas (`<!--" ... "-->`)**, ignorando seu conteúdo na geração do código intermediário.

 ### Código na Linguagem

 ```
 // Correto

 letter c;
 c = 'G';

 c--;

 <!--"
 bolean d;
 d = verdadeiro;

 d--;
 show(d);  0 == falso "-->

 show(c); // F
 ```

 ## Observações:

 - Comentários de linha com `//` são corretamente ignorados pelo compilador.
 - Comentários de múltiplas linhas com `<!--" ... "-->` também são ignorados, mesmo contendo código dentro.
 - O código efetivamente executado envolve apenas as instruções **fora dos comentários**.
 - Esse comportamento é útil para testes, anotações e documentação no meio do código fonte.
