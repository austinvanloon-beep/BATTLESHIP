class Ship
  
  attr_reader :name, :length, :health

  def initialize(name, length)
      @name = name
      @length = length
      @health = length
  end

  # refactor note I think we could write this without all the explicit
  # conditional stuff and just say @health == 0 which would by definition
  # already be a boolean true/false when evaluating that question
  def sunk?
      if @health == 0
          return true
      else false
      end
  end

  # refactor note do we need to account for guessing the same
  # cell multiple times and possibly going negative health?
  def hit
      @health -= 1
  end


end
