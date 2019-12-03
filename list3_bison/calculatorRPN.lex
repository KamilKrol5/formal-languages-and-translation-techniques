%{
    #include "calculator.tab.h"
%}

num     [0-9]+

%x COMMENT

%%

[[:blank:]]+                    ;
<INITIAL,COMMENT>"\\\n"         ;
<COMMENT>\n                     BEGIN(INITIAL);
{num}                           yylval = atoi(yytext); return NUM;
\n                              return '\n';
"+"                             return '+';
"-"                             return '-';
"*"                             return '*';
"/"                             return '/';
"^"                             return '^';
"%"                             return '%';
"~"                             return '~';
"#"                             BEGIN(COMMENT);
.                               return yytext[0];
<COMMENT>.                      ;
