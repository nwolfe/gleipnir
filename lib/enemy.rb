class Enemy < Unit

  def setup
    @animations = Chingu::Animation.new(:file => "skeleton_sheet_32x32.png")
    @animations.frame_names = {
      :down => 0..2,
      :up => 3..5,
      :right => 6..8,
      :left => 9..11
    }
    @image = @animations[:down].next
    @life = 10
    cache_bounding_box
    install_ai
  end

  def install_ai
    every(rand(1000..3000)) {
      after(rand(0..3000)) {
        move_in_random_direction
      }
    }
  end

  def move_in_random_direction
    dir = [:move_left, :move_down, :move_up, :move_right].sample
    during(500) {
      self.send(dir)
    }
  end

  def collision_detected?
    impassables = [BushyTree, WillowTree]
    impassables.each { |imp| return true if self.first_collision(imp) }
    Enemy.each { |enemy| return true if self != enemy && self.collides?(enemy) }
    return self.first_collision Player
  end

  def attack(player)
    player.take_damage(1)
  end

  def take_damage(amount)
    @life -= amount
    flash_white
    destroy if @life <= 0
  end
end
