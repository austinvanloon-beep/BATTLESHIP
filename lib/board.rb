class Board

    attr_reader :cells

    def initialize
        @cells = {
            "A1" => Cell.new("A1"),
            "A2" => Cell.new("A2"),
            "A3" => Cell.new("A3"),
            "A4" => Cell.new("A4"),
            "B1" => Cell.new("B1"),
            "B2" => Cell.new("B2"),
            "B3" => Cell.new("B3"),
            "B4" => Cell.new("B4"),
            "C1" => Cell.new("C1"),
            "C2" => Cell.new("C2"),
            "C3" => Cell.new("C3"),
            "C4" => Cell.new("C4"),
            "D1" => Cell.new("D1"),
            "D2" => Cell.new("D2"),
            "D3" => Cell.new("D3"),
            "D4" => Cell.new("D4")
        }
    end

    # future note for us to make sure that since we are not validing placement or coordinates in this method again on the Board class,
    # we will need to do so somewhere else in the game logic, probably if we make a Player or Game class?
    def place_ship(ship, coordinates)
        coordinates.each do |coordinate|
            @cells[coordinate].place_ship(ship)
        end
    end

    # future refactor note -- if we make it to iteration 4, we may need to find a better way to handle larger and/or dynamic board sizes
    def render(show_ship = false)
        expected_render = 
        "  1 2 3 4 \n" +
        "A #{@cells["A1"].render(show_ship)} #{@cells["A2"].render(show_ship)} #{@cells["A3"].render(show_ship)} #{@cells["A4"].render(show_ship)} \n" +
        "B #{@cells["B1"].render(show_ship)} #{@cells["B2"].render(show_ship)} #{@cells["B3"].render(show_ship)} #{@cells["B4"].render(show_ship)} \n" +
        "C #{@cells["C1"].render(show_ship)} #{@cells["C2"].render(show_ship)} #{@cells["C3"].render(show_ship)} #{@cells["C4"].render(show_ship)} \n" +
        "D #{@cells["D1"].render(show_ship)} #{@cells["D2"].render(show_ship)} #{@cells["D3"].render(show_ship)} #{@cells["D4"].render(show_ship)} \n" 
        
        return expected_render
    end

    def valid_coordinate?(coordinate)
        @cells.keys.include?(coordinate)
    end

    def valid_placement?(ship, coordinates)
        
        return false unless coordinates.length == ship.length
        letters = coordinates.map { |coordinate| coordinate[0] }
        numbers = coordinates.map { |coordinate| coordinate[1..-1].to_i }

        if letters.uniq.length == 1
            return false unless numbers.each_cons(2).all? { |a, b| b == a + 1 }
        elsif numbers.uniq.length == 1
            letter_numerical_values = letters.map { |letter| letter.ord }
            return false unless letter_numerical_values.each_cons(2).all? { |a, b| b == a + 1 }
        else
            return false 
        end
        return false if coordinates.any? { |coordinate| @cells[coordinate].empty? == false }

    end
        true
    end