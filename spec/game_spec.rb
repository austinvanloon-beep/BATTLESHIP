require 'spec_helper'

RSpec.describe Game do

  describe '#initialize' do
    it 'exists' do
      game = Game.new
  
      expect(game).to be_a(Game)
    end 

    it 'creates instances of a player and a computer' do
      expect(@player).to be_a(Player)
      expect(@player.is_computer).to eq(false)

      expect(@computer).to be_a(Player)
      expect(@computer.is_computer).to eq(true)
    end
  end

  describe '#start_game' do

    before(:each) do
      @game = Game.new
    end

    it 'shows the player the welcome message and main menu options' do
      expect(@game.welcome_message).to eq("Welcome to BATTLESHIP\nEnter 'p' to play. Enter 'q' to quit.")
    end

    it 'allows the user to choose to play by typing "p"' do
      expect(@game.user_input = 'p').to eq(true)
    end

    it 'allows the user to choose to quit by typing "q"' do
      expect(@game.user_input = 'q').to eq(true)
    end

    it 'recognizes an invalid input option and re-prompts user to a valid one' do
      expect(@game.user_input = 'x').to eq("Invalid input. Please try again.")
    end
  end

  describe '#setup_game' do
    it '"prompts" both players to place ships' do
    
    end
  end
  
  describe '#play_turns' do
    it 'loops turns until one player loses all ships' do
    
    end

    it 'correctly calls #take_turn method for each player for each turn' do
    
    end
  end

  describe '#play_turns' do

    before(:each) do
      @board = Board.new
      @cruiser = Ship.new("Cruiser", 3)
      @submarine = Ship.new("Submarine", 2)
    end    
  end
  
  describe '#display_boards'
    it 'renders the boards for player and computer correctly' do
      expected_render = 

      puts "=============COMPUTER BOARD============="
      puts @opponent.board.render
      puts "==============PLAYER BOARD=============="
      puts @player.board.render(true)

      expect(display_boards).to eq(expected_render)
    end
  end
  
  describe '#end_game' do

    before(:each) do
      @board = Board.new
      @cruiser = Ship.new("Cruiser", 3)
      @submarine = Ship.new("Submarine", 2)
      @player1 = Player.new("computer")
      @player2 = Player.new("player")
      @player1.computer_player
      @player2.computer_player
    end

    it 'announces the winner when a player wins' do
      # @player1.all_ships_sunk? == true
      expect(@game.end_game).to eq("You won!")

      # @player1.all_ships_sunk? == true
      expect(@game.end_game).to eq("I won!")
    end

    it 'returns to main menu after game ends' do
    
    end
end