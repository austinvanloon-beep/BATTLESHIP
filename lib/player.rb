class Player
    
    attr_reader :name, :board, :ships, :is_computer
    
    def initialize(name)
        @name = name
        @board = Board.new
        @ships = []
        @is_computer = false
    end

    # placeholder for what Austin does separately
    # note to revisit / refactor of what we have now for #create_ship_list method so that the player, when placing a ship,
    # that doesn't necessarily always add it to the @ships array, like if it isn't a valid placement in the first place
    # def place_ship(ship_list)
        
    #     ship_list.each do |ship|
    #         if @is_computer
    #           place_ship_randomly(ship)
    #         else
    #           prompt_for_ship_placement(ship)
    #         end

    #     @ships << ship
    #     end
    # end

    # placeholder for what Austin does separately
    # def prompt_for_ship_placement

    # end

    # placeholder for what Austin does separately
    # def place_ship_randomly

    # end

    # placeholder for what Austin does separately
    # def take_turn(opponents_board)
    #     if @is_computer == true
    #         fire_randomly(opponents_board)
    #     else
    #         fire_prompt(opponents_board)
    #     end
    # end

    def create_ship_list(ship)
        @ships << ship
    end
    
    def all_ships_sunk?
        @ships.all? {|ship| ship.sunk?}
    end

    def computer_player
        if @name == "computer"
            @is_computer = true
        end
    end
end