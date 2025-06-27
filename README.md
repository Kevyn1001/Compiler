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
- [x] Lógicos: `&&`, `||`, `!` ✅
- [x] Relacionais: `<`, `<=`, `>`, `>=`, `==`, `!=` ✅

### Conversões
- [x] Conversão implícita ✅
- [x] Conversão explícita ✅

## 🚧 Partes futuras a implementar
- [x] Escopos e blocos✅
- [x] Strings e concatenação✅
- [x] Comandos de entrada e saída✅
- [x] Comandos condicionais e de repetição (`if`, `while`, `for`, `switch`)✅
- [x] Vetores✅
- [x] Comentários✅
- [x] Funções e chamadas✅
- [x] Operadores compostos e unários✅
- [ ] Inferência de tipos
- [x] Detecção e tratamento de erros✅

---

## ⚙️ Como executar

### Com Makefile

Use o comando abaixo para compilar automaticamente:

```bash
make run
```

### O binário será gerado com o nome `glf`. Para executar o teste com geração de código intermediário:

```bash
make test
```

## Requisitos
Certifique-se de ter o WSL (Ubuntu) ou um sistema Linux com os seguintes pacotes:

```bash
sudo apt update
sudo apt install flex bison gcc build-essential -y
```
