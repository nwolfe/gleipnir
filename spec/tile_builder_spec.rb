require 'tile_builder'

class TestBuilder < TileBuilder

  def initialize(zone_height, zone_width, tile_size)
    @zone_height = zone_height
    @zone_width = zone_width
    @tile_size = tile_size
  end

  def place_tile(tile, x, y)
    puts tile, x, y
  end
end

describe TileBuilder do
  describe "snap_to_size" do
    it "works" do
      b = TestBuilder.new(32, 96, 32)
      b.fill_with('foo')
    end
  end
end
