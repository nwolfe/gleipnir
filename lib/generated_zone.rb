class GeneratedZone < Chingu::GameState
  trait :viewport

  def setup
    @tile_height = 32
    @tile_width = 32
    @zone_height = 800
    @zone_width = 600
    self.viewport.game_area = [0, 0, @zone_height, @zone_width]
    self.input = {:escape => :exit}

    generate_tiles

    @player = Player.create(:x => 200, :y => 200)
    @player_health = Chingu::Text.create(:size => 25)
    update_health_label
  end

  def update_health_label
    @player_health.x = viewport.x + 5
    @player_health.y = viewport.y + 5
    @player_health.text = @player.health
  end

  ## tile placing

  def fill(width, height, item)
    tiles_per_row = (width / @tile_width) + 1
    tiles_per_col = (height / @tile_height) + 1

    tiles_per_col.times do |col|
      y = col * @tile_width
      tiles_per_row.times do |row|
        x = row * @tile_height
        item.create(:x => x, :y => y)
      end
    end
  end

  def fill_with(item)
    fill(@viewport.game_area.width, @viewport.game_area.height, item)
  end

  def fill_with_grass
    fill_with Grass
  end

  def fill_with_trees
    fill_with BushyTree
  end

  ## tile generation

  def generate_tiles
    length = (@zone_height / @tile_height) - 1 # how long the cave should be in tiles (fixed or not fixed)
    roughness = 50 # how much the cave varies in width, 1 to 100
    windyness = 50 # how much the cave varies in positioning, 1 to 100

    # start with layers of grass and trees
    fill_with_grass
    fill_with_trees
  end
end
