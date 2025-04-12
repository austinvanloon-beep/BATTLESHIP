require 'spec_helper'

RSpec.describe Board do
    #binding.pry
    describe '#can keep track of cells and validate coordinates' do
        it 'exists' do
            board = Board.new
            expect(board).to be_a(Board)
        end
        it 'is a hash with 16 value pairs' do
            board = Board.new
            expect(board.cells.length).to eq(16)
            expect(board.cells).to be_a(Hash)
        end
        it 'the key points to cell objects' do
            board = Board.new
            expect(board.cells.values.to_s["A1"]).to eq("A1")
            expect(board.cells["A1"]).to be_a(Cell)
        end
    end

    describe 'is validating coordinates' do

    end

    describe 'is validating placements' do
        
    end

    describe 'is placing ships' do
        

        it 'is not overlapping ships' do

        end
    end

    describe 'is rendering board' do
        
    end
end