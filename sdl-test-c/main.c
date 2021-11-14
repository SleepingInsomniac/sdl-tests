#include "SDL2/SDL.h"
#include <time.h>
#include <stdio.h>
#include <stdlib.h>

#define QUITKEY SDLK_ESCAPE
#define WIDTH 100
#define HEIGHT 60
#define SCALE 5
#define FPS_INTERVAL 1.0 //seconds.

SDL_Window* screen = NULL;
SDL_Renderer* renderer;
SDL_Event event;
SDL_Rect source, destination, dst;

int fps_lasttime = 0;  // the last recorded time.
int fps_current;       // the current FPS.
int fps_frames = 0;    // frames passed since the last recorded fps.
char window_title [50];

/* returns a number between 1 and max */
int Random(int max) {
  return (rand() % max) + 1;
}

/* Sets Window caption according to state - eg in debug mode or showing fps */
void SetCaption(char* msg) {
  SDL_SetWindowTitle(screen, msg);
}

/* Initialize all setup, set screen mode, load images etc */
void InitSetup() {
  srand((int)time(NULL));
  SDL_Init(SDL_INIT_EVERYTHING);
  SDL_CreateWindowAndRenderer(WIDTH * SCALE, HEIGHT * SCALE, SDL_WINDOW_SHOWN, &screen, &renderer);
  if (!screen) {
    printf("InitSetup failed to create window");
    exit(1);
  }
  SDL_RenderSetScale(renderer, SCALE, SCALE);
  SetCaption("Example One");
}

/* Cleans up after game over */
void FinishOff() {
  SDL_DestroyRenderer(renderer);
  SDL_DestroyWindow(screen);
  //Quit SDL
  SDL_Quit();
  exit(0);
}

/* main game loop. Handles demo mode, high score and game play */
void GameLoop() {
  int gameRunning = 1;
  while (gameRunning) {
    SDL_PollEvent(&event);

    for (int x = 0; x < WIDTH; x++) {
      for (int y = 0; y < HEIGHT; y++) {
        SDL_SetRenderDrawColor(renderer, Random(255), Random(255), Random(255), 255);
        SDL_RenderDrawPoint(renderer, x, y);
      }
    }

    fps_frames++;
    if (fps_lasttime < SDL_GetTicks() - FPS_INTERVAL * 1000)
    {
       fps_lasttime = SDL_GetTicks();
       fps_current = fps_frames;
       fps_frames = 0;
       
       sprintf(window_title, "SDL Test - %i fps", fps_current);
       SetCaption(window_title);
    }

    SDL_RenderPresent(renderer);

    switch (event.type) {
      case SDL_QUIT: /* if mouse click to close window */
      {
        gameRunning = 0;
        break;
      }
    } /* switch */
  }
}

int main(int argc, char* args[])
{
  InitSetup();
  GameLoop();
  FinishOff();
  return 0;
}
