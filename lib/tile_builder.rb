class TileBuilder

  def initialize(zone_height, zone_width, tile_size)
    @zone_height = zone_height
    @zone_width = zone_width
    @tile_size = tile_size
  end

  def place_tile(tile, x, y)
    tile.create(:x => x, :y => y)
  end

  def fill(starting_x, starting_y, width, height, tile)
    width = snap_to_size(width, @tile_size)
    height = snap_to_size(height, @tile_size)
    tpr = width / @tile_size
    tpc = height / @tile_size

    tpr.times do |row|
      x = starting_x + (row * @tile_size)
      tpc.times do |col|
        y = starting_y + (col * @tile_size)
        place_tile(tile, x, y)
      end
    end
  end

  def fill_with(tile)
    fill(0, 0, @zone_width, @zone_height, tile)
  end

  def fill_with_grass
    fill_with Grass
  end

  def fill_with_trees
    fill_with BushyTree
  end

  def build_zone
    length = (@zone_height / @tile_size) - 1 # how long the cave should be in tiles (fixed or not fixed)
    roughness = 50 # how much the cave varies in width, 1 to 100
    windyness = 50 # how much the cave varies in positioning, 1 to 100

    # start with layers of grass and trees
    fill_with_grass
    fill_with_trees

    starting_x = snap_to_tile(@zone_width / 2)
    starting_y = 1
    starting_width = @zone_width / 5
    fill(starting_x, starting_y, starting_width, 1, Grass)
  end

  def snap_to_tile(length)
    snap_to_size(length, @tile_size)
  end

  def snap_to_size(length, size)
    ((length.to_f / size).ceil) * size
  end
end
