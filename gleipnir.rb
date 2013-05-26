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
      [:holding_left, :holding_h] => :move_left,
      [:holding_right, :holding_l] => :move_right,
      [:holding_up, :holding_k] => :move_up,
      [:holding_down, :holding_j] => :move_down
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

  def move_right
    @x += 3
    @image = @animations[:right].next
  end

  def move_up
    @y -= 3
    @image = @animations[:up].next
  end

  def move_down
    @y += 3
    @image = @animations[:down].next
  end
end

Gleipnir.new.show
