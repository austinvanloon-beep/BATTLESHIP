require 'spec_helper'

RSpec.describe Player do
    #binding.pry
    before(:each) do
        @player = Player.new("computer")
    end

    describe '#initialize' do
        it 'exists' do
            expect(@player).to be_a(Player)
        end
    end
end