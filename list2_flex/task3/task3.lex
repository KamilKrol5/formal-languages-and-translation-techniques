%option noyywrap

%top {
    #include <stdbool.h>
}

%{
    bool leave_doxygen_var = false;
%}

string                          \"([^"\\]|\\.)*\"
include                         "#include"[[:blank:]]*"<"[^>]*">"

multiline_comment               "/*"([^*]|\*+[^*/])*"*"+"/"
    //first case is normal case \/{2}.*\n 
single_line_comment             (\/(\\\n)*\/|\/\/)(.*\\\n)*.*$

    // dot_net_comment                 \/{3}.*\n
    // cpp_comment                     \/{2}!.*\n
dot_net_comment                 \/(\\\n)*\/(\\\n)*\/(.*\\\n)*.*\n
cpp_comment                     \/(\\\n)*\/(\\\n)*!(.*\\\n)*.*\n
java_doc                        "/**"([^*]|\*+[^*/])*"*"+"/"
qt_style_comment                "/*!"([^*]|\*+[^*/])*"*"+"/"

%x leave_doxygen

%%
        // "/*"                    BEGIN(comment);

        // <comment>[^*]*          /* eat anything that's not a '*' */
        // <comment>"*"+[^*/]*     /* eat up '*'s not followed by '/'s */
        // <comment>"*"+"/"        BEGIN(INITIAL);

<INITIAL,leave_doxygen>{string}                 ECHO;
<INITIAL,leave_doxygen>{include}                ECHO;

<leave_doxygen>{dot_net_comment}                ECHO;// { printf("DOTNET"); }
<leave_doxygen>{cpp_comment}                    ECHO;// { printf("CPPCOMMENT"); }
<leave_doxygen>{java_doc}                       ECHO;// { printf("JAVADOC"); }
<leave_doxygen>{qt_style_comment}               ECHO;// { printf("QTSTYLE"); }

<INITIAL,leave_doxygen>{multiline_comment}      ;//{ printf("MULTILINE"); }
<INITIAL,leave_doxygen>{single_line_comment}    ;//{ printf("SINGLE LINE COMMENT\n"); }

%%

int main( int argc, char **argv )
{
    ++argv, --argc;  /* skip over program name */
    if (argc > 0)
            yyin = fopen( argv[0], "r" );
    else
            yyin = stdin;

    if (argc == 2) 
    {
        if (strcmp(argv[1],"-d") == 0 || strcmp(argv[1],"--doxygen") == 0)
            leave_doxygen_var = true;
        else {
            printf("Unknown command %s. Available commands are: '-d', '--doxygen'\n", argv[1]);
            return 0;
        }
    }

    if(leave_doxygen_var)
        BEGIN(leave_doxygen);
    else
        BEGIN(INITIAL);

    yylex();
}
