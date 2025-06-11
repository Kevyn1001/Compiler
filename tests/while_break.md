 # Teste: Uso de `break` em Laço `while`

 ## Descrição
 Verifica a funcionalidade de interrupção de laço com o comando `break` dentro de um `while`, garantindo que o fluxo salta corretamente para fora do laço.

 ### Código na Linguagem
 ```c
 int i;
 int soma;
 i = 0;
 soma = 0;

 while (i < 10) {
     if (i == 5) {
         break;
     }
     soma = soma + i;
     i = i + 1;
 }

 print(soma);
 ```

 ### Observações
 - Espera que o laço pare quando `i == 5`, acumulando apenas valores 0 a 4 em `soma`.
 - Resultado final impresso deve ser `0+1+2+3+4 = 10`.
 - Testa corretamente a geração de rótulos e o salto do `break`.
