%option noyywrap

word     [^[:blank:]\n]+

%{
    int number_of_words = 0;
	int number_of_lines = 0;
%}

%%

{word}          { number_of_words++; ECHO;}
\n				{ number_of_lines++; ECHO;}
^[[:blank:]]+   ;
^[[:blank:]]*\n ;
[[:blank:]]+$   ;
[[:blank:]]+    printf(" ");
              
%%

int main( int argc, char **argv )
{
++argv, --argc;  /* skip over program name */
if ( argc > 0 )
		yyin = fopen( argv[0], "r" );
else
		yyin = stdin;

yylex();
printf("Number of words: %d\n", number_of_words);
printf("Number of lines: %d\n", number_of_lines);
}
