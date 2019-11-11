#include "test/*asdf*/header.h"
#include <stdio.h>
#include <foo/*bar*/baz.h>

/** \brief Java style Doc String - Foo function **/
int foo();

int bar(); /**< Bar function */

/// .NET Style Doc String
int g_global_var = 1;

/* Hello
/* World
// */
int baz();
// */

/*! Global variable
 *  ... */
volatile int g_global;

//! Main
int main(int argc, const char* argv)
{
    printf("/* foo bar");
    printf("/* foo bar");
    //*/ bar();

    // \
    /*
    baz1();
    /*/
    foo();
    //*/

/\
\
\
/* \
    baz();
/*/
    foo();
//*/

    printf("/* foo bar\n \"h  /* h");
    return 1;
}

// wwww /*ww
/*ggggggggggggggggggg */

//! jjj \
ababab \gg
/\
/\
/\
hhhh

/\
/\
!llllllll\
hhh
