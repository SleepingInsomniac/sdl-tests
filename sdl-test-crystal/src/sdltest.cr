require "sdl"

SDL.init(SDL::Init::VIDEO)
at_exit { SDL.quit }

width = 100
height = 60
scale = 5

window = SDL::Window.new("SDL test", width * scale, height * scale)
renderer = SDL::Renderer.new(window, flags: SDL::Renderer::Flags::SOFTWARE)

width, height = window.size
renderer.scale = {scale, scale}

FPS_INTERVAL = 1.0
fps_lasttime = Time.monotonic.total_milliseconds # the last recorded time.
fps_current : UInt32 = 0                         # the current FPS.
fps_frames : UInt32 = 0                          # frames passed since the last recorded fps.

loop do
  case event = SDL::Event.poll
  when SDL::Event::Quit
    break
  end

  0.upto(height) do |y|
    0.upto(width) do |x|
      renderer.draw_color = SDL::Color[rand(0..255), rand(0..255), rand(0..255), 255]
      renderer.draw_point(x, y)
    end
  end

  renderer.present

  fps_frames += 1

  if fps_lasttime < Time.monotonic.total_milliseconds - FPS_INTERVAL * 1000
    fps_lasttime = Time.monotonic.total_milliseconds
    fps_current = fps_frames
    fps_frames = 0
    window.title = String.build { |io| io << "SDL test - " << fps_current << " fps" }
  end
end
