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

    describe '#start_game' do

        it 'shows the player the welcome message and main menu options' do
          expect(@game.welcome_message).to eq("Welcome to BATTLESHIP\nEnter 'p' to play. Enter 'q' to quit.")
        end

        # refactor notes - commenting these out for now because we don't have to test the user inputs,
        # but f there's time left, this could be something to try mocks and stubs with to create a fake input/method
        it 'allows the user to choose to play by typing "p"' do
          # expect(@game.user_input = 'p').to eq(true)
        end

        it 'allows the user to choose to quit by typing "q"' do
          # expect(@game.user_input = 'q').to eq(true)
        end

        it 'recognizes an invalid input option and re-prompts user to a valid one' do
          # expect(@game.user_input = 'x').to eq("Invalid input. Please try again.")
        end
    end

    describe '#setup_game' do

        it 'prompts both players to place ships' do
          game = Game.new
          # added a few stubs here to fake the user input for all of the initial game setup options:
          # number of ships (2); pick "1" for Cruiser (1); pick "2" for Submarine (2)
          allow(game).to receive(:gets).and_return("2", "1", "2")
        
          # Force computer player to behave correctly
          game.computer.instance_variable_set(:@is_computer, true)
        
          # added a stub here too so the user input was not needed for placing the ships
          allow(game.player).to receive(:prompt_for_ship_placement)
            .and_return(["A1", "A2", "A3"], ["B1", "B2"])
        
          # added a stub here as well for the computer's place_ship_randomly so it doesn’t loop infinitely
          allow(game.computer).to receive(:place_ship_randomly) do |ship|
            coordinates = game.computer.generate_valid_random_coordinates(ship.length)
            game.computer.board.place(ship, coordinates)
          end
        
          game.setup_game
        
          expect(game.player.ships.length).to eq(2)
          expect(game.player.ships.map { |ship| ship.name }).to include("Cruiser", "Submarine")
          
          expect(game.computer.ships.length).to eq(2)
          expect(game.computer.ships.map { |ship| ship.name }).to include("Cruiser", "Submarine")
        end
    end

    # describe '#display_boards' do

    #     it 'renders the boards for player and computer correctly' do
    #       expected_render = 
    #       "=============COMPUTER BOARD============="
    #       @computer.board.render
    #       "==============PLAYER BOARD=============="
    #       @player.board.render(true)

    #       # expect(@game.display_boards).to output(expected_render)
    #     end
    # end  
  
    describe '#play_turns' do

        before(:each) do
          @cruiser = Ship.new("Cruiser", 3)
          @submarine = Ship.new("Submarine", 2)
          @ships = [@cruiser, @submarine]
          @player = Player.new("player")
          @computer = Player.new("computer")
          @computer.computer_player
        end    

        # not sure if we need to test for this or not, but I thought I would leave a note either way
        # but the use-case where the player would have no ships afloat at the beginning of the turn/start of the game 
        # (i.e., not an empty array, but ships with 0 health), did arise in testing and I had to force quit the terminal
        # so I added `until @player.all_ships_sunk? == true || @computer.all_ships_sunk? == true` to the method as a safeguard
        it 'breaks the play_turns loop if a player has no ships left' do
        
        end
        
        # waiting on Austin's updates on player class to fully test this
        it 'correctly calls #take_turn method for each player for each turn' do
        # Displays boards

        # Player takes a turn against the computer
        
        # If computer is sunk, breaks the loop
        
        # Computer takes a turn against the player
        end
        
        # waiting on Austin's updates on player class to fully test this
        it 'loops turns until one player loses all their ships' do
        
        end
    end
  
    describe '#end_game' do

        before(:each) do
            @game = Game.new
          
            @cruiser = Ship.new("Cruiser", 3)
            @submarine = Ship.new("Submarine", 2)
            @ships = [@cruiser, @submarine]
          
            @game.player.create_ship_lists(@ships)
          
            @comp_cruiser = Ship.new("Cruiser", 3)
            @comp_submarine = Ship.new("Submarine", 2)
            @comp_ships = [@comp_cruiser, @comp_submarine]
          
            @game.computer.create_ship_lists(@comp_ships)
        end  

        # commenting these out for now because we don't have to test the terminal outputs but I had the blocks from using TDD still and how I would set them up
        
        it 'prints the player win message when the computer ships are all sunk' do
          # 3.times { @comp_cruiser.hit }
          # 2.times { @comp_submarine.hit }
          
          # expect(@game.end_game).to output("\nYou won!\n")
        end

        it 'prints the computer win message when the player ships are all sunk' do
          # 3.times { @cruiser.hit }
          # 2.times { @submarine.hit }

          # expect(@game.end_game).to output("\nI won!\n")
        end
      
        it 'returns to main menu after game ends' do
            # cruiser = Ship.new("Cruiser", 3)
            # submarine = Ship.new("Submarine", 2)
          
            # @game.player.create_ship_lists(cruiser)
            # @game.player.create_ship_lists(submarine)
          
            # 3.times { cruiser.hit }
            # 2.times { submarine.hit }
          
            # expect(@game.end_game).to output("\nReturning to main menu...\n\n")
        end
    end


end