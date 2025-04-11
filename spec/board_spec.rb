require 'spec_helper'
require './lib/cell'

RSpec.describe Board do
    #binding.pry
    describe '#___' do
        it 'exists' do
            board = Board.new
            expect(board).to be_a(Board)
        end
    end
end