/** compiling with
    gcc -I/usr/local/Cellar/sdl2/2.0.5/include/SDL2 -o main bridge.c
*/
#include <stdio.h>
#include <SDL.h>
#include "bridge.h"

int main(){
    int i, sum = 0;
    for ( i = 1; i <= 10; i++ ) {
      sum += i;
    }
    printf("sum = %d\n", sum);
    printf("sum = %d\n", foo(100));
    printf("SDL_INIT_VIDEO = %d\n", SDL_INIT_VIDEO);
    return 0;
}

int foo (int i){
    return (i+1);
}
