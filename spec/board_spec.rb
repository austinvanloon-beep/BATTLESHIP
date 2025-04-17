require 'spec_helper'

RSpec.describe Board do
    describe '#can keep track of cells and validate coordinates' do
        it 'exists' do
            board = Board.new
            expect(board).to be_a(Board)
        end
        it 'is a hash with 16 value pairs' do
            board = Board.new
            expect(board.cells.length).to eq(16)
            expect(board.cells).to be_a(Hash)
        end
        it 'the key points to cell objects' do
            board = Board.new
            expect(board.cells.values.to_s["A1"]).to eq("A1")
            expect(board.cells["A1"]).to be_a(Cell)
        end
    end

    describe 'is validating coordinates' do
        it 'returns true for a valid coordinate' do
          board = Board.new
          expect(board.valid_coordinate?("A1")).to eq(true)
          expect(board.valid_coordinate?("D4")).to eq(true)
        end

        it 'returns false for an invalid coordinate' do
            board = Board.new
            expect(board.valid_coordinate?("A5")).to eq(false)
            expect(board.valid_coordinate?("E1")).to eq(false)
            expect(board.valid_coordinate?("A22")).to eq(false)
        end
    end

    describe 'is validating placements' do
        it 'is false if number of coordinates does not match ship length' do
            board = Board.new
            cruiser = Ship.new("Cruiser", 3)
            submarine = Ship.new("Submarine", 2)
            expect(board.valid_placement?(cruiser, ["A1", "A2"])).to eq(false)
            expect(board.valid_placement?(submarine, ["A2", "A3", "A4"])).to eq(false)
        end

        it 'is false if coordinates are not consecutive' do
            board = Board.new
            cruiser = Ship.new("Cruiser", 3)
            submarine = Ship.new("Submarine", 2)
          
            expect(board.valid_placement?(cruiser, ["A1", "A2", "A4"])).to eq(false)
            expect(board.valid_placement?(submarine, ["A1", "C1"])).to eq(false)
            expect(board.valid_placement?(cruiser, ["A3", "A2", "A1"])).to eq(false)
            expect(board.valid_placement?(submarine, ["C1", "B1"])).to eq(false)
        end
    end

    describe 'is placing ships' do
        
        before(:each) do
            @board = Board.new
            @cruiser = Ship.new("Cruiser", 3)
        end

        it 'places the same ship in all provided cells' do
            @board.place_ship(@cruiser, ["A1", "A2", "A3"])

            cell_1 = @board.cells["A1"]
            cell_2 = @board.cells["A2"]
            cell_3 = @board.cells["A3"]

            expect(cell_1.ship).to eq(@cruiser)
            expect(cell_2.ship).to eq(@cruiser)
            expect(cell_3.ship).to eq(@cruiser)

            expect(cell_3.ship == cell_2.ship).to eq(true)
        end

        it 'is not overlapping ships' do
            @board.place_ship(@cruiser, ["A1", "A2", "A3"])

            submarine = Ship.new("Submarine", 2) 
            @board.valid_placement?(submarine, ["A1", "B1"])

            expect(@board.valid_placement?(submarine, ["A1", "B1"])).to eq(false)
        end 
    end

    describe 'is rendering board correctly based on various game actions and board states' do
       
        before(:each) do
            @board = Board.new
            @cruiser = Ship.new("Cruiser", 3)
        end

        it 'is in a  4x4 grid formation with cells containing ships hidden by default' do
            @board.place_ship(@cruiser, ["A1", "A2", "A3"]) 

            expect(@board.render).to eq("  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n")
            # # => "  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n"

            expected_render =
            "  1 2 3 4 \n" +
            "A . . . . \n" +
            "B . . . . \n" +
            "C . . . . \n" +
            "D . . . . \n"

            expect(@board.render).to eq(expected_render)
        end

        it 'displays "S" for the cells which contain a ship when the optional argument for show_ship is passed' do
            @board.place_ship(@cruiser, ["A1", "A2", "A3"]) 

            expect(@board.render(true)).to eq("  1 2 3 4 \nA S S S . \nB . . . . \nC . . . . \nD . . . . \n")
            # # => "  1 2 3 4 \nA S S S . \nB . . . . \nC . . . . \nD . . . . \n"

            expected_render =
            "  1 2 3 4 \n" +
            "A S S S . \n" +
            "B . . . . \n" +
            "C . . . . \n" +
            "D . . . . \n"

            expect(@board.render(true)).to eq(expected_render)
        end

        it 'renders a board with a missed shot' do
            @board.cells["B4"].fire_upon
            
            expected_render = 
                "  1 2 3 4 \n" +
                "A . . . . \n" +
                "B . . . M \n" +
                "C . . . . \n" +
                "D . . . . \n"
            
            expect(@board.render).to eq(expected_render)    
        end

        it 'renders a board with a hit on a ship' do
            @board.place_ship(@cruiser, ["A1", "A2", "A3"])
          
            @board.cells["A1"].fire_upon
          
            expected_render = 
              "  1 2 3 4 \n" +
              "A H . . . \n" +
              "B . . . . \n" +
              "C . . . . \n" +
              "D . . . . \n"
          
            expect(@board.render).to eq(expected_render)
          end

          it 'renders a board with a sunken ship, a miss, and a hit' do
            @board.place_ship(@cruiser, ["B1", "C1", "D1"])
            submarine = Ship.new("Submarine", 2)
            @board.place_ship(submarine, ["A2", "A3"])
          
            # manually sinking the cruiser
            @board.cells["B1"].fire_upon
            @board.cells["C1"].fire_upon
            @board.cells["D1"].fire_upon
          
            # manually hitting but not sinking the submarine
            @board.cells["A2"].fire_upon
          
            # fire_upon a different cell with no ships and miss
            @board.cells["B4"].fire_upon
          
            expected_render = 
              "  1 2 3 4 \n" +
              "A . H . . \n" +
              "B X . . M \n" +
              "C X . . . \n" +
              "D X . . . \n"
          
            expect(@board.render).to eq(expected_render)
          end  
    end


end