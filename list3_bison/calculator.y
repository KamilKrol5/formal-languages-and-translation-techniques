%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <math.h>
    #include <string.h>
    int yylex (void);
    void yyerror (char const *);
    void append(char* str, char* elem);
    char* performOperation(char*, char*, char, size_t);

    struct expression {
        char* value;
        char* rpn;
    }
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
|   input line
;

line:
    '\n'          { ; }
|   exp '\n'      { printf ("\n%s\n", $1); }
|   error '\n'    { ; }
;

exp:
    NUM               { }
|   exp '+' exp       { $$ = performOperation($1, $3, '+', 100); }
|   exp '-' exp       { $$ = performOperation($1, $3, '-', 100); }
|   exp '*' exp       { $$ = performOperation($1, $3, '*', 100); }
|   exp '/' exp       { $$ = performOperation($1, $3, '/', 100); }
|   exp '%' exp       { $$ = performOperation($1, $3, '%', 100); }
|   '-' exp %prec '~' {  }
|   exp '^' exp       { $$ = performOperation($1, $3, '^', 100); }
|   '(' exp ')'       { $$ = $2; }
;
%%

void append(char* str, char* elem) {
    strncat(str, elem, strlen(elem));
}

char* performOperation(char* x, char* y, char operation_operator, size_t buffer_size) {
    char buffer [buffer_size];
    switch(operation_operator) {
        case '+':
            sprintf(buffer, "%d", atoi(x) + atoi(y));
            break;
        case '-':
            sprintf(buffer, "%d", atoi(x) - atoi(y));
            break;
        case '*':
            sprintf(buffer, "%d", atoi(x) * atoi(y));
            break;
        case '/':
            sprintf(buffer, "%d", atoi(x) / atoi(y));
            break;
        case '^':
            sprintf(buffer, "%d", (int)pow(atoi(x),atoi(y)));
            break;
        case '%':
            sprintf(buffer, "%d", atoi(x) % atoi(y));
            break;
        default:
            yyerror("Unknown operator");
    }
    return strdup(buffer);
}
