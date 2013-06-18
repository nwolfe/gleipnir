require 'chingu'
include Gosu

require './starting_zone.rb'

class Gleipnir < Chingu::Window
  def setup
    self.caption = "Gleipnir!"
    switch_game_state StartingZone
  end
end

Gleipnir.new.show
