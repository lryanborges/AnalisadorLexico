Segue o passo a passo pra executar o Analisador Léxico em C++:

- Deve ser executado dentro de um sistema Unix
- No terminal:
  1. sudo apt update
  2. sudo apt upgrade
  3. sudo apt install g++ gdb
  4. sudo apt install make cmake
  5. sudo apt install flex libfl-dev
  6. sudo apt install bison libbison-dev

 - Abrir o projeto no VSCode
 - Executar os comandos:
  1. flex++ analisadorLex.l
  2. g++ lex.yy.cc -std=c++17 -o analisadorLex
  3. ./analisadorLex < finalTest.txt
