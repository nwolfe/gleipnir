class Player < Chingu::GameObject
  traits :collision_detection, :timer
  trait :bounding_box, :scale => [0.60, 0.80]
  attr_reader :health

  def setup
    self.input = {
      [:holding_up, :holding_k] => :move_up,
      [:released_up, :released_k] => :halt_up,

      [:holding_down, :holding_j] => :move_down,
      [:released_down, :released_j] => :halt_down,

      [:holding_left, :holding_h] => :move_left,
      [:released_left, :released_h] => :halt_left,
        
      [:holding_right, :holding_l] => :move_right,
      [:released_right, :released_l] => :halt_right,

      :space => :attack
    }

    @animations = Chingu::Animation.new(:file => "player_sheet2_32x32.png", :delay => 200)
    @animations.frame_names = {
      :down => 0..2, 
      :up => 3..5, 
      :right => 6..8, 
      :left => 9..11
    }

    @image = @animations[:down].next
    update

    @direction = :down
    @health = 16
  end

  def increase_health(amount)
    @health += amount
  end

  def take_damage(amount)
    @health -= amount
    flash_white
  end

  def flash_white
    during(20) { self.mode = :additive }.then { self.mode = :default }
  end

  def dead?
    @health <= 0
  end

  def attack
    range = 15
    if :left == @direction
      x = self.bb.left - range
      y = self.bb.center_y
    elsif :right == @direction
      x = self.bb.right + range
      y = self.bb.center_y
    elsif :up == @direction
      x = self.bb.center_x
      y = self.bb.top - range
    elsif :down == @direction
      x = self.bb.center_x
      y = self.bb.bottom + range
    else
      return
    end

    Enemy.each_at(x, y) do |enemy|
      enemy.take_damage(1)
      enemy.attack(self)
    end
  end

  def update
    @last_x = @x
    @last_y = @y
  end

  def collision_detected?
    impassables = [Enemy, BushyTree, WillowTree]
    impassables.each { |i| return true if self.first_collision(i) }
    return false
  end

  def move(x, y)
    if x != 0
      @x += x
      @x = @last_x if collision_detected?
    end

    if y != 0
      @y += y
      @y = @last_y if collision_detected?
    end
  end

  def move_left
    @image = @animations[:left].next
    @direction = :left
    move(-2, 0)
  end

  def halt_left
    @image = @animations[:left].first
  end

  def move_right
    @image = @animations[:right].next
    @direction = :right
    move(2, 0)
  end

  def halt_right
    @image = @animations[:right].first
  end

  def move_up
    @image = @animations[:up].next
    @direction = :up
    move(0, -2)
  end

  def halt_up
    @image = @animations[:up].first
  end

  def move_down
    @image = @animations[:down].next
    @direction = :down
    move(0, 2)
  end

  def halt_down
    @image = @animations[:down].first
  end
end
