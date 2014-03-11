class GeneratedZone < Chingu::GameState

  def initialize
    super
  end

  def setup
    # Remove lingering objects
    Grass.destroy_all
    BushyTree.destroy_all

    tile_size = 32
    @zone_height = 1200
    @zone_width = 800 + tile_size
    #self.viewport.game_area = [0, 0, @zone_width, @zone_height]
    self.input = {:escape => :exit}

    builder = ZoneBuilder.new(@zone_height, @zone_width, tile_size)
    builder.build_zone(25, 30)
    @player = Player.create(:x => 100, :y => 10)
    builder.place_player_at_entrance(@player)

    @player_health = Chingu::Text.create(:size => 25)
    @player_health.x = 5
    @player_health.y = 5
    update_health_label
  end

  def update_health_label
    @player_health.text = @player.health
  end

  def update
    super
    update_health_label
    if @player.outside_window?
      goto_next_level
    end
  end

  def goto_next_level
    switch_game_state GeneratedZone.new
  end
end
