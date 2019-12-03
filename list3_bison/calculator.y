%{
  #include <stdio.h>
  #include <math.h>
  #include <string.h>
  int yylex (void);
  void yyerror (char const *);
%}

%define api.value.type {char*} /* all attributes for all tokens will have type double */
%token NUM
%left '-' '+'
%left '*' '/'
%precedence '~'   /* negation--unary minus */
%right '^'                   

%% /* Grammar rules and actions follow. */

input:
  %empty
| input line
;

line:
  '\n'          { ; }
| exp '\n'      { printf ("\n%.10g\n", $1); }
| error '\n'    { ; }
;

exp:
  NUM               { }
| exp '+' exp       { }
| exp '-' exp       { }
| exp '*' exp       { }
| exp '/' exp       { }
| '-' exp %prec '~' { }
| exp '^' exp       { }
| '(' exp ')'       { }
;
%%

void append(char** str, char* elem) {
    &str = strcat(&str, elem);
}
