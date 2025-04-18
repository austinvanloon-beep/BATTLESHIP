require 'spec_helper'

RSpec.describe Game do

    before(:each) do
        @game = Game.new
        # had to add this stub globally to prevent infinite loop during testing
        allow(@game).to receive(:start_game)
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

        it 'allows the user to choose to play by typing "p"' do
          expect(@game.user_input = 'p').to output(true).stdout
        end

        it 'allows the user to choose to quit by typing "q"' do
          expect(@game.user_input = 'q').to output(true).stdout
        end

        it 'recognizes an invalid input option and re-prompts user to a valid one' do
          expect(@game.user_input = 'x').to output("Invalid input. Please try again.").stdout
        end
    end

    describe '#setup_game' do

        it 'prompts both players to place ships' do
          game = Game.new
          # added a few stubs here to fake the user input for all of the initial game setup options like this
          # number of ships (2); pick "1" for Cruiser (1); pick "2" for Submarine (2), 
          # and since the `redo` could make it ask for that same ship again, add in other stubs to prevent that
          allow(game).to receive(:gets).and_return("2", "1", "2", "1", "2")

          # Force computer player to behave correctly like a computer for testing purposes
          game.computer.instance_variable_set(:@is_computer, true)
        
          # added a stub here too so the user input was not needed for placing the ships
          allow(game.player).to receive(:prompt_for_ship_placement).and_return(["A1", "A2", "A3"], ["B1", "B2"])
        
          allow(game.player.board).to receive(:valid_placement?).and_return(true)
          allow(game.player.board).to receive(:place_ship).and_return(true)

          # added a stub here as well for the computer's place_ship_randomly so it doesn’t loop infinitely
          allow(game.computer).to receive(:place_ship_randomly) do |ship|
            coordinates = game.computer.generate_valid_random_coordinates(ship.length)
              game.computer.board.place_ship(ship, coordinates)
              game.computer.ships << ship
          end
        
          game.setup_game
        
          expect(game.player.ships.length).to eq(2)
          expect(game.player.ships.map { |ship| ship.name }).to include("Cruiser", "Submarine")
          
          expect(game.computer.ships.length).to eq(2)
          expect(game.computer.ships.map { |ship| ship.name }).to include("Cruiser", "Submarine")
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
          
          expect(@game.end_game).to output("\nReturning to main menu...\n\n").stdout
        end
    end


end