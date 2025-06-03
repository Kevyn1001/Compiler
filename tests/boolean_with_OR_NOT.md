# Teste: Expressão Booleana com OR e NOT

## Descrição
Verifica se o compilador lida corretamente com ! (NOT), && (AND) e || (OR) em uma mesma expressão, incluindo literal booleano true.

### Código na Linguagem
```c
bool X;
bool Y;
bool Z;
Z = !X || (Y && true);
```
### Observações
- Deve gerar temporário para !X primeiro, depois para (Y && true), e então aplicar ||.
- O literal true deve ser convertido para int (ou tipo interno de bool) antes de participar do &&.
- Se a avaliação de precedência estiver incorreta, pode inverter a ordem lógica.