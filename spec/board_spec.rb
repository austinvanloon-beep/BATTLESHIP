require 'spec_helper'
require './lib/cell.rb'

RSpec.describe Board do
    describe '#___' do
        it 'exists' do
            board = Board.new
            expect(board).to be_a(Board)
        end
    end
end