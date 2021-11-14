import SDL2

let width: Int32 = 100
let height: Int32 = 60
let scale: Int32 = 5

SDL_Init(SDL_INIT_VIDEO)
SDL_InitSubSystem(SDL_INIT_VIDEO)
let window = SDL_CreateWindow("SDL2 test", 0, 0, width * scale, height * scale, SDL_WINDOW_SHOWN.rawValue)
let renderer = SDL_CreateRenderer(window, -1, SDL_RENDERER_SOFTWARE.rawValue)

SDL_RenderSetScale(renderer, 5.0, 5.0)

var quit = false
var event: SDL_Event = SDL_Event()

let fps_interval : UInt32 = 1000
var fps_counter : UInt32 = 0
var fps_current : UInt32 = 0 // the current FPS.
var fps_frames : UInt32 = 0  // frames passed since the last recorded fps.
var elapsed_time : UInt32 = 0
var last_ticks = SDL_GetTicks()

while(!quit) {
  SDL_PollEvent(&event)
  switch SDL_EventType(event.type) {
    case SDL_QUIT,
    SDL_KEYUP where event.key.keysym.sym == SDLK_ESCAPE.rawValue:
    quit = true
  default:
    break
  }

  let ticks = SDL_GetTicks()
  elapsed_time = ticks - last_ticks
  last_ticks = ticks

  for y in 0...height {
    for x in 0...width {
      SDL_SetRenderDrawColor(renderer, UInt8.random(in: 0...255), UInt8.random(in: 0...255), UInt8.random(in: 0...255), 255)
      SDL_RenderDrawPoint(renderer, x, y)
    }
  }

  SDL_RenderPresent(renderer)

  fps_frames += 1
  fps_counter += elapsed_time

  if fps_counter > fps_interval  {
    fps_current = fps_frames
    fps_counter = 0
    fps_frames = 0

    SDL_SetWindowTitle(window, "SDL test - \(fps_current) fps")
  }
}

SDL_DestroyWindow(window)
SDL_DestroyRenderer(renderer)
SDL_Quit()
