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

  # question for later -- is this like when the user/player chooses a cell to "attack?"
  # refactor note may need to revisit this when we code the user input logic
  def fire_upon(fire_coordinate)
    if fire_coordinate == @coordinate
      if empty? == true
        @fired_upon = true
      elsif empty? == false
        @ship.hit
        @fired_upon = true
      end
    end
  end

  # refactor note, I wonder if we could use what we learned about falsey and truthy to simplify this
  # since any object that's not 'nil' or 'false' is treated as truthy.
  
  # added an optional argument that isn't required when calling the method by setting a default value
  def render(show_ship = false)
    if fired_upon? == false
      if show_ship == true && empty? == false
        return "S"
      else
        return "."
      end
    elsif fired_upon? == true && empty? == true
      return "M"
    elsif fired_upon? == true && empty? == false && @ship.sunk? == true
      return "X"
    elsif fired_upon? == true && empty? == false
      return "H"
    end
  end

  
end