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
end

class FullHealth < Health
  def initialize(options = {})
    super(options.merge(
      :image  => "item/health_full.png",
      :amount => 10
    ))
  end
end

class HalfHealth < Health
  def initialize(options = {})
    super(options.merge(
      :image  => "item/health_half.png",
      :amount => 5
    ))
  end
end
