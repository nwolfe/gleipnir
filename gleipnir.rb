require 'chingu'
include Gosu

require_all File.join(ROOT, "lib")

class Gleipnir < Chingu::Window
  def initialize
    super(800, 1200, nil)
  end

  def setup
    self.caption = "Gleipnir!"
    switch_game_state GeneratedZone
  end
end

Gleipnir.new.show
