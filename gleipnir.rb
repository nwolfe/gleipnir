require 'chingu'
include Gosu

class Gleipnir < Chingu::Window
  def initialize
    super
    self.caption = "Gleipnir!"
    push_game_state Intro
  end
end

class Intro < Chingu::GameState
  def initialize(options = {})
    super
    Chingu::Text.create(:text => "G L E I P N I R", :x => 375, :y => 50)
    Chingu::Text.create(:text => "Programming by Nate Wolfe", :x => 350, :y => 150)
    Chingu::Text.create(:text => "Artwork by Lew Lewis", :x => 365, :y => 170)
    Chingu::Text.create(:text => "PRESS S TO START", :x => 370, :y => 400)
    self.input = {:s => Play}
  end
end

class Play < Chingu::GameState
  def initialize(options = {})
    super
    self.input = {:escape => :exit}
    @player = Player.create(:x => 200, :y => 200)
  end
end


class Player < Chingu::GameObject
  def setup
    self.input = {
      [:holding_up, :holding_k] => :move_up,
      [:released_up, :released_k] => :halt_up,

      [:holding_down, :holding_j] => :move_down,
      [:released_down, :released_j] => :halt_down,

      [:holding_left, :holding_h] => :move_left,
      [:released_left, :released_h] => :halt_left,
        
      [:holding_right, :holding_l] => :move_right,
      [:released_right, :released_l] => :halt_right
    }

    @animations = Chingu::Animation.new(:file => "sprite_sheet_32x32.png")
    @animations.frame_names = {
      :down => 0..2, 
      :up => 3..5, 
      :left => 6..8, 
      :right => 9..11
    }
    @image = @animations[:down].next
  end

  def move_left
    @x -= 3
    @image = @animations[:left].next
  end

  def halt_left
    @image = @animations[:left].first
  end

  def move_right
    @x += 3
    @image = @animations[:right].next
  end

  def halt_right
    @image = @animations[:right].first
  end

  def move_up
    @y -= 3
    @image = @animations[:up].next
  end

  def halt_up
    @image = @animations[:up].first
  end

  def move_down
    @y += 3
    @image = @animations[:down].next
  end

  def halt_down
    @image = @animations[:down].first
  end
end

Gleipnir.new.show
