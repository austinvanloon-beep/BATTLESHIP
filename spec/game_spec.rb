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
            game.computer.board.place_ship(ship, coordinates)
          end
        
          game.setup_game
        
          expect(game.player.ships.length).to eq(2)
          expect(game.player.ships.map { |ship| ship.name }).to include("Cruiser", "Submarine")
          
          expect(game.computer.ships.length).to eq(2)
          expect(game.computer.ships.map { |ship| ship.name }).to include("Cruiser", "Submarine")
        end
    end

    describe '#display_boards' do

        xit 'renders the boards for player and computer correctly' do
          @cruiser = Ship.new("Cruiser", 3)
          @submarine = Ship.new("Submarine", 2)
          @ships = [@cruiser, @submarine]

          @player1 = Player.new("computer")
          @player2 = Player.new("player")
          @player1.computer_player

          expected_render = 
          "=============COMPUTER BOARD============="
          @player1.board.render
          "==============PLAYER BOARD=============="
          @player2.board.render(true)

          not testing terminal output but confirmed board rendering is working
          expect(@game.display_boards).to output(expected_render)
        end
    end  
  
  
          # not sure if we need to test for this or not, but I thought I would leave a note either way
          # but the use-case where the player would have no ships afloat at the beginning of the turn/start of the game 
          # (i.e., not an empty array, but ships with 0 health), did arise in testing and I had to force quit the terminal
          # so I added `until @player.all_ships_sunk? == true || @computer.all_ships_sunk? == true` to the method as a safeguard
  
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

            # also added a stub to prevent the start_game method from actually running during the test
            allow(@game).to receive(:start_game)
        end

        ### skipping these tests because we don't have to test the terminal outputs
        ### but we had the blocks from using TDD still and how we would set them up;
        ### not sure the expect statements are correctly formatted though, will discuss during evaluation
        
        xit 'prints the player win message when the computer ships are all sunk' do
          @game.player.ships.each do |ship| 
            ship.length.times do 
                ship.hit
            end
          end
          expect(@game.computer.all_ships_sunk?).to be true
          expect(@game.end_game).to output("\nYou won!\n")
        end

        xit 'prints the computer win message when the player ships are all sunk' do
          @game.player.ships.each do |ship| 
              ship.length.times do 
                  ship.hit
              end
          end
      
          expect(@game.player.all_ships_sunk?).to be true
          expect(@game.end_game).to output("\nI won!\n")
        end
      
        xit 'returns to main menu after game ends' do
          # nifty refactor to have the ships iterate upon themselves to hit the number of times their health (length) is!
          @game.player.ships.each do |ship| 
            ship.length.times do 
                ship.hit
            end
          end
          
          expect(@game.end_game).to output("\nReturning to main menu...\n\n")
        end
    end


end