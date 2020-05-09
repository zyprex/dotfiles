XPTemplate priority=personal

XPTinclude
    \ _common/all


" STRUCT:
XPT st " struct
struct `^ {
    `data_type^ `member^;
`   `more...`
{{^    `data_type^ `member^;
`   `more...`
^`}}^
}
XPT un " union 
union `^ {
    `data_type^ `member^;
`   `more...`
{{^    `data_type^ `member^;
`   `more...`
^`}}^
}



" PREPROCESSOR:
XPT de " #define
#define `^
XPT in " #include<>
#include <`stdio.h^>
XPT inc " #include""
XSET fname=expand('%<')
#include "`fname^.h"
XPT re " return\ 0
return `0^;

" FUNCS:
XPT ma hint=main+stdio 
#include <stdio.h>
int main( int argc, char *argv[] )
{
    `cursor^
    return 0;
}
XPT fu hint=functions
`void^ `func^(`^) 
{
    `^
}

XPT sc " scanf\(...)
scanf(`$SParg^`:_printfElts:^`$SParg^)


" COMMENTS:

XPT cmt hint=/*time*/
/* `strftime('%c')^ */

XPT cm3 hint=/***/
/*
 * `^
 */

XPT fcm " function comment
/********************************************************************
 * @fn      `funcname^
 * @brief   `description^
 * @param   `^
 * @return  `none^
 *******************************************************************/`cursor^

" CONDITION:
XPT if " if () {}
if( `^ ) {
    `^
}
XPT ef " else if () {}
else if(`^) {
    `^
}
XPT el " else {}
else{
    `^
}
XPT sw " switch
switch( `^ ) {
    `...^case `0^: 
    `^;
    break;
`...^
    default:
}

" LOOP:
XPT wh  " while\ (?)
while( `^ ) {
    `^
}
XPT wh1 " while\ (TURE)
while( 1 ) {
    `^
}
XPT do " do..while\ (..);
do{
    `^
}while( `^ );
XPT fo " for\ (.;..;+=)
for( `i^ = `0^; `i^ < `len^; `i^+=`1^ ) {
    `cursor^
}
XPT for " for\ (..;..;+=)
XSET ComeFirst=int i 0 len 1
for( `int^ `i^ = `0^; `i^ < `len^; `i^+=`1^ ) {
    `cursor^
}



" OTHERT:
XPT si " sizeof
sizeof(`^)

" XPT nl " newline
" putchar(10);

