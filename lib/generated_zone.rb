class GeneratedZone < Chingu::GameState
  trait :viewport

  def setup
    tile_size = 32
    @zone_height = 1200 + tile_size
    @zone_width = 800 + tile_size
    self.viewport.game_area = [0, 0, @zone_width, @zone_height]
    self.input = {:escape => :exit}

    builder = TileBuilder.new(@zone_height, @zone_width, tile_size)
    builder.build_zone

    @player = Player.create(:x => 200, :y => 200)
    @player_health = Chingu::Text.create(:size => 25)
    update_health_label
  end

  def update_health_label
    @player_health.x = viewport.x + 5
    @player_health.y = viewport.y + 5
    @player_health.text = @player.health
  end
end
