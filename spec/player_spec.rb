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

    describe '#create ship list' do
   
        before(:each) do
            @player1 = Player.new("computer")
            @player2 = Player.new("player")
            @cruiser = Ship.new("Cruiser", 3)
            @submarine = Ship.new("Submarine", 2)
        end

        it 'adds ships to the ship list' do

            @player1.create_ship_lists(@cruiser)
            @player1.create_ship_lists(@submarine)

            expect(@player1.ships).to include(@cruiser)
            expect(@player1.ships).to include(@submarine)
            expect(@player1.ships.length). to eq(2)
        end

        it '___' do
            #computer player test
        end
    end

    describe '#all_ships_sunk' do
        it 'returns false if at least one is afloat' do
            cruiser = Ship.new("Cruiser", 3)
            submarine = Ship.new("Submarine", 2)
            player = Player.new("player")

            player.create_ship_lists(cruiser)
            player.create_ship_lists(submarine)

            cruiser.hit
            cruiser.hit
            cruiser.hit

            expect(cruiser.sunk?).to be(true)
            expect(player.all_ships_sunk?).to eq(false)
        end

        it 'returns true if all ships are sunk' do
            
            player = Player.new("player")
            cruiser = Ship.new("Cruiser", 3)
            submarine = Ship.new("Submarine", 2)
            

            player.create_ship_lists(cruiser)
            player.create_ship_lists(submarine)

            cruiser.hit
            cruiser.hit
            cruiser.hit
            submarine.hit
            submarine.hit

            expect(player.all_ships_sunk?).to be true

        end
    end
    
end