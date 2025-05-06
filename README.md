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

### Com Makefile

Use o comando abaixo para compilar automaticamente:

```bash
make
```
### O binário será gerado com o nome compilador. Para executar:

```bash
./compilador
```

### Limpando arquivos gerados
Você pode usar o comando abaixo para limpar arquivos temporários e recompilar do zero:

```bash
make clean
```

## Requisitos
Certifique-se de ter o WSL (Ubuntu) ou um sistema Linux com os seguintes pacotes:

```bash
sudo apt update
sudo apt install flex bison gcc build-essential -y
```

