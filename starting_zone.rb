require './tiles.rb'
require './trees.rb'
require './player.rb'
require './health.rb'
require './enemy.rb'

class StartingZone < Chingu::GameState
  trait :viewport

  def setup
    self.input = {:escape => :exit, :e => Chingu::GameStates::Edit}
    self.viewport.lag = 0
    self.viewport.game_area = [0, 0, 864, 672]
    fill_with_grass
    load_game_objects
    place_health
    @player = Player.create(:x => 200, :y => 200)
  end

  def edit
    push_game_state(Chingu::GameStates::Edit.new(:classes => [Enemy, FullHealth, HalfHealth]))
  end

  def fill_with_grass
    tiles_per_row = (self.viewport.game_area.width / 32) + 1
    tiles_per_col = (self.viewport.game_area.height / 32) + 1

    tiles_per_col.times do |col|
      y = col * 32
      tiles_per_row.times do |row|
        x = row * 32
        Grass.create(:x => x, :y => y)
      end
    end
  end

  def place_health
    FullHealth.create(:x => 750, :y => 300)
    HalfHealth.create(:x => 97, :y => 70)
  end

  def pickup_health
    @player.each_collision(FullHealth, HalfHealth) do |player, health|
      health.apply_to(@player)
      health.destroy
    end
  end

  def fight_enemies
    @player.each_collision(Enemy) do |player, enemy|
      player.attack(enemy)
      if enemy.dead?
        enemy.destroy
      else
        enemy.attack(player)
      end
    end
  end
  
  def update
    super
    self.viewport.center_around(@player)
    pickup_health
    fight_enemies
  end
end