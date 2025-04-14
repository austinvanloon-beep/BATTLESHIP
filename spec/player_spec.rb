require 'spec_helper'

RSpec.describe Player do
    before(:each) do
        @player1 = Player.new("computer")
        @player2 = Player.new("player")
        @player1.computer_player
        @player2.computer_player
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

    describe '#create_ship_list' do
   
        before(:each) do
            @player1 = Player.new("computer")
            @player2 = Player.new("player")
            @cruiser = Ship.new("Cruiser", 3)
            @submarine = Ship.new("Submarine", 2)
        end

        it 'adds ships to the ship list' do
            
            @player1.create_ship_list(@cruiser)
            @player1.create_ship_list(@submarine)
            
            expect(@player1.ships).to include(@cruiser)
            expect(@player1.ships).to include(@submarine)
            expect(@player1.ships.length).to eq(2)
        end

        # placeholder for what Austin does separately
        it '___' do
            
        end
    end
end