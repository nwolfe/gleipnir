require './player.rb'

class Enemy < Chingu::GameObject
  trait :collision_detection
  trait :bounding_box, :scale => [0.60, 0.80]

  def setup
    @image = Chingu::Animation.new(:file => "enemy_sheet_32x32.png")[rand(6)]
    @life = 10
  end

  def attack(player)
    player.take_damage(1)
  end

  def take_damage(amount)
    @life = @life - amount
    puts "You hit for #{amount}!"
  end

  def dead?
    @life <= 0
  end
end
