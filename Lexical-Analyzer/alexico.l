%option yywrap
%{
  #include <stdio.h>
  #include <stdlib.h>
  #include <string.h>
  int nerror = 0;
%}
DIGITO [0-9]
LETRA [a-zA-Z]
ID  {LETRA}+
NUM {DIGITO}+

MAIN main
INT int
IF if
ELSE else
RETURN return
VOID void
WHILE while
INPUT input
OUTPUT output

SOMA \+
SUB \-
MUL \*
DIV \/
MENOR <
MEIGUAL <=
MAIOR >
MAIGUAL >=
IGUAL ==
DIF !=
ATRIB \=
PV \;
V \,
FP \)
ACO \[
FCO \]
AP \(
ACH \{
FCH \}

%%


{MAIN} {fprintf(yyout, "%s MAIN\n", yytext);}
{ELSE} {fprintf(yyout, "%s ELSE\n", yytext);}
{IF} {fprintf(yyout,"%s IF\n", yytext);}
{INT} {fprintf(yyout,"%s INT\n", yytext);}
{RETURN} {fprintf(yyout,"%s RETURN\n", yytext);}
{VOID} {fprintf(yyout,"%s VOID\n", yytext);}
{WHILE} {fprintf(yyout,"%s WHILE\n", yytext);}
{INPUT} {fprintf(yyout,"%s INPUT\n", yytext);}
{OUTPUT} {fprintf(yyout,"%s OUTPUT\n", yytext);}

{ID} {fprintf(yyout,"%s ID\n", yytext);}
{NUM} {fprintf(yyout,"%s NUM\n", yytext);}

{SOMA} {fprintf(yyout,"%s SOMA\n", yytext);}
{SUB} {fprintf(yyout,"%s SUB\n", yytext);}
{MUL} {fprintf(yyout,"%s MUL\n", yytext);}
{DIV} {fprintf(yyout,"%s DIV\n", yytext);}
{MENOR} {fprintf(yyout,"%s MENOR\n", yytext);}
{MEIGUAL} {fprintf(yyout,"%s MEIGUAL\n", yytext);}
{MAIOR} {fprintf(yyout,"%s MAIOR\n", yytext);}
{MAIGUAL} {fprintf(yyout,"%s MAIGUAL\n", yytext);}
{IGUAL} {fprintf(yyout,"%s IGUAL\n", yytext);}
{DIF} {fprintf(yyout,"%s DIF\n", yytext);}
{ATRIB} {fprintf(yyout,"%s ATRIB\n", yytext);}
{PV} {fprintf(yyout,"%s PV\n", yytext);}
{V} {fprintf(yyout,"%s V\n", yytext);}
{AP} {fprintf(yyout,"%s AP\n", yytext);}
{FP} {fprintf(yyout,"%s FP\n", yytext);}
{ACO} {fprintf(yyout,"%s ACO\n", yytext);}
{FCO} {fprintf(yyout,"%s FCO\n", yytext);}
{ACH} {fprintf(yyout,"%s ACH\n", yytext);}
{FCH} {fprintf(yyout,"%s FCH\n", yytext);}

{ID}[/][*][^*]*[*]+([^*/][^*]*[*]\n+)*[/]{ID} {nerror++; fprintf(yyout,"%s ERRO\n", yytext);}
[ ][/][*][^*]*[*]+([^*/][^*]*[*]\n+)*[/]{ID} {nerror++; fprintf(yyout,"%s ERRO\n", yytext);}
{ID}[/][*][^*]*[*]+([^*/][^*]*[*]\n+)*[/][ ] {nerror++; fprintf(yyout,"%s ERRO\n", yytext);}

\t|\ |\n
[/][*][^*]*[*]+([^*/][^*]*[*]\n+)*[/]

. {nerror++; fprintf(yyout,"%s ERRO\n", yytext);}
%%
int main(int argc, char* argv[]){
  if (argc <= 1) {
    printf("Usage: %s filename.c-\n", argv[0]);
    exit(0);
  }

  yyin = fopen(argv[1], "r");

  if(yyin == NULL){
    printf("Arquivo nao existe\n");
    exit(0);
  }

  yyout = fopen("relatorio.txt", "w");
  fprintf(yyout, "%d erro(s) encontrado(s)\n", nerror);

  yylex();

  rewind(yyout);
  fprintf(yyout, "%d erro(s) encontrado(s)\n", nerror);

  return 0;
}
