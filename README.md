# Compilador

## ✅ Parte I – Implementado
- [x] Declaração de variáveis ✅
- [x] Atribuições ✅
- [x] Expressões com operações aritméticas ✅
### Tipos suportados:
- [x] `int` ✅
- [x] `float` ✅
- [x] `char` ✅
- [x] `bool` ✅
### Literais
- [x] Números inteiros e reais ✅
- [x] Booleanos (`true`, `false`) ✅
- [x] Caracteres (ex: `'a'`) ✅
### Operadores
- [x] Aritméticos: `+`, `-`, `*`, `/` ✅
- [ ] Lógicos
- [ ] Relacionais
### Conversões
- [ ] Conversão implícita
- [ ] Conversão explícita

## 🚧 Partes futuras a implementar
- [ ] Escopos e blocos
- [ ] Strings e concatenação
- [ ] Comandos de entrada e saída
- [ ] Comandos condicionais e de repetição (`if`, `while`, `for`, `switch`)
- [ ] Vetores
- [ ] Comentários
- [ ] Funções e chamadas
- [ ] Operadores compostos e unários
- [ ] Inferência de tipos
- [ ] Detecção e tratamento de erros

---

## ⚙️ Como executar

```bash
bison -d parser.y
flex lexer.l
gcc main.c parser.tab.c lex.yy.c -o compilador
 ./compilador
 ```

### Requisitos

Certifique-se de ter o **WSL (Ubuntu)** instalado com os seguintes pacotes:

```bash
sudo apt update
sudo apt install flex bison gcc build-essential -y
```
