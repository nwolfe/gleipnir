class Enemy < Chingu::GameObject
  traits :collision_detection, :timer
  trait :bounding_box, :scale => [0.60, 0.80]

  SPEED = 2

  def setup
    @image = Chingu::Animation.new(:file => "enemy_sheet_32x32.png")[rand(6)]
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

  def collision_detected?
    impassables = [BushyTree, WillowTree]
    impassables.each { |imp| return true if self.first_collision(imp) }
    Enemy.each { |enemy| return true if self != enemy && self.collides?(enemy) }
    return self.first_collision Player
  end

  def update
    @last_x = @x
    @last_y = @y
  end

  def attack(player)
    player.take_damage(1)
  end

  def take_damage(amount)
    @life -= amount
    flash_white
    puts "You hit for #{amount}! (#{@life})"
    destroy if @life <= 0
  end

  def flash_white
    during(20) { self.mode = :additive }.then { self.mode = :default }
  end
end
