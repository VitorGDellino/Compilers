//definicoes
%{
#include <stdio.h>
#include <ctype.h>
%}
%token ID NUM INT VOID IF ELSE WHILE RETURN VAZIO
%start programa

%%
//regras
programa : declaracao_lista
         ;

declaracao_lista : declaracao_lista declaracao
                 | declaracao
                 ;

declaracao : var_declaracao
           | fun_declaracao
           ;

var_declaracao : tipo_especificador ID ';'
               | tipo_especificador ID '[' NUM ']' ';'
               ;

tipo_especificador : INT
                   | VOID
                   ;

fun_declaracao : tipo_especificador ID '(' params ')' composto_decl
               ;

params : param_lista
       | VOID
       ;

param_lista : param_lista ',' param
            | param
            ;

param : tipo_especificador ID
      | tipo_especificador ID '[' ']'
      ;

composto_decl : '{' local_declaracoes statement_lista '}'
              ;

local_declaracoes : local_declaracoes var_declaracao
                  | VAZIO
                  ;

statement_lista : statement_lista statement
                | VAZIO
                ;

statement : expressao_decl
          | composto_decl
          | selecao_decl
          | iteracao_decl
          | retorno_decl
          ;

expressao_decl : expressao ';'
               | ';'
               ;

selecao_decl : IF '(' expressao ')' statement
             | IF '(' expressao ')' statement ELSE statement
             ;

iteracao_decl : WHILE '(' expressao ')' statement
              ;

retorno_decl : RETURN ';'
             | RETURN expressao ';'
             ;

expressao : var '=' expressao
          | simples_expressao
          ;

var : ID
    | ID '[' expressao ']'
    ;

simples_expressao : soma_expressao relacional soma_expressao
                  | soma_expressao
                  ;

relacional : '<' '='
           | '<'
           | '>'
           | '>' '='
           | '=' '='
           | '!' '='
           ;

soma_expressao :  soma_expressao soma termo
               | termo
               ;

soma : '+'
     | '-'
     ;

termo : termo mult fator
      | fator
      ;

mult : '*'
     | '/'
     ;

fator : '(' expressao ')'
      | var
      | ativacao
      | NUM
      ;

ativacao : ID '(' args ')'
         ;

args : arg_lista
     | VAZIO
     ;

arg_lista : arg_lista ',' expressao
          | expressao
          ;

%%
//codigo auxiliar
int yylex(void);
int yyerror(void);

int main(int argc, char* argv[]){
  return yyparse();
}

/* Isso aqui ainda nao funciona, peguei de exemplo do professor
, precisamos colocar nosso analisador lexico aqui*/
int yylex(void){
  int c;

  while((c = getchar()) == ' ');

  if(isdigit(c)){
    ungetc(c, stdin);
    scanf("%d", &yylval);
    return NUM;
  }

  if(c == '\n') return 0;

  return c;

}

int yyerror(void){
  printf("Erro Sintático\n");
  return 0;
}
