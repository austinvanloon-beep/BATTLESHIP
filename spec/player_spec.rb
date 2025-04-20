require_relative 'spec_helper'

RSpec.describe Player do

    before(:each) do
        @computer = Player.new("computer")
        @player = Player.new("player")
        @computer.computer_player

        @ship1 = Ship.new("Cruiser", 3)
        @ship2 = Ship.new("Submarine", 2)

        allow(@player.board).to receive(:place_ship).and_return(true)
        allow(@computer.board).to receive(:place_ship).and_return(true)
    end

    describe '#initialize' do

        it 'exists' do
            expect(@computer).to be_a(Player)
        end

        it 'has is_computer as false for human player' do
            @player = Player.new("player")
            @player.computer_player
            expect(@player.is_computer).to eq(false)
          end
          
        it 'has is_computer as true for computer player' do
            @computer.computer_player
            expect(@computer.name).to eq("computer")
            expect(@computer.is_computer).to eq(true)
        end
      
        it 'has a board' do
            expect(@computer.board).to be_a(Board)
            expect(@player.board).to be_a(Board)
        end
      
        it 'starts with no ships' do
            expect(@computer.ships).to eq([])
            expect(@player.ships).to eq([])
        end
    end

    describe '#prompt_for_ship_placement' do

        it 'returns an array of coordinates based on user input' do
            # added a stub here to allow this test to function without actual user input
            allow(@player).to receive(:gets).and_return("A1 A2 A3")
            allow(@player).to receive(:pirate_mode?).and_return(false)

            placement = @player.prompt_for_ship_placement(@ship1)
            expect(placement).to eq(["A1", "A2", "A3"])
        end
    end

    describe '#prompt_for_ship_placement (pirate mode)' do
        it 'prints pirate ship placement prompt' do
            allow(@player).to receive(:gets).and_return("A1 A2 A3")
            allow(@player).to receive(:pirate_mode?).and_return(true)
      
            expect { @player.prompt_for_ship_placement(@ship1) }.to output("Mark the sea map for yer Cruiser! She needs 3 spaces to set sail:\n").to_stdout
        end
    end

    describe '#place_ship' do
    
        it 'can place ships manually for human based on coordinates received by user_input' do
            # added stubs here to allow this test to function without actual user input and to avoid getting stuck in an infinite validation loop
            allow(@player).to receive(:prompt_for_ship_placement).and_return(["A1", "A2", "A3"])
            allow(@player.board).to receive(:valid_placement?).with(@ship1, ["A1", "A2", "A3"]).and_return(true)
            allow(@player.board).to receive(:place_ship).with(@ship1, ["A1", "A2", "A3"])
            
            @player.place_ship([@ship1])

            expect(@player.ships).to include(@ship1)
            expect(@player.ships.length).to eq(1)
        end

        it 'adds ships to the player ship list' do
            # added stubs here to allow this test to function without actual user input and to avoid getting stuck in an infinite validation loop
            allow(@player).to receive(:prompt_for_ship_placement).and_return(["A1", "A2", "A3"])
            allow(@player.board).to receive(:valid_placement?).with(@ship1, ["A1", "A2", "A3"]).and_return(true)
            allow(@player.board).to receive(:place_ship).with(@ship1, ["A1", "A2", "A3"])
        
            @player.place_ship([@ship1])
        
            expect(@player.ships).to include(@ship1)
            expect(@player.ships.length).to eq(1)
        end
    end

    describe '#generate_valid_random_coordinates' do

        it 'returns a randomized list of coordinates' do
           
            random_coords = @computer.generate_valid_random_coordinates(3)

            expect(random_coords).to be_an(Array)
            expect(random_coords.length).to eq(3)
        end
    end

    describe '#place_ship_randomly' do

        it 'places a ship randomly for the computer in a valid location and adds it to the computers ship list @ships' do
            #stubbed the random coordinate generation here for consistent testing
            random_coords = ["A1", "A2", "A3"]
            
            allow(@computer).to receive(:generate_valid_random_coordinates).with(3).and_return(random_coords)
            allow(@computer.board).to receive(:valid_placement?).with(@ship1, random_coords).and_return(true)
            allow(@computer.board).to receive(:place_ship).with(@ship1, random_coords)

            @computer.place_ship_randomly(@ship1)
        
            expect(@computer.ships).to include(@ship1)
        end
    end
    
    describe '#setup_game with Black Pearl' do

        it 'places the Black Pearl manually at A1 through A4' do
            game = Game.new
            allow(game).to receive(:pirate_mode?).and_return(true)
            black_pearl = Ship.new("Black Pearl", 4)

            game.place_black_pearl(black_pearl)

            expect(game.computer.board.cells["A1"].ship).to eq(black_pearl)
            expect(game.computer.board.cells["A4"].ship).to eq(black_pearl)
        end
    end

    describe '#prompt_for_coordinates' do

        it 'recognizes invalid input and re-prompts the user for a valid input' do
            # added a mock here to fake the board class instead of actually referencing it
            opponent_board = double("Board", valid_coordinate?: true)
            allow(opponent_board).to receive(:cells).and_return({ "A1" => double("Cell") })


            # added stubs here board's to fake the valid_coordinate? method so the logic works correctly
            allow(opponent_board).to receive(:valid_coordinate?).with("Z1").and_return(false)
            allow(opponent_board).to receive(:valid_coordinate?).with("A1").and_return(true)
            # added a stub here to allow this test to function without actual user input to test additional spaces with input
            allow(@player).to receive(:gets).and_return("Z1", "A1")

            expect(@player).to receive(:gets).twice
            coordinate = @player.prompt_for_coordinates(opponent_board)

            expect(coordinate).to eq("A1")
        end
    end

    describe '#prompt_for_coordinates (pirate mode)' do

        it 'uses pirate error message for invalid coordinates received by user_input' do
            allow(@player).to receive(:gets).and_return("Z1", "A1")
            allow(@player).to receive(:pirate_mode?).and_return(true)
            allow(@computer.board).to receive(:valid_coordinate?).and_return(false, true)

            expect { @player.prompt_for_coordinates(@computer.board) }.to output("Where shall we fire the cannons, Cap'n? Pick a coordinate!\nYe've wasted powder on waters already scorched! Pick a fresh spot, ya scallywag!\n").to_stdout
        end
    end

    describe '#take_turn' do

        it 'prompts the user to enter a target coordinate and fires on it' do
            # added a stub here to allow this test to function without actual user input
            allow(@player).to receive(:gets).and_return("A1")
        
            @player.take_turn(@computer.board)
        
            expect(@computer.board.cells["A1"].fired_upon?).to be true
        end
      
        it 'selects a random valid target for computer and fires on it' do
            
            fired_before = @player.board.cells.values.count { |cell| cell.fired_upon? }
            @computer.take_turn(@player.board)
            fired_after = @player.board.cells.values.count { |cell| cell.fired_upon? }

            expect(fired_after).to eq(fired_before + 1)
        end

        it 'does not fire on a cell that has already been fired upon' do
            # force a manual fire_upon on the cell A1
            @player.board.cells["A1"].fire_upon
          
            # added a stub here to simulate trying to fire_upon A1 again, then choosing again because it's invalid
            # not sure that this is working exactly as needed and if it needs refinement though?
            allow(@player.board.cells).to receive(:keys).and_return(["A1", "A2", "A3", "B1"])
            
            fired_before = @player.board.cells.values.count { |cell| cell.fired_upon? }
            @computer.take_turn(@player.board)
            fired_after = @player.board.cells.values.count { |cell| cell.fired_upon? }
          
            expect(fired_after).to eq(fired_before + 1)
          end        
    end

    describe '#fire_prompt' do

        before(:each) do
            allow(@player).to receive(:pirate_mode?).and_return(false)
            allow(@computer).to receive(:pirate_mode?).and_return(false)
        end

        it 'outputs normal hit message in non-pirate mode' do
            cell = Cell.new("A1")
            cell.place_ship(@ship2)

            allow(cell).to receive(:fired_upon?).and_return(false)
            allow(cell).to receive(:fire_upon) { @ship2.hit }

            allow(@computer.board).to receive(:cells).and_return({"A1" => cell})
            allow(@computer.board.cells).to receive(:[]).with("A1").and_return(cell)
            
            allow(@player).to receive(:gets).and_return("A1")
      
            expect { @player.fire_prompt(@computer.board) }.to output(include("You hit a ship at A1")).to_stdout
          end

        it 'outputs normal sunk message in non-pirate mode' do
            cell = Cell.new("A2")
            cell.place_ship(@ship2)
            # damaging the ship first before firing again to sink it
            @ship2.hit

            allow(cell).to receive(:fired_upon?).and_return(false)
            allow(cell).to receive(:fire_upon) { @ship2.hit }

            allow(@computer.board).to receive(:cells).and_return({"A2" => cell})
            allow(@computer.board.cells).to receive(:[]).with("A2").and_return(cell)
            
            allow(@player).to receive(:gets).and_return("A2")
    
            expect { @player.fire_prompt(@computer.board) }.to output(include("You sunk a ship at A2")).to_stdout
        end
      
        it 'outputs normal miss message in non-pirate mode' do
            cell = Cell.new("B1")

            allow(cell).to receive(:fired_upon?).and_return(false)
            allow(cell).to receive(:fire_upon)
            allow(cell).to receive(:ship).and_return(nil)

            allow(@computer.board).to receive(:cells).and_return({"B1" => cell})
            allow(@computer.board.cells).to receive(:[]).with("B1").and_return(cell)
            
            allow(@player).to receive(:gets).and_return("B1")
      
            expect { @player.fire_prompt(@computer.board) }.to output(include("You missed at B1")).to_stdout
        end
    end

    describe '#fire_prompt (pirate mode)' do

        before(:each) do
            allow(@player).to receive(:pirate_mode?).and_return(true)
            allow(@computer).to receive(:pirate_mode?).and_return(true)
        end

        it 'outputs pirate hit message' do
            cell = Cell.new("A1")
            cell.place_ship(@ship2)

            allow(@computer.board).to receive(:cells).and_return({"A1" => cell})
            allow(@computer.board.cells).to receive(:[]).with("A1").and_return(cell)
           
            allow(@player).to receive(:gets).and_return("A1")
      
            expect { @player.fire_prompt(@computer.board) }.to output(include("Aye! Direct hit at A1")).to_stdout
          end
    
        it 'outputs pirate sunk message' do
            cell = Cell.new("A2")
            cell.place_ship(@ship2)
            # damaging the ship first before firing again to sink it
            @ship2.hit
            
            allow(@computer.board).to receive(:cells).and_return({"A2" => cell})
            allow(@computer.board.cells).to receive(:[]).with("A2").and_return(cell)
            
            allow(@player).to receive(:gets).and_return("A2")
            
            expect { @player.fire_prompt(@computer.board) }.to output(include("Arrr! Another ship down, to Davy Jones' locker")).to_stdout
        end
    
        it 'outputs pirate miss message' do
            cell = Cell.new("B1")

            allow(cell).to receive(:fired_upon?).and_return(false)
            allow(cell).to receive(:fire_upon)
            allow(cell).to receive(:ship).and_return(nil)

            allow(@computer.board).to receive(:cells).and_return({"B1" => cell})
            allow(@computer.board.cells).to receive(:[]).with("B1").and_return(cell)
            
            allow(@player).to receive(:gets).and_return("B1")
      
            expect { @player.fire_prompt(@computer.board) }.to output(include("Blast! Just sea foam at B1")).to_stdout
        end
    end
    
    describe '#fire_randomly' do

        before(:each) do
            allow(@player).to receive(:pirate_mode?).and_return(false)
            allow(@computer).to receive(:pirate_mode?).and_return(false)
        end

        it 'outputs normal sunk message in non-pirate mode' do
            cell = Cell.new("A2")
            cell.place_ship(@ship2)
            # damaging the ship first before firing again to sink it
            @ship2.hit

            allow(cell).to receive(:fired_upon?).and_return(false)
            allow(cell).to receive(:fire_upon) do
              @ship2.hit
            end
      
            allow(@player.board).to receive(:cells).and_return({"A2" => cell})
            allow(@player.board.cells).to receive(:keys).and_return(["A2"])
      
            expect { @computer.fire_randomly(@player.board) }.to output(include("The computer sunk one of your ships at A2")).to_stdout
        end

        it 'outputs normal miss message in non-pirate mode' do
            allow(@player.board).to receive(:cells).and_return({"Z9" => Cell.new("Z9")})
            allow(@player.board.cells).to receive(:keys).and_return(["Z9"])

            expect { @computer.fire_randomly(@player.board) }.to output(include("The computer missed at Z9")).to_stdout
        end
    end

    describe '#fire_randomly (pirate mode)' do

        before(:each) do
            allow(@player).to receive(:pirate_mode?).and_return(true)
            allow(@computer).to receive(:pirate_mode?).and_return(true)
        end

         it 'outputs pirate hit message' do
            cell = Cell.new("A1")
            cell.place_ship(@ship2)

            allow(@player.board).to receive(:cells).and_return({"A1" => cell})
            allow(@player.board.cells).to receive(:keys).and_return(["A1"])

            expect { @computer.fire_randomly(@player.board) }.to output(include("I struck yer rig at A1")).to_stdout
        end
      
        it 'outputs pirate sunk message' do
            cell = Cell.new("A2")
            cell.place_ship(@ship2)
            # damaging the ship first before firing again to sink it
            @ship2.hit

            allow(cell).to receive(:fired_upon?).and_return(false)
            allow(cell).to receive(:fire_upon) do
                @ship2.hit
            end
      
            allow(@player.board).to receive(:cells).and_return({"A2" => cell})
            allow(@player.board.cells).to receive(:keys).and_return(["A2"])
      
            expect { @computer.fire_randomly(@player.board) }.to output(include("Yer ship be sunk by me cannon at A2")).to_stdout
        end  

        it 'outputs pirate miss message' do
            allow(@player.board).to receive(:cells).and_return({"Z9" => Cell.new("Z9")})
            allow(@player.board.cells).to receive(:keys).and_return(["Z9"])
      
            expect { @computer.fire_randomly(@player.board) }.to output(include("just missed ye at Z9")).to_stdout
        end       
    end
    
    describe '#all_ships_sunk' do

        it 'returns false if at least one is afloat' do
            
            # added a stub here to allow this test to function without actual user input
            allow(@player).to receive(:prompt_for_ship_placement).with(@ship1).and_return(["A1", "A2", "A3"])
            allow(@player).to receive(:prompt_for_ship_placement).with(@ship2).and_return(["B1", "B2"])
            allow(@player.board).to receive(:valid_placement?).and_return(true)
            allow(@player.board).to receive(:place_ship).and_return(true)

            expect(@player.board.valid_placement?(@ship1, ["A1", "A2", "A3"])).to be true

            @player.place_ship([@ship1, @ship2])

            3.times { @ship1.hit }
           
            expect(@ship1.sunk?).to be(true)
            expect(@player.all_ships_sunk?).to eq(false)
        end

        it 'returns true if all ships are sunk' do

            # added a stub here to allow this test to function without actual user input
            allow(@player).to receive(:prompt_for_ship_placement).with(@ship1).and_return(["A1", "A2", "A3"])
            allow(@player).to receive(:prompt_for_ship_placement).with(@ship2).and_return(["B1", "B2"])
            allow(@player.board).to receive(:valid_placement?).and_return(true)
            allow(@player.board).to receive(:place_ship).and_return(true)

            expect(@player.board.valid_placement?(@ship1, ["A1", "A2", "A3"])).to be true

            @player.place_ship([@ship1, @ship2])
            
            3.times { @ship1.hit }
            2.times { @ship2.hit }

            expect(@player.all_ships_sunk?).to be true
        end
    end
    

end