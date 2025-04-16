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
            place_ship_random(ship)
          else
            coordinates = prompt_for_ship_placement(ship)
            @board.place(ship, coordinates)
          end
          @ships << ship
        end
    end

    def place_ship_randomly(ship)
        placed = false

        until placed
            coordinates = generate_valid_random_coordinates(ship.length)
            if board.valid_placement?(ship, coordinates)
                board.place_ship(ship, coordinates)
                placed = true
            end
        end

        @ships << ship
    end
      
    def prompt_for_coordinates
        puts "Enter a coordinate to fire on:"
        user_input = gets.chomp.upcase
      
        until @board.valid_coordinate?(user_input)
            puts "Invalid coordinate. Try again:"
            user_input = gets.chomp.upcase
        end
      
        user_input
    end
      
    def fire_prompt(opponents_board)
        coordinate = prompt_for_coordinates
        opponents_board.cells[coordinate].fire_upon(coordinate)
    end

    def generate_valid_random_coordinates(length)

        valid_coordinates = []
      
        until valid_coordinates.length == length
            coordinate = @board.cells.keys.sample
            valid_coordinates << coordinate unless valid_coordinates.include?(coordinate)
        end

        valid_coordinates
    end

    def fire_randomly(opponents_board)
        coordinate = opponents_board.cells.keys.sample
        opponents_board.cells[coordinate].fire_upon(coordinate)
    end

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