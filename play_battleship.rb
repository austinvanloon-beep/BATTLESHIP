require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/game'
require './lib/player'

if $PROGRAM_NAME == __FILE__
    game = Game.new
    game.start_game
end