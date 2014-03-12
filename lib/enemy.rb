class Enemy < Unit

  SPEED = 2

  def setup
    @image = Chingu::Animation.new(:file => "skeleton_sheet_32x32.png")[rand(6)]
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
    random_direction = [[0, -1], [0, 1], [-1, 0], [1, 0]].sample
    during(500) {
      delta_x = random_direction[0] * SPEED
      delta_y = random_direction[1] * SPEED
      move(delta_x, delta_y)
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
