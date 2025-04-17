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

  def fire_upon
    
    if @fired_upon
      puts "You've already fired there!"
      return
    end

    @fired_upon = true
    @ship.hit unless empty?
  end

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