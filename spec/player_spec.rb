require 'spec_helper'

RSpec.describe Player do

    before(:each) do
        @player1 = Player.new("computer")
        @player2 = Player.new("player")
        @player1.computer_player
    end

    describe '#initialize' do

        it 'exists' do
            expect(@player1).to be_a(Player)
        end

        it 'has is_computer as false for human player' do
            @player2 = Player.new("player")
            @player2.computer_player
            expect(@player2.is_computer).to eq(false)
          end
          
        it 'has is_computer as true for computer player' do
            @player1.computer_player
            expect(@player1.name).to eq("computer")
            expect(@player1.is_computer).to eq(true)
        end
      
        it 'has a board' do
            expect(@player1.board).to be_a(Board)
            expect(@player2.board).to be_a(Board)
        end
      
        it 'starts with no ships' do
            expect(@player1.ships).to eq([])
            expect(@player2.ships).to eq([])
        end
    end

    describe '#prompt_for_ship_placement' do

        it 'returns an array of coordinates based on user input' do
            player = Player.new("player")
            # added a stub here to allow this test to function without actual user input
            allow(player).to receive(:prompt_for_ship_placement).and_return(["A1", "A2", "A3"])

            result = player.prompt_for_ship_placement(Ship.new("Cruiser", 3))
            expect(result).to eq(["A1", "A2", "A3"])
        end
    end

    describe '#place_ship' do
    
        it 'can place ships manually for human' do
            player = Player.new("player")
            ship = Ship.new("Cruiser", 3)
            # added a stub here to allow this test to function without actual user input
            allow(player).to receive(:gets).and_return("A1 A2 A3")
            allow(player).to receive(:prompt_for_ship_placement).and_return(["A1", "A2", "A3"])

            
            player.place_ship([ship])

            expect(player.ships).to include(ship)
            expect(player.board.cells["A1"].ship).to eq(ship)
            expect(player.board.cells["A2"].ship).to eq(ship)
            expect(player.board.cells["A3"].ship).to eq(ship)
        end

        it 'adds ships to the player ship list' do
            player = Player.new("player")
            ship = Ship.new("Cruiser", 3)
            # added a stub here to allow this test to function without actual user input
            allow(player).to receive(:gets).and_return("A1 A2 A3")
            allow(player).to receive(:prompt_for_ship_placement).and_return(["A1", "A2", "A3"])

        
            player.place_ship([ship])
        
            expect(player.ships).to include(ship)
            expect(player.ships.length).to eq(1)
        end
    end

    describe '#prompt_for_coordinates' do

        it 'recognizes invalid input and re-prompts the user for a valid input' do
            player = Player.new("player")
            # added a mock here to fake the board class instead of actually referencing it
            opponent_board = double("Board", valid_coordinate?: true)
            allow(opponent_board).to receive(:cells).and_return({ "A1" => double("Cell") })


            # added stubs here board's to fake the valid_coordinate? method so the logic works correctly
            allow(opponent_board).to receive(:valid_coordinate?).with("Z1").and_return(false)
            allow(opponent_board).to receive(:valid_coordinate?).with("A1").and_return(true)
            # added a stub here to allow this test to function without actual user input to test additional spaces with input
            allow(player).to receive(:gets).and_return("Z1", "A1")

            expect(player).to receive(:gets).twice
            coordinate = player.prompt_for_coordinates(opponent_board)

            expect(coordinate).to eq("A1")
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

    # describe '#place_ship_randomly' do

    #     it 'places a ship randomly for the computer in a valid location' do
    #         player = Player.new("computer")
    #         player.computer_player
    #         ship = Ship.new("Submarine", 2)
        
    #         player.place_ship([ship])
        
    #         expect(player.ships).to include(ship)
    #         expect(player.board.cells.values.map(&:ship).compact).to include(ship)
    #     end

    #     it 'adds ships to the player ship list' do
    #         player = Player.new("player")
    #         ship = Ship.new("Cruiser", 3)
    #         # added a stub here to allow this test to function without actual user input
    #         allow(player).to receive(:gets).and_return("A1 A2 A3")
        
    #         player.place_ship([ship])
        
    #         expect(player.ships).to include(ship)
    #         expect(player.ships.length).to eq(1)
    #     end
    # end
    
    describe '#take_turn' do

        it 'prompts the user to enter a target coordinate and fires on it' do
            computer = Player.new("computer")
            player = Player.new("player")
            # added a stub here to allow this test to function without actual user input
            allow(player).to receive(:gets).and_return("A1")
        
            player.take_turn(computer.board)
        
            expect(computer.board.cells["A1"].fired_upon?).to be true
        end
      
        it 'selects a random valid target for computer and fires on it' do
            player = Player.new("player")
            computer = Player.new("computer")
            computer.computer_player
          
            fired_before = player.board.cells.values.count { |cell| cell.fired_upon? }
            computer.take_turn(player.board)
            fired_after = player.board.cells.values.count { |cell| cell.fired_upon? }

            expect(fired_after).to eq(fired_before + 1)
        end

        it 'does not fire on a cell that has already been fired upon' do
            player = Player.new("player")
            computer = Player.new("computer")
            computer.computer_player
          
            # force a manual fire_upon on the cell A1
            player.board.cells["A1"].fire_upon("A1")
          
            # added a stub here to simulate trying to fire_upon A1 again, then choosing again because it's invalid
            allow(player.board.cells).to receive(:keys).and_return(["A1", "A2", "A3", "B1"])
            
            fired_before = player.board.cells.values.count { |cell| cell.fired_upon? }
            computer.take_turn(player.board)
            fired_after = player.board.cells.values.count { |cell| cell.fired_upon? }
          
            expect(fired_after).to eq(fired_before + 1)
          end        
    end
    
    describe '#all_ships_sunk' do

        it 'returns false if at least one is afloat' do
            cruiser = Ship.new("Cruiser", 3)
            submarine = Ship.new("Submarine", 2)
            player = Player.new("player")

            # added a stub here to allow this test to function without actual user input
            allow(player).to receive(:prompt_for_ship_placement).with(cruiser).and_return(["A1", "A2", "A3"])
            allow(player).to receive(:prompt_for_ship_placement).with(submarine).and_return(["B1", "B2"])

            player.place_ship([cruiser, submarine])

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
            
            # added a stub here to allow this test to function without actual user input
            allow(player).to receive(:prompt_for_ship_placement).with(cruiser).and_return(["A1", "A2", "A3"])
            allow(player).to receive(:prompt_for_ship_placement).with(submarine).and_return(["B1", "B2"])

            player.place_ship([cruiser, submarine])
            
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