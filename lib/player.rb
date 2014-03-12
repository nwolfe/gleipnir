class Player < Unit
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

    @animations = Chingu::Animation.new(:file => "player_shadow_32x32.png")
    @animations.frame_names = {
      :down => 0..2,
      :up => 3..5,
      :right => 6..8,
      :left => 9..11
    }

    @attack_animations = Chingu::Animation.new(:file => "player_attack_32x32.png")
    @attack_animations.frame_names = {
      :down => 0..1,
      :up => 2..3,
      :right => 4..5,
      :left => 6..7
    }

    @image = @animations[:down].next
    update

    @direction = :down
    @health = 16

    cache_bounding_box
  end

  def increase_health(amount)
    @health += amount
  end

  def take_damage(amount)
    @health -= amount
    flash_white
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

    @image = @attack_animations[@direction][1]
    after(200) { @image = @attack_animations[@direction][0] }

    Enemy.each_at(x, y) do |enemy|
      enemy.take_damage(1)
      enemy.attack(self)
    end
  end

  def collision_detected?
    impassables = [Enemy, BushyTree, WillowTree]
    impassables.each { |i| return true if self.first_collision(i) }
    return false
  end
end
