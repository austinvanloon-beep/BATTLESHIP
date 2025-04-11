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
  def fire_upon(fire_coordinate)
    if fire_coordinate == @coordinate
      if empty? == true
        @fired_upon = true
      else
        @ship.hit               
      end
    end
  end

  def render
    if fired_upon? == false
      return "."
    elsif fired_upon? == true && empty? == true
      return "M"
    elsif fired_upon? == true && empty? == false
      return "H"
    elsif fired_upon? == true && empty? == false && @ship.sunk? == true
      return "X"
    # elsif empty? == true
    #   return "S"
    else
    end
  end

end