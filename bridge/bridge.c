/** compiling with
    gcc -I/Users/jaiyalas/Project/hspine/spine-c/spine-c/include -I/usr/local/Cellar/sdl2/2.0.5/include/SDL2 -o main bridge.c
    gcc -L/usr/local/Cellar/sdl2/2.0.5/lib -I/usr/local/Cellar/sdl2/2.0.5/include/SDL2 -o main bridge.c
    gcc  -I/usr/local/include/SDL2 -D_THREAD_SAFE -L/usr/local/lib -lSDL2 -o main bridge.c
*/
#include <stdio.h>
#include <SDL.h>
// #include <spine/spine.h>
#include "bridge.h"

int main(){
    int i, sum = 0;
    for ( i = 1; i <= 10; i++ ) {
      sum += i;
    }
    printf("sum = %d\n", sum);
    printf("sum = %d\n", foo(100));
    printf("SDL_INIT_VIDEO = %d\n", SDL_INIT_VIDEO);

    SDL_Window*   window = NULL;
    SDL_Renderer* renderer = NULL;
    SDL_Texture*  bitmapTex = NULL;
    SDL_Surface*  bitmapSurface = NULL;
    //
    SDL_Init(SDL_INIT_VIDEO);
    window = SDL_CreateWindow("window",10,10,600,600,SDL_WINDOW_OPENGL);
    renderer = SDL_CreateRenderer(window, -1, SDL_RENDERER_ACCELERATED);
    bitmapSurface = SDL_LoadBMP("char.bmp");
    bitmapTex = SDL_CreateTextureFromSurface(renderer, bitmapSurface);
    SDL_FreeSurface(bitmapSurface);
    //
    SDL_RenderClear(renderer);
    SDL_RenderCopy(renderer, bitmapTex, NULL, NULL);
    SDL_RenderPresent(renderer);
    SDL_Delay(3000);
    //
    SDL_DestroyTexture(bitmapTex);
    SDL_DestroyRenderer(renderer);
    SDL_DestroyWindow(window);
    SDL_Quit();
    //
    return 0;
}


int foo (int i){
    return (i+1);
}

SDL_Renderer* create_SDL_Renderer(){
    SDL_Window*   win = NULL;
    SDL_Renderer* renderer = NULL;
    win = SDL_CreateWindow("window",10,10,600,600,SDL_WINDOW_SHOWN);
    renderer = SDL_CreateRenderer(win, -1, SDL_RENDERER_ACCELERATED);
    return renderer;
}

/*
https://github.com/gabomdq/spine-runtimes/blob/master/spine-sdl2/src/spine/spine-sdl2.cpp
*/
//
// void _AtlasPage_createTexture (spAtlasPage* self, const char* path, void *param) {
//     self->rendererObject = NULL;
//     SDL_Surface *surface = IMG_Load(path);
//     if (surface) {
//         SDL_Texture *texture = SDL_CreateTextureFromSurface((SDL_Renderer*)param, surface);
//         if (texture) {
//             SDL_SetTextureBlendMode(texture, SDL_BLENDMODE_BLEND);
//             self->rendererObject = texture;
//             self->width = surface->w;
// 	        self->height = surface->h;
//             SDL_FreeSurface(surface);
//             return;
//         }
//         SDL_FreeSurface(surface);
//     }
// }
// //
// void _AtlasPage_disposeTexture (spAtlasPage* self) {
//     if (self->rendererObject) {
//         SDL_DestroyTexture((SDL_Texture*)self->rendererObject);
//         self->rendererObject = NULL;
//     }
// }
// //
// char* _Util_readFile (const char* path, int* length) {
//     SDL_RWops *file = SDL_RWFromFile(path, "rb");
//     if (!file) return NULL;
//     //
//     SDL_RWseek(file, 0, SEEK_END);
//     *length = SDL_RWtell(file);
//     SDL_RWseek(file, 0, SEEK_SET);
//     //
//     char *data = (char*)malloc(*length);
//     SDL_RWread(file, data, 1, *length);
//     SDL_RWclose(file);
//     //
//     return data;
// }


//
