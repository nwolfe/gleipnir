require './starting_zone.rb'

class Intro < Chingu::GameState
  def setup
    Chingu::Text.create(:text => "G L E I P N I R", :x => 375, :y => 50)
    Chingu::Text.create(:text => "Programming by Nate Wolfe", :x => 350, :y => 150)
    Chingu::Text.create(:text => "Artwork by Lew Lewis", :x => 365, :y => 170)
    Chingu::Text.create(:text => "PRESS S TO START", :x => 370, :y => 400)
    self.input = {:s => StartingZone, :escape => :exit}
  end
end
