# Teste: Sequência de Declarações e Uso em Expressões

## Descrição
Verifica conjunto de funcionalidades: múltiplas declarações de diferentes tipos seguidas por expressões que envolvem conversão explícita e comparação de char, para testar fluxo completo de análise semântica.

### Código na Linguagem
```c
int A;
float B;
char C;
bool D;
A = 1;
B = A + 2.5;
C = 'z';
D = (A < (int) B) || (C == 'z');
```

### Observações
- Deve gerar temporários para cada linha, conforme já validado anteriormente.
- Testa: declaração em cadeia, atribuição de literal inteiro, soma int + float, atribuição de char, comparação int < int com cast e comparação char == char, e, por fim, ||.
- Se qualquer parte falhar, identifica exatamente qual sub-expressão não produziu código intermediário correto.