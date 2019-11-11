%option noyywrap

word     [^[:blank:]\n]+

%{
    int number_of_words = 0;
	int number_of_lines = 0;
%}

%%

^[[:blank:]]+   ;
^[[:blank:]]*\n ;
[[:blank:]]+$   ;
[[:blank:]]+    printf(" ");
\n				{ number_of_lines++; ECHO;}
{word}          { number_of_words++; ECHO;}
              
%%

int main( int argc, char **argv )
{
++argv, --argc;  /* skip over program name */
if ( argc > 0 )
		yyin = fopen( argv[0], "r" );
else
		yyin = stdin;

yylex();
fprintf(stderr, "Number of words: %d\n", number_of_words);
fprintf(stderr, "Number of lines: %d\n", number_of_lines);
}
