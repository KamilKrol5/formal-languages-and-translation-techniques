%{
    #include "calculator.tab.h"
    struct expression {
        int value;
        char* rpn;
    };
%}

num     [0-9]+

%x COMMENT

%%

[[:blank:]]+                    ;
<INITIAL,COMMENT>"\\\n"         ;
<COMMENT>\n                     BEGIN(INITIAL);
{num}                           yylval.value = atoi(yytext); yylval.rpn=strdup(yytext); return NUM;
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
