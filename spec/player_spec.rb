require 'spec_helper'

RSpec.describe Player do
    before(:each) do
        @player1 = Player.new("computer")
        @player2 = Player.new("player")
    end

    describe '#initialize' do
        it 'exists' do
            expect(@player1).to be_a(Player)
        end

        it 'has a name of computer' do
            @player1.computer_player
            expect(@player1.name).to eq("computer")
            expect(@player1.is_computer).to eq(true)
        end
      
        it 'has a board' do
            expect(@player1.board).to be_a(Board)
        end
      
        it 'starts with no ships' do
            expect(@player1.ships).to eq([])
        end
    end

    describe '#place ship array' do
   
        it 'ship list' do
            @board = Board.new
            @player1 = Player.new("computer")
            @player2 = Player.new("player")
            cruiser = Ship.new("Cruiser", 3)
            submarine = Ship.new("Submarine", 2)
            @player1.board.place_ship(cruiser, ["A1", "A2", "A3"])
            @player1.board.place_ship(submarine, ["B1", "B2"])
            @player1.create_ships
        end

        it '___' do
            
        end
    end
end