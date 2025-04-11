class Cell

  attr_reader :coordinate, :ship

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @fired_upon = false
  end

  def empty?
    if @ship != nil
      return true
    else 
      return false
    end
  end

  def place_ship(ship)
    @ship = ship
  end
  
  def fired_upon?

  end

  #is this like when the user/player chooses a cell to "attack?"
  def fired_upon
    
  end


end