class Player
    attr_reader :name, :board, :ships, :is_computer
    def initialize(name)
        @name = name
        @board = Board.new
        @ships = []
        @is_computer = false
    end

    # REFACTOR create_ships so its not hardcoded for cruiser and sub

    def create_ship_lists(ship)
        @ships << ship
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