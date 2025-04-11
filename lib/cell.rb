class Cell

  attr_reader :coordinate, :ship

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @fired_upon = false
  end

  def empty?
    @ship == nil
  end

  def place_ship(ship)
    @ship = ship
  end
  
  def fired_upon?
    @fired_upon
  end

  #is this like when the user/player chooses a cell to "attack?"
  # refactor note may need to revisit this when we code the user input logic
  def fired_upon(fire_coordinate)
    if fire_coordinate == @coordinate
      if empty? == true
        @fired_upon = true
      else
        @ship.hit               
      end
    end
  end


end