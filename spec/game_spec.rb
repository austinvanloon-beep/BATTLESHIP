require 'spec_helper'

RSpec.describe Game do

    before(:each) do
        @game = Game.new
    end
  
    describe '#initialize' do

        it 'exists' do
          expect(@game).to be_a(Game)
        end 

        it 'creates instances of a player and a computer' do
          expect(@game.player).to be_a(Player)
          expect(@game.player.is_computer).to eq(false)

          expect(@game.computer).to be_a(Player)
          expect(@game.computer.is_computer).to eq(true)
        end
    end

    describe '#welcome_message' do

        it 'returns pirate version of welcome message if pirate mode is enabled' do
          @game.instance_variable_set(:@pirate_mode, true)

          expected_string = "Welcome aboard ye scallywag!\nType 'p' to set sail or 'q' to walk the plank!"
          
          expect(@game.welcome_message).to eq(expected_string)
        end

        it 'shows the player the welcome message and main menu options if pirate mode is disabled' do
          
          expected_string = "Welcome to BATTLESHIP\nEnter 'p' to play. Enter 'q' to quit."
          
          expect(@game.welcome_message).to eq(expected_string)
        end
    end

    describe '#start_game' do

        it 'calls setup_game, play_turns, and end_game when user chooses to play by typing "p"' do
            # added a bunch of stubs here to simulate the user_inputs up until this point in the game logic
            allow(@game).to receive(:gets).and_return("p", "1", "1", "A1 A2 A3")
            allow(@game).to receive(:setup_game)
            allow(@game).to receive(:play_turns)
            allow(@game).to receive(:end_game)
        
            expect(@game).to receive(:setup_game)
            expect(@game).to receive(:play_turns)
            expect(@game).to receive(:end_game)
        
            @game.start_game
        end

        it 'calls quit_game when user chooses to quit by typing "q"' do
            # added a stub here to simulate the user_inputs up until this point in the game logic
            allow(@game).to receive(:gets).and_return("q")
            allow(@game).to receive(:quit_game)
        
            expect(@game).to receive(:quit_game)
        
            @game.start_game
        end

        it 're-prompts user after invalid input, then quits on valid input' do
            # stubbing an invalid input and then a valid one
            allow(@game).to receive(:gets).and_return("x", "q")
            allow(@game).to receive(:quit_game)
        
            expect(@game).to receive(:quit_game)
            @game.start_game
        end
    end

    describe '#setup_game' do

        it 'prompts both players to place ships' do
          @game = Game.new
          # added a few stubs here to fake the user input for all of the initial game setup options like this
          # number of ships (2); pick "1" for Cruiser (1); pick "2" for Submarine (2), 
          # and since the `redo` could make it ask for that same ship again, add in other stubs to prevent that
          allow(@game).to receive(:gets).and_return("2", "1", "2", "1", "2")

          # Force computer player to behave correctly like a computer for testing purposes
          @game.computer.instance_variable_set(:@is_computer, true)
        
          # added a stub here too so the user input was not needed for placing the ships
          allow(@game.player).to receive(:prompt_for_ship_placement).and_return(["A1", "A2", "A3"], ["B1", "B2"])
        
          allow(@game.player.board).to receive(:valid_placement?).and_return(true)
          allow(@game.player.board).to receive(:place_ship).and_return(true)

          # added a stub here as well for the computer's place_ship_randomly so it doesn’t loop infinitely
          allow(@game.computer).to receive(:place_ship_randomly) do |ship|
            coordinates = @game.computer.generate_valid_random_coordinates(ship.length)
              @game.computer.board.place_ship(ship, coordinates)
              @game.computer.ships << ship
          end
        
          @game.setup_game
        
          expect(@game.player.ships.length).to eq(2)
          expect(@game.player.ships.map { |ship| ship.name }).to include("Cruiser", "Submarine")
          
          expect(@game.computer.ships.length).to eq(2)
          expect(@game.computer.ships.map { |ship| ship.name }).to include("Cruiser", "Submarine")
        end
    end

    describe '#setup_game (pirate mode)' do

        before(:each) do
            @game.instance_variable_set(:@pirate_mode, true)
        end
          
        it 'places Black Pearl for computer when selected' do

            allow(@game).to receive(:gets).and_return("1", "9")
            allow(@game.player).to receive(:prompt_for_ship_placement).and_return(["A1", "A2", "A3"])
            allow(@game.player.board).to receive(:valid_placement?).and_return(true)
            allow(@game.player.board).to receive(:place_ship).and_return(true)
            allow(@game.computer).to receive(:generate_valid_random_coordinates).and_return(["A1", "A2", "A3", "A4"])
            allow(@game.computer.board).to receive(:valid_placement?).and_return(true)
            allow(@game.computer.board).to receive(:place_ship).and_return(true)

            @game.setup_game

            expect(@game.computer.ships.map { |ship| ship.name }).to include("Black Pearl")
        end

        it 'shows pirate prompts for ship selection and placement' do

            allow(@game).to receive(:gets).and_return("1", "9")
            allow(@game.player).to receive(:prompt_for_ship_placement).and_return(["A1", "A2", "A3"])
            allow(@game.player.board).to receive(:valid_placement?).and_return(true)
            allow(@game.player.board).to receive(:place_ship).and_return(true)
            allow(@game.computer).to receive(:generate_valid_random_coordinates).and_return(["A1", "A2", "A3", "A4"])
            allow(@game.computer.board).to receive(:valid_placement?).and_return(true)
            allow(@game.computer.board).to receive(:place_ship).and_return(true)
                      
            expected_string = "Choose yer vessels, ye salty dog:\n\n"
            
            expect{ @game.setup_game }.to output(include(expected_string)).to_stdout
        end
    end

    describe '#display_boards' do

        it 'renders the boards for player and computer correctly' do
          @cruiser = Ship.new("Cruiser", 3)
          @submarine = Ship.new("Submarine", 2)
          @ships = [@cruiser, @submarine]

          @player1 = Player.new("computer")
          @player2 = Player.new("player")
          @player1.computer_player

          expected_render = 
            "=============COMPUTER BOARD=============\n" +
            "#{@player1.board.render}" +
            "==============PLAYER BOARD==============\n" +
            "#{@player2.board.render(true)}"

            expect{ @game.display_boards }.to output(expected_render).to_stdout
        end
    end  
    
    describe '#pirate_mode?' do
        
        it 'returns false by default' do
            expect(@game.pirate_mode?).to eq(false)
        end

        it 'returns true after selecting Black Pearl' do
          
            allow(@game).to receive(:gets).and_return("1", "9")
            allow(@game.player).to receive(:prompt_for_ship_placement).and_return(["A1", "A2", "A3"])
            allow(@game.player.board).to receive(:valid_placement?).and_return(true)
            allow(@game.player.board).to receive(:place_ship).and_return(true)
            allow(@game.computer).to receive(:generate_valid_random_coordinates).and_return(["A1", "A2", "A3", "A4"])
            allow(@game.computer.board).to receive(:valid_placement?).and_return(true)
            allow(@game.computer.board).to receive(:place_ship).and_return(true)

            @game.setup_game
            
            expect(@game.pirate_mode?).to eq(true)
        end
    end

    describe '#end_game' do

        before(:each) do
            @game = Game.new

            @cruiser = Ship.new("Cruiser", 3)
            @submarine = Ship.new("Submarine", 2)
            @ships = [@cruiser, @submarine]

            # added stubs for the player ship placement inputs and the computers random ship placements
            allow(@game.player).to receive(:prompt_for_ship_placement).and_return(["A1", "A2", "A3"], ["B1", "B2"])
            allow(@game.player).to receive(:gets).and_return("A1 A2 A3", "B1 B2")

            allow(@game.computer).to receive(:place_ship_randomly) do |ship|
              coords = @game.computer.generate_valid_random_coordinates(ship.length)
              @game.computer.board.place_ship(ship, coords)
              @game.computer.ships << ship
            end

            @game.player.place_ship(@ships)
            @game.computer.place_ship(@ships)

            # also added a stub to prevent the play_again or start_game method from actually running during the test
            allow(@game).to receive(:start_game)
            allow(@game).to receive(:gets).and_return("n")
        end
 
        it 'prints the player win message when the computer ships are all sunk' do
          @game.player.ships.each do |ship| 
            ship.length.times do 
                ship.hit
            end
          end

          expect(@game.computer.all_ships_sunk?).to be true
          expect{ @game.end_game }.to output("\nYou won!\n").to_stdout
        end

        it 'prints the computer win message when the player ships are all sunk' do
          @game.player.ships.each do |ship| 
              ship.length.times do 
                  ship.hit
              end
          end
      
          expect(@game.player.all_ships_sunk?).to be true
          expect{ @game.end_game }.to output("\nI won!\n").to_stdout
        end
      
        it 'returns to main menu after game ends' do
          # nifty refactor to have the ships iterate upon themselves to hit the number of times their health (length) is!
          @game.player.ships.each do |ship| 
            ship.length.times do 
                ship.hit
            end
          end
          
          expect{ @game.end_game }.to output("\nReturning to main menu...\n\n").stdout
        end
    end

    describe '#end_game (pirate mode)' do

        before(:each) do
            @game = Game.new
            @game.instance_variable_set(:@pirate_mode, true)
            
            # added mocks here to allow there to be two sets of ships, one for each player,
            # in order to be able to stub the other requirements to end_game properly
            ship1 = Ship.new("Submarine", 2)
            ship2 = Ship.new("Cruiser", 3)

            @game.player.instance_variable_set(:@ships, [ship1, ship2])
            @game.computer.instance_variable_set(:@ships, [double(ship1), double.(ship2)])
          end
    
        it 'shows the correct pirate win message when computer loses to the player' do
           
            @game.computer.ships.each do |ship| 
                ship.length.times do 
                    ship.hit
                end
            end

            expected_string = "\nCURSES!! Ye bested me and me crew. Surely yer name echoes through the ports now!"
            
            expect(@game.computer.all_ships_sunk?).to be true
            expect{ @game.end_game }.to output(include(expected_string)).to_stdout
        end

        it 'shows the correct pirate lose message when player loses to the computer' do
            
            @game.player.ships.each do |ship| 
                ship.length.times do 
                    ship.hit
                end
            end
            
            expected_string = "\nYe fought well, but I sent yer fleet to the briny deep! I win, ye scurvy dog!"

            expect(@game.player.all_ships_sunk?).to be true
            expect{ @game.end_game }.to output(include(expected_string)).to_stdout
        end
    end
end