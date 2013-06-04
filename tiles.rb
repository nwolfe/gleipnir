class Dirt < Chingu::GameObject
  def setup
    @image = Image["floor/dirt.png"]
  end
end

class Grass < Chingu::GameObject
  def setup
    @image = Image["floor/grass.png"]
  end
end

class GrassRocks < Chingu::GameObject
  def setup
    @image = Image["floor/grass_rocks.png"]
  end
end

class Gravel < Chingu::GameObject
  def setup
    @image = Image["floor/gravel.png"]
  end
end

class MossGround < Chingu::GameObject
  def setup
    @image = Image["floor/moss_ground.png"]
  end
end

class MossStone < Chingu::GameObject
  def setup
    @image = Image["floor/moss_stone.png"]
  end
end

class Mud < Chingu::GameObject
  def setup
    @image = Image["floor/mud.png"]
  end
end

class MudFloor < Chingu::GameObject
  def setup
    @image = Image["floor/mud_floor.png"]
  end
end

class MudFloorGold < Chingu::GameObject
  def setup
    @image = Image["floor/mud_floor_gold.png"]
  end
end

class RockPath < Chingu::GameObject
  def setup
    @image = Image["floor/rock_path.png"]
  end
end

## WALL TILES
  
class DarkBrick < Chingu::GameObject
  traits :bounding_box, :collision_detection

  def setup
    @image = Image["wall/dark_brick.png"]
  end
end

class BushyTree < Chingu::GameObject
  trait :collision_detection
  trait :bounding_box, :scale => 0.80

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
  trait :bounding_box, :scale => 0.80

  def setup
    @image = Image["terrain/willow.png"]
    cache_bounding_box
  end
end

class RockWall < Chingu::GameObject
  traits :bounding_box, :collision_detection

  def setup
    @image = Image["wall/rock_wall.png"]
  end
end

class CaveWall < Chingu::GameObject
  traits :bounding_box, :collision_detection

  def setup
    @image = Image["wall/cave_wall.png"]
  end
end

class CaveWall2 < Chingu::GameObject
  traits :bounding_box, :collision_detection

  def setup
    @image = Image["wall/cave_wall_2.png"]
  end
end

class CaveWallGold < Chingu::GameObject
  traits :bounding_box, :collision_detection

  def setup
    @image = Image["wall/cave_wall_gold.png"]
  end
end

class CaveWallShade < Chingu::GameObject
  traits :bounding_box, :collision_detection

  def setup
    @image = Image["wall/cave_wall_shade.png"]
  end
end
