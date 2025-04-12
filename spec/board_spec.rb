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

        #board.valid_coordinate?("A1")
        #board.valid_coordinate?("D4")
        #board.valid_coordinate?("A5")
        #board.valid_coordinate?("E1")
        #board.valid_coordinate?("A22")

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
        
    end
end

# pry(main)> require './lib/board'
# # => true

# pry(main)> require './lib/ship'
# # => true

# pry(main)> board = Board.new
# # => #<Board:0x00007fcb0f056860...>

# pry(main)> cruiser = Ship.new("Cruiser", 3)    
# # => #<Ship:0x00007fcb0f0573f0...>

# pry(main)> board.place(cruiser, ["A1", "A2", "A3"])    

# pry(main)> board.render
# # => "  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n"

# pry(main)> board.render(true)
# # => "  1 2 3 4 \nA S S S . \nB . . . . \nC . . . . \nD . . . . \n"

# "  1 2 3 4 \n" +
# "A . . . . \n" +
# "B . . . . \n" +
# "C . . . . \n" +
# "D . . . . \n"

# "  1 2 3 4 \n" +
# "A S S S . \n" +
# "B . . . . \n" +
# "C . . . . \n" +
# "D . . . . \n"