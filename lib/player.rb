class Player
    attr_reader :name, :board, :ships
    def initialize(name)
        @name = name
        @board = Board.new
        @ships = []
    end

    def create_ships
        cruiser = Ship.new("Cruiser", 3)
    end
end