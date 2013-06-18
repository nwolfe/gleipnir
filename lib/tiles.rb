# TILES
class Tile < Chingu::GameObject
  def setup
    @image = Image["#{self.filename}.png"]
  end
end

class Dirt < Tile; end
class Grass < Tile; end
class GrassRocks < Tile; end
#class Gravel < Tile; end
#class MossGround < Tile; end
#class MossStone < Tile; end
#class Mud < Tile; end
#class MudFloor < Tile; end
#class MudFloorGold < Tile; end
#class RockPath < Tile; end

# TREES
class Tree < Tile
  trait :collision_detection
  trait :bounding_box, :scale => 0.80
end

class BushyTree < Tree; end
class WillowTree < Tree; end
#class BushyTreeApples < Tree; end

# WALLS
#class Wall < Tile
#  traits :bounding_box, :collision_detection
#end

#class DarkBrick < Wall; end
#class RockWall < Wall; end
#class CaveWall < Wall; end
#class CaveWall2 < Wall; end
#class CaveWallGold < Wall; end
#class CaveWallShade < Wall; end
