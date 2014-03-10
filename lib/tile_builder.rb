class TileBuilder

  def initialize(zone_height, zone_width, tile_size)
    @zone_height = zone_height
    @zone_width = zone_width
    @tile_size = tile_size
  end

  def place_tile(tile_class, x, y, replace)
    tile = tile_class.create(:x => x, :y => y)
    if replace
      BushyTree.all.each do |tree|
        if tile != tree && tile.x == tree.x && tile.y == tree.y
          tree.destroy
        end
      end
      Grass.all.each do |grass|
        if tile != grass && tile.x == grass.x && tile.y == grass.y
          grass.destroy
        end
      end
    end
  end

  def fill(starting_x, starting_y, width, height, tile_class, replace = true)
    width = snap_to_size(width, @tile_size)
    height = snap_to_size(height, @tile_size)
    tpr = width / @tile_size
    tpc = height / @tile_size

    tpr.times do |row|
      x = starting_x + (row * @tile_size)
      tpc.times do |col|
        y = starting_y + (col * @tile_size)
        place_tile(tile_class, x, y, replace)
      end
    end
  end

  def fill_with_grass
    fill(0, 0, @zone_width, @zone_height, Grass, false)
  end

  def fill_with_trees
    fill(0, 0, @zone_width, @zone_height, BushyTree, false)
  end

  def snap_to_tile(length)
    snap_to_size(length, @tile_size)
  end

  def snap_to_size(length, size)
    ((length.to_f / size).ceil) * size
  end

  def place_player_at_entrace(player)
    player.x = @zone_width / 2
    player.y = @tile_size
  end

  # roughness = how much the cave varies in width, 1 to 100
  # windyness = how much the cave varies in positioning, 1 to 100
  def build_zone(roughness, windyness)
    #length = (@zone_height / @tile_size) - 1 # how long the cave should be in tiles (fixed or not fixed)

    # start with layers of grass and trees
    fill_with_grass
    fill_with_trees

    # entrance / init
    starting_x = snap_to_tile(@zone_width / 3)
    starting_y = 0
    starting_width = @zone_width / 5
    fill(starting_x, starting_y, starting_width, @tile_size, Grass)
    fill(starting_x, @tile_size, starting_width, @tile_size, Grass)

    # loop
    x = starting_x
    y = starting_y
    width = starting_width

    while (y - starting_y < @zone_height)
      y += @tile_size

      if rand(1..100) <= roughness
        width += @tile_size * [-2, -1, 1, 2].sample
        if width < (3 * @tile_size)
          width = 3 * @tile_size
        end
        if width > @zone_width
          width = @zone_width
        end
      end

      if rand(1..100) <= windyness
        x += @tile_size * [-2, -1, 1, 2].sample
        if x < 0
          x = 0
        end
        if x > (@zone_width - (3 * @tile_size))
          x = @zone_width - (3 * @tile_size)
        end
      end

      fill(x, y, width, @tile_size, Grass)
    end
  end
end
