%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <math.h>
    #include <string.h>
    #include "expression.h"
    int yylex (void);
    void yyerror (char const *);
    int performOperation(int, int, char);
    char* concatenateThreeStrings(char*, char*, char*, size_t);
    char* concatenateTwoStrings(char*, char*, size_t);
    struct expression buildStructFromBinaryOperation(struct expression*, struct expression*, char);
    struct expression buildStructForNegation(struct expression*);
    int modFloor(int, int);
    int divFloor(int, int);

    const int BUFFER_SIZE = 100;
    bool error = false;
%}

%define api.value.type {struct expression} /* all attributes for all tokens will have type double */
%token NUM
%left '-' '+'
%left '*' '/' '%'
%precedence '~'   /* negation--unary minus */
%right '^'

%destructor { free($$.rpn); } exp

%% /* Grammar rules and actions follow. */

input:
    %empty
|   input line
;

line:
    '\n'          { ; }
|   exp '\n'      { printf ("%s\n%d\n", $1.rpn, $1.value); free($1.rpn); }
|   error '\n'    { ; }
;

exp:
    NUM                         { $$ = $1; }
|   exp '+' exp                 { $$ = buildStructFromBinaryOperation(&$1, &$3, '+'); if(error) { YYERROR; } }
|   exp '-' exp                 { $$ = buildStructFromBinaryOperation(&$1, &$3, '-'); if(error) { YYERROR; } }
|   exp '*' exp                 { $$ = buildStructFromBinaryOperation(&$1, &$3, '*'); if(error) { YYERROR; } }
|   exp '/' exp                 { $$ = buildStructFromBinaryOperation(&$1, &$3, '/'); if(error) { YYERROR; } }
|   exp '%' exp                 { $$ = buildStructFromBinaryOperation(&$1, &$3, '%'); if(error) { YYERROR; } }
|   '-' exp %prec '~'           { $$ = buildStructForNegation(&$2);                   if(error) { YYERROR; } }
|   exp '^' exp                 { $$ = buildStructFromBinaryOperation(&$1, &$3, '^'); if(error) { YYERROR; } }
|   '(' exp ')'                 { $$ = $2; }
;
%%


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
            if (y == 0) {
                error = true;
                yyerror("Division by zero is not allowed.");
                break;
            }
            result= divFloor(x,y);
            break;
        case '^':
            result= (int)pow(x,y);
            break;
        case '%':
            if (y == 0) {
                error = true;
                yyerror("Division by zero is not allowed.");
                break;
            }
            result= modFloor(x,y);
            break;
        default:
            error = true;
            yyerror("Unknown operator");
    }
    return result;
}

char* concatenateThreeStrings(char* str1, char* str2, char* str3, size_t buffer_size) {
    char buffer [buffer_size];
    snprintf(buffer, buffer_size, "%s %s %s", str1, str2, str3);
    return strdup(buffer);
}

char* concatenateTwoStrings(char* str1, char* str2, size_t buffer_size) {
    char buffer [buffer_size];
    snprintf(buffer, buffer_size, "%s %s", str1, str2);
    return strdup(buffer);
}

struct expression buildStructFromBinaryOperation(struct expression* e1,struct expression* e2, char binary_operator) {
    error = false;
    char buffer [BUFFER_SIZE];
    snprintf(buffer, BUFFER_SIZE, "%s %s %c", e1->rpn, e2->rpn, binary_operator);
    free(e1->rpn);
    free(e2->rpn);
    char* rpn_string = strdup(buffer);

    struct expression e = {
        performOperation(e1->value, e2->value, binary_operator),
        rpn_string,
        false
    };

    return e;
}

struct expression buildStructForNegation(struct expression* expr) {
    error = false;
    char* rpn_string; 
    if (expr->isOnlyNumber) {
        rpn_string = concatenateTwoStrings("-", expr->rpn, BUFFER_SIZE);
    } else {
        rpn_string = concatenateTwoStrings(expr->rpn, "~", BUFFER_SIZE);
    }
    free(expr->rpn);

    struct expression result = {
        .value=-expr->value,
        .rpn=rpn_string,
        .isOnlyNumber=false
    };
    return result;
}

int modFloor(int D, int d) {
    if (d == 0) return -1;
    int r = D%d;
    if ((r > 0 && d < 0) || (r < 0 && d > 0)) r = r+d;
    return r;
}

int divFloor(int D, int d) {
    if (d == 0) return -1;
    int q = D/d;
    int r = D%d;
    if ((r > 0 && d < 0) || (r < 0 && d > 0)) q = q-1;
    return q;
}
