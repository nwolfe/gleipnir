require './player.rb'

class Enemy < Chingu::GameObject
  traits :collision_detection, :timer
  trait :bounding_box, :scale => [0.60, 0.80]

  def setup
    @image = Chingu::Animation.new(:file => "enemy_sheet_32x32.png")[rand(6)]
    @life = 10
  end

  def attack(player)
    player.take_damage(1)
  end

  def take_damage(amount)
    @life -= amount
    self.mode = :additive
    after(50) { self.mode = :default }
    puts "You hit for #{amount}! (#{@life})"
    destroy if @life <= 0
  end
end
