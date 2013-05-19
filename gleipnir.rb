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
  def initialize(options)
    super(options.merge(:image => Image["player_front.png"]))
    self.input = {
      :holding_left => :move_left,
      :holding_right => :move_right,
      :holding_up => :move_up,
      :holding_down => :move_down}
  end

  def move_left
    self.image = Image["player_right.png"]
    @x -= 3
  end

  def move_right
    self.image = Image["player_left.png"]
    @x += 3
  end

  def move_up
    self.image = Image["player_back.png"]
    @y -= 3
  end

  def move_down
    self.image = Image["player_front.png"]
    @y += 3
  end
end

Gleipnir.new.show