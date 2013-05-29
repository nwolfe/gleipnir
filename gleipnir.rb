require 'chingu'
include Gosu

class Gleipnir < Chingu::Window
  def setup
    self.caption = "Gleipnir!"
    push_game_state Intro
  end
end

class Intro < Chingu::GameState
  def setup
    Chingu::Text.create(:text => "G L E I P N I R", :x => 375, :y => 50)
    Chingu::Text.create(:text => "Programming by Nate Wolfe", :x => 350, :y => 150)
    Chingu::Text.create(:text => "Artwork by Lew Lewis", :x => 365, :y => 170)
    Chingu::Text.create(:text => "PRESS S TO START", :x => 370, :y => 400)
    self.input = {:s => Play, :escape => :exit}
  end
end

class Play < Chingu::GameState
  def setup
    self.input = {:escape => :exit, :e => Chingu::GameStates::Edit}
    load_game_objects # Load objects from "play.yml"
    #create_level
    @player = Player.create(:x => 200, :y => 200)
  end

  def create_level
    # left wall
    for i in 0..15
      x = 64
      y = 64 + (32*i)
      Wall.create(:x => x, :y => y) 
    end
    # right wall
    for i in 0..15
      x = 64 + (32*21)
      y = 64 + (32*i)
      Wall.create(:x => x, :y => y) 
    end
    # top wall
    for i in 1..21
      x = 64 + (32*i)
      y = 64
      Wall.create(:x => x, :y => y) 
    end
    # bottom wall
    for i in 1..21
      x = 64 + (32*i)
      y = 64 + (32*15)
      Wall.create(:x => x, :y => y) 
    end

    # Fill with Grass
    for i in 0..19
      for j in 0..13
        x = 96 + (32*i)
        y = 96 + (32*j)
        Grass.create(:x => x, :y => y)
      end
    end
  end
end

class Grass < Chingu::GameObject
  def setup
    @image = Image["grass.png"]
  end
end

class Wall < Chingu::GameObject
  traits :bounding_box, :collision_detection

  def setup
    @image = Image["dark_brick.png"]
  end
end

class Player < Chingu::GameObject
  traits :bounding_box, :collision_detection

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

    @animations = Chingu::Animation.new(:file => "player_sheet2_32x32.png")
    @animations.frame_names = {
      :down => 0..2, 
      :up => 3..5, 
      :right => 6..8, 
      :left => 9..11
    }
    @image = @animations[:down].next
    update
  end

  def update
    @last_x = @x
    @last_y = @y
  end

  def move_left
    @x -= 3
    @image = @animations[:left].next
    @x = @last_x if self.first_collision(Wall)
  end

  def halt_left
    @image = @animations[:left].first
  end

  def move_right
    @x += 3
    @image = @animations[:right].next
    @x = @last_x if self.first_collision(Wall)
  end

  def halt_right
    @image = @animations[:right].first
  end

  def move_up
    @y -= 3
    @image = @animations[:up].next
    @y = @last_y if self.first_collision(Wall)
  end

  def halt_up
    @image = @animations[:up].first
  end

  def move_down
    @y += 3
    @image = @animations[:down].next
    @y = @last_y if self.first_collision(Wall)
  end

  def halt_down
    @image = @animations[:down].first
  end
end

Gleipnir.new.show
