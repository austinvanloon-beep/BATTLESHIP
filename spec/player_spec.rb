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
            cruiser = Ship.new("Cruiser", 3)
            submarine = Ship.new("Submarine", 2)
        end

        it 'adds ships to the ship list' do

            @player1.create_ship_lists(@cruiser)
            @player1.create_ship_lists(@submarine)

            expect(@player1.ships).to include(@cruiser)
            expect(@player1.ships).to include(@submarine)
            expect(@player1.ships.length). to eq(2)
        end

        # it '___' do
        #     #computer player test
        # end
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

            expect(cruiser.sunk?).to be(false)
            expect(player.all_ships_sunk).to eq(false)
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

    describe '#prompt_for_coordinates' do
        it 'recognizes invalid input and re-prompts the user for a valid input' do
        player = Player.new("player")
        allow(player).to receive(:gets).and_return("Z1", "A1")

        expect(player).to receive(:gets).twice
        coordinate = player.prompt_for_coordinates
        expect(coordinate).to eq("A1")
        end
    end

    describe '#place_ship_randomly' do
        it 'places a ship randomly in a valid location' do

        player = Player.new("computer")
        player.computer_player
        ship = Ship.new("submarine", 2)

        player.place_ship_random(ship)

        expect(player.ships).to include(ship)
        end
    end

    describe '#place_ship' do
        it 'can place ships manually for human' do
            player = Player.new("player")
            ship = Ship.new("Cruiser", 3)

            allow(player).to receive(:gets).and_return("A1 A2 A3")
            player.place_ship([ship])

            expect(player.ships).to include(ship)
            expect(player.board.cells["A1"].ship).to eq(ship)
            expect(player.board.cells["A2"].ship).to eq(ship)
            expect(player.board.cells["A3"].ship).to eq(ship)
        end

        it 'places ships randomly for computer' do
            player = Player.new("computer")
            player.computer_player
            ship = Ship.new("Submarine", 2)
        
            player.place_ship([ship])
        
            expect(player.ships).to include(ship)
            expect(player.board.cells).to have_key(player.board.random_coordinates)
          end
        end
    end

    describe '#generate_valid_random_coordinates' do
        it 'returns a list of coordinates' do
            player = Player.new("computer")
            player.computer_player

            result = player.generate_valid_random_coordinates(3)

            expect(result).to be_an(Array)
            expect(result.length).to eq(3)
        end
    end

    describe '#take_turn' do
    it 'prompts the user to enter a target coordinate' do
      player = Player.new("player")
      allow(player).to receive(:gets).and_return("A1")
      result = player.take_turn
      expect(result).to eq("A1")
    end
  
    it 'selects a random target for computer' do
      player = Player.new("computer")
      player.computer_player
      result = player.take_turn
      expect(player.board.cells.keys).to include(result)
    end
  end
end