require 'spec_helper'

RSpec.describe Game do

  describe '#initialize' do
    game = Game.new
  
    expect(game).to be_a(Game)
    expect(@player).to be_a(Player)
    expect(@opponent).to be_a(Player)

  end

  describe '#start_game' do

    before(:each) do
      @game = Game.new
    end

    it 'shows the player the main menu where they can play or quit' do
      expect(@game.welcome_message).to eq("Welcome to BATTLESHIP\nEnter 'p' to play. Enter 'q' to quit.")
    end

    it 'allows the user to choose to play by typing "p" has chosen to play, ' do
      
    end
    
    it 'The computer player should place their ships. The baseline computer should simply use random placements but still adhere to the valid placement rules from iteration 2.' do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)
      submarine = Ship.new("Submarine", 2)
    end
    
    it 'you need to place the computer’s ships and the players ships to set up the game.' do

    end

  end
  
  

  it 'Computer can place ships randomly in valid locations' do
    
  end

  

  it 'User can enter valid sequences to place both ships' do

  end

  it 'Entering invalid ship placements prompts user to enter valid placements' do

  end

  it 'The game is over when either the computer or the user sinks all of the enemy ships. When this happens, the user should see a message stating who won:' do
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    @player.ships = [cruiser, submarine]

    @player.ships.sunk?.all? == true
    expect(end_game).to eq("You won!")

    @opponent.ships = [cruiser, submarine]
    expect(end_game).to eq("I won!")

  end

  it 'Whenever a game ends, they should return to this message so they can start a new game, or quit.' do

  end

  it 'At the start of the turn, the user is shown both boards. The user should see their ships but not the computer’s ships:' do
    expected_render = 

    puts "=============COMPUTER BOARD============="
    puts @opponent.board.render
    puts "==============PLAYER BOARD=============="
    puts @player.board.render(true)

    expect(display_boards).to eq(expected_render)
  end



end