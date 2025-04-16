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

    describe '#prompt_for_coordinates' do

        it 'recognizes invalid input and re-prompts the user for a valid input' do
            player = Player.new("player")
            allow(player).to receive(:gets).and_return("Z1", "A1")

            expect(player).to receive(:gets).twice
            coordinate = player.prompt_for_coordinates
            expect(coordinate).to eq("A1")
        end
    end

    describe '#place_ship' do
    
        it 'can place ships manually for human' do
            player = Player.new("player")
            ship = Ship.new("Cruiser", 3)
            # added a mock and a stub here to allow this test to function without actual user input
            allow(player).to receive(:gets).and_return("A1 A2 A3")
            
            player.place_ship([ship])

            expect(player.ships).to include(ship)
            expect(player.board.cells["A1"].ship).to eq(ship)
            expect(player.board.cells["A2"].ship).to eq(ship)
            expect(player.board.cells["A3"].ship).to eq(ship)
        end

        it 'adds ships to the player ship list' do
            player = Player.new("player")
            ship = Ship.new("Cruiser", 3)
            # added a mock and a stub here to allow this test to function without actual user input
            allow(player).to receive(:gets).and_return("A1 A2 A3")
        
            player.place_ship([ship])
        
            expect(player.ships).to include(ship)
            expect(player.ships.length).to eq(1)
        end
    end

    describe '#generate_valid_random_coordinates' do
        it 'returns a randomized list of coordinates' do
            player = Player.new("computer")
            player.computer_player

            result = player.generate_valid_random_coordinates(3)

            expect(result).to be_an(Array)
            expect(result.length).to eq(3)
        end
    end

    describe '#place_ship_randomly' do
        it 'places a ship randomly for the computer in a valid location' do
            player = Player.new("computer")
            player.computer_player
            ship = Ship.new("Submarine", 2)
        
            player.place_ship([ship])
        
            expect(player.ships).to include(ship)
            expect(player.board.cells).to have_key(player.generate_valid_random_coordinates)
        end

        it 'adds ships to the player ship list' do
            player = Player.new("player")
            ship = Ship.new("Cruiser", 3)
            # added a mock and a stub here to allow this test to function without actual user input
            allow(player).to receive(:gets).and_return("A1 A2 A3")
        
            player.place_ship(ship)
        
            expect(player.ships).to include(ship)
            expect(player.ships.length).to eq(1)
        end
    end
    
    describe '#take_turn' do

        it 'prompts the user to enter a target coordinate and fires on it' do
            opponent = Player.new("computer")
            player = Player.new("player")
            # added a mock and a stub here to allow this test to function without actual user input
            allow(player).to receive(:gets).and_return("A1")
        
            player.take_turn(opponent.board)
        
            expect(opponent.board.cells["A1"].fired_upon?).to be true
        end
      
        it 'selects a random valid target for computer and fires on it' do
            opponent = Player.new("player")
            computer = Player.new("computer")
            computer.computer_player
          
            fired_before = opponent.board.cells.values.count { |cell| cell.fired_upon? }
            computer.take_turn(opponent.board)
            fired_after = opponent.board.cells.values.count { |cell| cell.fired_upon? }

            expect(fired_after).to eq(fired_before + 1)

        end
          
    end
    
    describe '#all_ships_sunk' do
        it 'returns false if at least one is afloat' do
            cruiser = Ship.new("Cruiser", 3)
            submarine = Ship.new("Submarine", 2)
            player = Player.new("player")

            player.create_ship_lists(cruiser)
            player.create_ship_lists(submarine)

            # 3.times { cruiser.hit }
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
            
            # 3.times { cruiser.hit }
            cruiser.hit
            cruiser.hit
            cruiser.hit
            # 2.times { cruiser.hit }
            submarine.hit
            submarine.hit

            expect(player.all_ships_sunk?).to be true
        end
    end
    

end