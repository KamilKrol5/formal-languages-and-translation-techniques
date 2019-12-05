%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <math.h>
    #include <string.h>
    int yylex (void);
    void yyerror (char const *);
    void append(char* str, char* elem);
    int performOperation(int, int, char);
    char* concatenateThreeStrings(char*, char*, char*, size_t);
    char* concatenateTwoStrings(char*, char*, size_t);

    const int BUFFER_SIZE = 100;

    struct expression {
        int value;
        char* rpn;
    };
%}

%define api.value.type {struct expression} /* all attributes for all tokens will have type double */
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
|   exp '\n'      { printf ("%d\n%s\n", $1.value, $1.rpn); free($1.rpn); }
|   error '\n'    { ; }
;

exp:
    NUM               { $$ = $1; }
|   exp '+' exp       { struct expression e = {performOperation($1.value, $3.value, '+'), concatenateThreeStrings($1.rpn, $3.rpn, "+", BUFFER_SIZE)}; $$ = e; }
|   exp '-' exp       { struct expression e = {performOperation($1.value, $3.value, '-'), concatenateThreeStrings($1.rpn, $3.rpn, "-", BUFFER_SIZE)}; $$ = e; }
|   exp '*' exp       {  }
|   exp '/' exp       {  }
|   exp '%' exp       {  }
|   '-' exp %prec '~' {  }
|   exp '^' exp       {  }
|   '(' exp ')'       { $$ = $2; }
;
%%

void append(char* str, char* elem) {
    strncat(str, elem, strlen(elem));
}

int performOperation(int x, int y, char operation_operator) {
    int result = 0;
    switch(operation_operator) {
        case '+':
            result= x + y;
            break;
        case '-':
            result= x - y;
            break;
        case '*':
            result= x * y;
            break;
        case '/':
            result= x / y;
            break;
        case '^':
            result= (int)pow(x,y);
            break;
        case '%':
            result= x % y;
            break;
        default:
            yyerror("Unknown operator");
    }
    return result;
}

char* concatenateThreeStrings(char* str1, char* str2, char* str3, size_t buffer_size) {
    char buffer [buffer_size];
    snprintf(buffer, buffer_size, "%s %s %s", str1, str2, str3);
    return strdup(buffer);
}
