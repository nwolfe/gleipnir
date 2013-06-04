class Enemy < Chingu::GameObject
  trait :collision_detection
  trait :bounding_box, :scale => [0.60, 0.80]

  def setup
    @image = Chingu::Animation.new(:file => "enemy_sheet_32x32.png")[rand(6)]
  end
end
