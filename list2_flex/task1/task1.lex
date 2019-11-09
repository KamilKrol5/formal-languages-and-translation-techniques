%option noyywrap

word     [^[:blank:]\n]+


%{
    int number_of_words = 0;
%}

%%

{word}          { number_of_words++; ECHO;}
^[[:blank:]]+   ;
[[:blank:]]+$   ;
[[:blank:]]+    printf(" ");
^\n             ;
              
%%

int main( int argc, char **argv )
{
++argv, --argc;  /* skip over program name */
if ( argc > 0 )
		yyin = fopen( argv[0], "r" );
else
		yyin = stdin;

yylex();
printf("%d", number_of_words);
}
