%option noyywrap
%top {
    #include <stdio.h>
    #include <math.h>
    #include <stdbool.h>
}

%{
    #define STACK_SIZE 1000
    int ptr = -1;
    int stack[STACK_SIZE];
    int x, y;
    bool error_var = false;

void push(int num) {
    ptr++;
    if (ptr < STACK_SIZE) {
        stack[ptr] = num;
    } else {
        printf("ERROR: stack overflow.\n");
        error_var = true;
    } 
}

int pop() {
    if (ptr >= 0) {
        ptr--;
        return stack[ptr + 1];
    } else {
        // printf("ERROR: An attempt to pop from empty stack.\n");
        error_var = true;
        return -1;
    }
}

%}

%x error

%%

[[:blank:]]+         ;

-?[0-9]+             push(atoi(yytext));

\+                   {
    x = pop();
    y = pop();
    push(x+y);
}

\-                   {
    x = pop();
    y = pop();
    push(y-x);
}

\*                   {
    x = pop();
    y = pop();
    push(x*y);
}

\^                   {
    x = pop();
    y = pop();
    push((int) pow((double) y, (double) x));
}

\/                   {
    x = pop();
    if (x == 0) {
        printf("ERROR: Division by zero. (while operation /)\n");
        BEGIN(error);
    } else {
        y = pop();
        push(y / x);
    }
}

\%                   {
    x = pop();
    if (x == 0) {
        printf("ERROR: Division by zero. (while operation %%)\n");
        BEGIN(error);
    } else {
        y = pop();
        push(y % x);
    }
}

\n                  {
    if (ptr == 0) {
        int result = pop();
        if (error_var) {
            printf("ERROR: Too few arguments.\n");
        } else {
            printf("= %d\n", result);
        }
        error_var = false;
        ptr = -1;
        BEGIN(INITIAL);
    } else {
        if (error_var) {
            printf("ERROR: Too few arguments.\n");
        } else {
            printf("ERROR: Too few operators.\n");
        }
        error_var = false;
        ptr = -1;
        BEGIN(INITIAL);
    }
}

.                    {
    printf("ERROR: Unknown symbol %s\n", yytext);
    BEGIN(error);
}

<error>.*            ;
<error>[\n]           {
    ptr = -1;
    BEGIN(INITIAL);
}
