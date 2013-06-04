class BushyTree < Chingu::GameObject
  trait :collision_detection
  trait :bounding_box, :scale => 0.80, :debug => true

  def setup
    @image = Image["terrain/bushy_tree.png"]
    cache_bounding_box
  end
end

class BushyTreeApples < Chingu::GameObject
  trait :collision_detection
  trait :bounding_box, :scale => 0.80

  def setup
    @image = Image["terrain/bushy_tree_apples.png"]
  end
end

class WillowTree < Chingu::GameObject
  trait :collision_detection
  trait :bounding_box, :scale => 0.80, :debug => true

  def setup
    @image = Image["terrain/willow.png"]
    cache_bounding_box
  end
end
