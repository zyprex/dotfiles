XPTemplate priority=personal

XPTinclude
    \ _common/all


XPT main " main+iostream
#include <iostream>
using namespace std;
int main( int argc, char* args[] )
{
    `cursor^
    return 0;
}

XPT cout " cout<< ... <<endl;
cout<<`^<<endl;

XPT cl " class ... { };  
class `^
{
    `cursor^
};
