%option noyywrap

    // open symbol, something which is not -- occurring 0 or more times, closing symbol
whitespace			([[:blank:]\n])+
comment     		<!--([^-]|-[^-])*--> 
CDataStart 			"<![CDATA["
CDataEnd			\]{2,}>
string 				\"[^"]*\"
NameChar 			[a-zA-Z0-9._:-]
Name 				[a-zA-Z_:]{NameChar}*
	// in attribute value < is also forbidden
AttributeValue      \"[^&"]*\"|\'[^&']\'
Attribute			{Name}={AttributeValue}
StartTagOREmptyTag	<{Name}({whitespace}{Attribute})*{whitespace}?\/?>
	// \<script>(.|\n)*</script>									ECHO;
	// =[[:blank:]]*\"[^\"]*{comment}[^\"]*\"     					ECHO;
JSOpenTag			<script({whitespace}{Attribute})*{whitespace}?\/?>
JSCloseTag			"</script>"

%x		JSCODE

%%

{JSOpenTag}													BEGIN(JSCODE); ECHO;
<JSCODE>{JSCloseTag}												BEGIN(INITIAL); ECHO;
{CDataStart}([^\]]*|\][^\]]|\]{2,}[^\]>])*{CDataEnd}      	ECHO;
{StartTagOREmptyTag}										ECHO;
{comment}                      								;
              
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
