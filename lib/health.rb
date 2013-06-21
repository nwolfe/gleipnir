class Health < Chingu::GameObject
  trait :collision_detection
  trait :bounding_box, :scale => 0.80

  def initialize(options = {})
    @amount = options[:amount]
    super(options)
  end

  def apply_to(player)
    player.increase_health(@amount)
  end

  def collides_with_anything?
    obstacles = [BushyTree, WillowTree, Enemy, Player]
    obstacles.each { |obstacle| return true if self.first_collision obstacle }
    return false
  end
end

class FullHealth < Health
  def initialize(options = {})
    super(options.merge(
      :image  => "health_full.png",
      :amount => 10
    ))
  end
end

class HalfHealth < Health
  def initialize(options = {})
    super(options.merge(
      :image  => "health_half.png",
      :amount => 5
    ))
  end
end
