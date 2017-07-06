/** compiling with

    gcc -I/usr/local/include/SDL2 -D_THREAD_SAFE -L/usr/local/lib -lSDL2 -lSDL2_image -I/Users/jaiyalas/Project/hspine/spine-c/spine-c/include -L/Users/jaiyalas/Project/hspine/spine-c/build -lspine-c -o main bridge.c

    gcc -I/usr/local/include/SDL2 -D_THREAD_SAFE -I/Users/jaiyalas/Project/hspine/spine-c/spine-c/include bridge.c

*/
#include <stdio.h>
#include <SDL.h>
#include <SDL_image.h>
#include <spine/spine.h>
#include <spine/extension.h>
#include "bridge.h"

/*
https://github.com/gabomdq/spine-runtimes/blob/master/spine-sdl2/src/spine/spine-sdl2.cpp
*/
// void _spAtlasPage_createTexture (spAtlasPage* self, const char* path);
// void _spAtlasPage_disposeTexture (spAtlasPage* self);
// char* _spUtil_readFile (const char* path, int* length);
//
void _spAtlasPage_createTexture (spAtlasPage* self, const char* path, void *param) {
    self->rendererObject = NULL;
    SDL_Surface* surface = IMG_Load(path);
    if (surface) {
        SDL_Texture* texture = SDL_CreateTextureFromSurface((SDL_Renderer*)param, surface);
        if (texture) {
            SDL_SetTextureBlendMode(texture, SDL_BLENDMODE_BLEND);
            self->rendererObject = texture;
            self->width = surface->w;
	        self->height = surface->h;
            SDL_FreeSurface(surface);
            return;
        }
        SDL_FreeSurface(surface);
    }
}
//
void _spAtlasPage_disposeTexture (spAtlasPage* self) {
    if (self->rendererObject) {
        SDL_DestroyTexture((SDL_Texture*)self->rendererObject);
        self->rendererObject = NULL;
    }
}
//
char* _spUtil_readFile (const char* path, int* length) {
    SDL_RWops* file = SDL_RWFromFile(path, "rb");
    if (!file) return NULL;
    //
    SDL_RWseek(file, 0, SEEK_END);
    *length = SDL_RWtell(file);
    SDL_RWseek(file, 0, SEEK_SET);
    //
    char *data = (char*)malloc(*length);
    SDL_RWread(file, data, 1, *length);
    SDL_RWclose(file);
    //
    return data;
}





//
