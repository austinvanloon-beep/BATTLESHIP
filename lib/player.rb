class Player
    
    attr_reader :name, :board, :ships, :is_computer
    
    def initialize(name)
        @name = name
        @board = Board.new
        @ships = []
        @is_computer = false
    end

  
    def place_ship(ship_list)
        
        ship_list.each do |ship|
            if @is_computer
              place_ship_randomly(ship)
            else
              prompt_for_ship_placement(ship)
            end

        @ships << ship
        end
    end

    # note to revisit / refactor of what we have now for #create_ship_list method so that the player, when placing a ship,
    # that doesn't necessarily always add it to the @ships array, like if it isn't a valid placement in the first place
    # maybe something like this (with adjusted method names of course)

    def create_ship_lists(ship, coordinates)
        if board.valid_placement?(ship, coordinates)
          board.place_ship(ship, coordinates)
          @ships << ship
        else
          puts "Invalid placement. Please try again." unless @is_computer
        end
    end

    # placeholder for what Austin does separately for player turn
    def prompt_for_coordinates
        puts "Enter a coordinate to fire on:"
        input = gets.chomp.upcase
        until valid_coordinate?(input)
          puts "Invalid coordinate. Try again:"
          input = gets.chomp.upcase
        end
        input
    end
    
    # placeholder for what Austin does separately for computer turn
    def place_ship_randomly(ship)
        placed = false
        until placed
            coordinates = board.generate_random_coordinates(ship.length)
            if board.valid_placement?(ship, coordinates)
                board.place_ship(ship, coordinates)
                @ships << ship
                placed = true
            end
        end
    end

    # placeholder for what Austin does separately to recognize player1 (human) board vs player2 (computer) board
    def take_turn(opponents_board)
        if @is_computer == true
            fire_randomly(opponents_board)
        else
            fire_prompt(opponents_board)
        end
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