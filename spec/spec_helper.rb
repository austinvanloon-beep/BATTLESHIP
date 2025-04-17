require 'simplecov'
SimpleCov.start do
  add_filter "/spec/"
end

require 'rspec'
require 'pry'
require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/game'
require './lib/player'