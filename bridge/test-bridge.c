/*
gcc -I/usr/local/include/SDL2 -D_THREAD_SAFE -L/usr/local/lib -lSDL2 -lSDL2_image -I/Users/jaiyalas/Project/hspine/spine-c/spine-c/include -L/Users/jaiyalas/Project/hspine/spine-c/build -lspine-c -o main test-bridge.c
*/
#include <stdio.h>
#include <SDL.h>
#include <SDL_image.h>
#include <spine/spine.h>
#include <spine/extension.h>
#include "Bridge.h"


int main(){
    // int i, sum = 0;
    // for ( i = 1; i <= 10; i++ ) {
    //   sum += i;
    // }
    // printf("sum = %d\n", sum);
    // printf("sum = %d\n", foo(100));
    // printf("SDL_INIT_VIDEO = %d\n", SDL_INIT_VIDEO);

    spAtlas* atlas = spAtlas_createFromFile("powerup/powerup.atlas", 0);
    int i = atlas->pages->width;
    printf("width = %d\n", i);


    // SDL_Window*   window = NULL;
    // SDL_Renderer* renderer = NULL;
    // SDL_Texture*  bitmapTex = NULL;
    // SDL_Surface*  bitmapSurface = NULL;
    // //
    // SDL_Init(SDL_INIT_VIDEO);
    // window = SDL_CreateWindow("window",10,10,600,600,SDL_WINDOW_OPENGL);
    // renderer = SDL_CreateRenderer(window, -1, SDL_RENDERER_ACCELERATED);
    // bitmapSurface = SDL_LoadBMP("char.bmp");
    // bitmapTex = SDL_CreateTextureFromSurface(renderer, bitmapSurface);
    // SDL_FreeSurface(bitmapSurface);
    // //
    // SDL_RenderClear(renderer);
    // SDL_RenderCopy(renderer, bitmapTex, NULL, NULL);
    // SDL_RenderPresent(renderer);
    // SDL_Delay(3000);
    // //
    // SDL_DestroyTexture(bitmapTex);
    // SDL_DestroyRenderer(renderer);
    // SDL_DestroyWindow(window);
    // SDL_Quit();
    // //
    return 0;
}

// SDL_Renderer* create_SDL_Renderer(){
//     SDL_Window*   win = NULL;
//     SDL_Renderer* renderer = NULL;
//     win = SDL_CreateWindow("window",10,10,600,600,SDL_WINDOW_SHOWN);
//     renderer = SDL_CreateRenderer(win, -1, SDL_RENDERER_ACCELERATED);
//     return renderer;
// }
