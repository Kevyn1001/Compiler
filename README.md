# Compilador

## ✅ Parte I – Implementado

- [x] **Declaração de variáveis** ✅
- [x] **Atribuições** ✅
- [x] **Expressões com operações aritméticas, lógicas e relacionais** ✅
- [x] **Análise Semântica e Erros** ✅
    - [x] Checagem de compatibilidade de tipos em operações.
    - [x] Verificação de declaração de variáveis antes do uso.

---
### Tipos Suportados:
- [x] `int` ✅
- [x] `float` ✅
- [x] `char` ✅
- [x] `bool` ✅

---
### Literais
- [x] Números inteiros e reais ✅
- [x] Booleanos (`true`, `false`) ✅
- [x] Caracteres (ex: `'a'`) ✅

---
### Operadores
- [x] **Aritméticos:** `+`, `-`, `*`, `/` ✅
- [x] **Lógicos:** `&&`, `||` ✅
- [x] **Relacionais:** `<`, `<=`, `>`, `>=`, `==`, `!=` ✅
- [x] **Unários:** `!` ✅

---
### Conversões de Tipo
- [x] **Conversão Implícita (Promoção de Tipos)** ✅
    - `int` para `float` em operações mistas.
    - `char` para `int` em operações aritméticas.
- [x] **Conversão Explícita (Casting)** ✅
    - Suporte para `(int)expr`, `(float)expr`, etc., com precedência correta.

## 🚧 Partes futuras a implementar

- [ ] **Estruturas de Bloco e Escopo:** Suporte para `{ ... }`, contexto e escopos (global/local).
- [ ] **Estruturas de Controle:**
    - Comandos condicionais (`if`, `if-else`).
    - Comandos de repetição (`while`, `do-while`, `for`).
    - Comando de seleção (`switch`).
    - Controle de laços (`break`, `continue`).
- [ ] **Funções:** Declaração e chamada.
- [ ] **Tipos de Dados Avançados:** Strings, concatenação e Vetores (arrays).
- [ ] **Comandos de Entrada e Saída:** Funções como `read` ou `print`.
- [ ] **Comentários:** Suporte para `//` e/ou `/* */`.
- [ ] **Operadores Adicionais:** Operadores compostos (`+=`, `-=`) e negação unária (`-`).
- [ ] **Inferência de Tipos:** (Recurso avançado).
- [ ] **Tratamento de Erros Melhorado:** Mensagens mais claras e recuperação de erros.

---

## ⚙️ Como executar

### Com Makefile

Use o comando abaixo para compilar automaticamente o código-fonte e gerar o executável compilador:

```bash
make
```

## ⚙️ Testando o Compilador

O projeto está configurado para ler o código de um arquivo chamado testes.txt e compilar a partir dele.

### a) Escreva o código:
Primeiro, adicione ou modifique o código que você deseja compilar dentro do arquivo ```testes.txt```

### b) Execute o teste:
Em seguida, para compilar o conteúdo de ```testes.txt``` e ver o resultado, use o comando:

```bash
make test
```

### Limpando arquivos gerados
Você pode usar o comando abaixo para limpar todos os arquivos temporários e o executável, permitindo uma recompilação do zero:

```bash
make clean
```

## Requisitos
Certifique-se de ter o WSL (Ubuntu) ou um sistema Linux com os seguintes pacotes:

```bash
sudo apt update
sudo apt install flex bison gcc build-essential -y
```

