require 'chingu'
include Gosu

require './player.rb'
require './tiles.rb'

class Gleipnir < Chingu::Window
  def setup
    self.caption = "Gleipnir!"
    push_game_state StartingZone
  end
end

## STATES

=begin
class Intro < Chingu::GameState
  def setup
    Chingu::Text.create(:text => "G L E I P N I R", :x => 375, :y => 50)
    Chingu::Text.create(:text => "Programming by Nate Wolfe", :x => 350, :y => 150)
    Chingu::Text.create(:text => "Artwork by Lew Lewis", :x => 365, :y => 170)
    Chingu::Text.create(:text => "PRESS S TO START", :x => 370, :y => 400)
    self.input = {:s => StartingZone, :escape => :exit}
  end
end
=end

class StartingZone < Chingu::GameState
  trait :viewport

  def setup
    self.input = {:escape => :exit, :e => Chingu::GameStates::Edit}
    self.viewport.lag = 0
    self.viewport.game_area = [0, 0, 864, 672]
    fill_with_grass
    load_game_objects
    @player = Player.create(:x => 200, :y => 200)
  end

  def fill_with_grass
    tiles_per_row = (self.viewport.game_area.width / 32) + 1
    tiles_per_col = (self.viewport.game_area.height / 32) + 1

    tiles_per_col.times do |col|
      y = col * 32
      tiles_per_row.times do |row|
        x = row * 32
        Grass.create(:x => x, :y => y)
      end
    end
  end

  def update
    super
    self.viewport.center_around(@player)
  end
end

Gleipnir.new.show
