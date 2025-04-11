class Cell

  attr_reader :coordinate, :ship

  def initialize(coordinate)
    @coordinate = coordinate
    :ship
  end

  def empty?
    if :ship != nil
      return true
    else 
      return false
    end
  end

  def place_ship(ship)
    :ship => ship
  end


end