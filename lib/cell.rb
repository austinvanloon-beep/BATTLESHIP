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

  # future refactor note, the interaction pattern indicataed to be able to pass a cell argument into this method
  # but I think we can simplify to `fire_upon` without needing an argument and let the object manage its own state instead?
  def fire_upon(cell)
    # added this to prevent double damage being possible
    return if @fired_upon

    @fired_upon = true
    @ship.hit unless empty?
  end

  # check this method out later to make sure it's working correctly in game logic
  def render(show_ship = false)
    if fired_upon?
      if empty?
        "M"
      elsif @ship.sunk?
        "X"
      else
        "H"
      end
    else
      if show_ship && empty? == false
        "S"
      else
        "."
      end
    end
  end
  

  
end