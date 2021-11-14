lib LibSDL
  fun SDL_GetTicks : UInt32
end

module SDL
  def self.ticks
    LibSDL.SDL_GetTicks
  end
end
