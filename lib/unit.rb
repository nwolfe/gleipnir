class Unit < Chingu::GameObject
  traits :collision_detection, :timer
  trait :bounding_box, :scale => [0.60, 0.80]

  def flash_white
    during(20) { self.mode = :additive }.then { self.mode = :default }
  end

  def update
    @last_x = @x
    @last_y = @y
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

  ## Implemented by subclasses
  def collision_detected?
    false
  end
end
