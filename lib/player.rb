class Player
    
    attr_reader :name, :board, :ships, :is_computer
    
    def initialize(name)
        @name = name
        @board = Board.new
        @ships = []
        @is_computer = false
    end

    def computer_player

        if @name == "computer"
            @is_computer = true
        end
    end

    def prompt_for_ship_placement(ship)
        puts "Enter the coordinates for the #{ship.name} (#{ship.length} spaces):"
        gets.chomp.strip.upcase.split
    end  
      
    def place_ship(ship_list)
        ship_list.each do |ship|
          if @is_computer
            place_ship_randomly(ship)
          else
            placed = false
            
            until placed
              coordinates = prompt_for_ship_placement(ship)
              if @board.valid_placement?(ship, coordinates)
                @board.place(ship, coordinates)
                @ships << ship
                placed = true
              else
                puts "Invalid placement. Please enter a valid set of coordinates."
              end
            end
          end
        end
    end
      
    def prompt_for_coordinates(opponents_board)
        puts "Enter a coordinate to fire on:"
        
        loop do
            user_input = gets.chomp.strip.upcase
            
            if opponents_board.valid_coordinate?(user_input)
                return user_input
            else
                puts "Invalid coordinate. Try again:"
            end
        end
    end

    def fire_prompt(opponents_board)
        loop do 
            coordinate = prompt_for_coordinates(opponents_board)
            unless opponents_board.cells[coordinate].fired_upon?
                opponents_board.cells[coordinate].fire_upon(coordinate)
                break
            end
        end
    end

    def generate_valid_random_coordinates(length)

        valid_coordinates = []
      
        until valid_coordinates.length == length
            coordinate = @board.cells.keys.sample
            valid_coordinates << coordinate unless valid_coordinates.include?(coordinate)
        end

        valid_coordinates
    end

    def place_ship_randomly(ship)
        placed = false

        until placed
            coordinates = generate_valid_random_coordinates(ship.length)
            if board.valid_placement?(ship, coordinates)
                board.place_ship(ship, coordinates)
                placed = true
                @ships << ship
            end            
        end
    end
      
    def fire_randomly(opponents_board)
        loop do
            coordinate = opponents_board.cells.keys.sample
            unless opponents_board.cells[coordinate].fired_upon?
                opponents_board.cells[coordinate].fire_upon(coordinate)
                break
            end
        end
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


end