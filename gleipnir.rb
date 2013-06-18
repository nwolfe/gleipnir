require 'chingu'
include Gosu

require_all File.join(ROOT, "lib")

class Gleipnir < Chingu::Window
  def setup
    self.caption = "Gleipnir!"
    switch_game_state StartingZone
  end
end

Gleipnir.new.show
