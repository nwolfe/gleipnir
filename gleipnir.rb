require 'chingu'
include Gosu

class Gleipnir < Chingu::Window
  def initialize
    super
    self.input = {:escape => :exit}
    self.caption = "Gleipnir!"
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
    @image = @animations[:left][0]
  end

  def move_right
    @x += 3
    @image = @animations[:right].next
  end

  def halt_right
    @image = @animations[:right][0]
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
