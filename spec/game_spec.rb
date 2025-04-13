require 'spec_helper'

RSpec.describe Game do

  # before(:each) do
  #   @game = Game.new
  # end
  
  it 'shows the player the main menu where they can play or quit' do
    game = Game.new
    expect(game.welcome_message).to eq("Welcome to BATTLESHIP\nEnter 'p' to play. Enter 'q' to quit.")
  end

  it 'Computer can place ships randomly in valid locations' do
    
  end

  it 'Once the User has chosen to play, you need to place the computer’s ships and the players ships to set up the game.' do

  end

  it 'User can enter valid sequences to place both ships' do

  end

  it 'Entering invalid ship placements prompts user to enter valid placements' do

  end

  it 'Whenever a game ends, they should return to this message so they can start a new game, or quit.' do

  end
end