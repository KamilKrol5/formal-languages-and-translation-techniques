#include <stdio.h>

int yyparse();
void yyerror (char const *);

int main(int argc, char const *argv[])
{
    yyparse();
    return 0;
}

void yyerror(char const * m) {
    printf("ERROR\n");
}