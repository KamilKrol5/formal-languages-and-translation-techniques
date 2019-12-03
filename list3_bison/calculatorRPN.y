%{
  #include <stdio.h>
  #include <math.h>
  int yylex (void);
  void yyerror (char const *);
%}

%define api.value.type {double} /* all attributes for all tokens will have type double */
%token NUM                      /* all the arithmetic operators are designated by single-character literals,
                                so the only terminal symbol that needs to be declared is NUM, the token type for numeric constants */

%% /* Grammar rules and actions follow. */

input:
  %empty
| input line
;

line:
  '\n'
| exp '\n'      { printf ("%.10g\n", $1); }
| error '\n'
;

exp:
  NUM
| exp exp '+'   { $$ = $1 + $2;      }
| exp exp '-'   { $$ = $1 - $2;      }
| exp exp '*'   { $$ = $1 * $2;      }
| exp exp '/'   { $$ = $1 / $2;      }
| exp exp '^'   { $$ = pow($1, $2); }  /* Exponentiation */
| exp '~'       { $$ = -$1;          }  /* Unary minus   */
;
%%
