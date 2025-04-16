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

  def fire_upon(cell)
    # added this to prevent double damage
    return if @fired_upon

    @fired_upon = true
    @ship.hit unless empty?
  end

  # check this method out later to make sure it's working correctly in game logic
  def render(show_ship = false)
    if fired_upon?
      if show_ship && empty? == false
        return "S"
      else
        return "."
      end
    elsif fired_upon? && empty?
      return "M"
    elsif fired_upon? && empty? == false && @ship.sunk?
      return "X"
    elsif fired_upon? && empty? == false
      return "H"
    end
  end

  
end