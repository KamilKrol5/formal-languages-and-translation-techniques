%option noyywrap

    // open symbol, something which is not -- occurring 0 or more times, closing symbol
comment     <!--([^-]|-[^-])*--> 

%%

"<"!\[CDATA\[(.|\n)*\]\]>      ECHO;
=\"[^\"]*{comment}[^\"]*\"     ECHO;
{comment}                      ;
              
%%

int main( int argc, char **argv )
{
++argv, --argc;  /* skip over program name */
if ( argc > 0 )
		yyin = fopen( argv[0], "r" );
else
		yyin = stdin;

yylex();
}
