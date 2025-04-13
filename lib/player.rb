class Player
    attr_reader :name, :board, :ships, :is_computer
    def initialize(name)
        @name = name
        @board = Board.new
        @ships = []
        @is_computer = false
    end

    # REFACTOR create_ships so its not hardcoded for cruiser and sub

    def create_ships
        cruiser = Ship.new("Cruiser", 3)
        submarine = Ship.new("Submarine", 2)
        @ships << cruiser
        @ships << submarine
    end

    def take_turn(opponents_board)

    end

    def all_ships_sunk
        @ships.all? {|ship| ship.sunk?}
    end

    def computer_player
        if @name = "computer"
            @is_computer = true
        end
    end
end