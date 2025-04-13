require 'spec_helper'

RSpec.describe Board do
    #binding.pry
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
        
        #board = Board.new
        #cruiser = Ship.new("Cruiser", 3)
        #submarine = Ship.new("Submarine", 2)
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
    # can't test this until Austin finishes the validation logic
        it 'is not overlapping ships' do

        
        end
    end

    describe 'is rendering board' do
       
        before(:each) do
            @board = Board.new
            @cruiser = Ship.new("Cruiser", 3)
        end

        it 'in a  4x4 grid formation with cells containing ships hidden by default' do
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

        it 'and displays "S" for the cells which contain a ship when the optional argument for show_ship is passed' do
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
    end


end

# As you move forward, you will need to add functionality to your game so that you can fire on Cells and damage their Ships. 
# When you do this, you should also add new tests for your render method that it can render with Hits, Misses, and Sunken Ships. 
# A Board in the middle of a game might be rendered as something like this:

#     "  1 2 3 4 \n" +
#     "A H . . . \n" +
#     "B . . . M \n" +
#     "C X . . . \n" +
#     "D X . . . \n"
    
#     "  1 2 3 4 \n" +
#     "A H S S . \n" +
#     "B . . . M \n" +
#     "C X . . . \n" +
#     "D X . . . \n"