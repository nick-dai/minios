#include "print.h"

void _start(){
    put_str("\r\nTerry_kernel\ncoox\bl");
    put_str("\r\nHacked!");
    while(1){
        asm("hlt");
    };
}
