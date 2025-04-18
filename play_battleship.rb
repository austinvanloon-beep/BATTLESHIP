require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/game'
require './lib/player'

if __FILE__ == $PROGRAM_NAME
  game = Game.new
  game.start_game
end