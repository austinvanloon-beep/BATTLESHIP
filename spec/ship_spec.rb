require 'spec_helper'
# #=> true

RSpec.describe Ship do
    describe '#creates a new ship' do
        it 'exists' do
            cruiser = Ship.new("Cruiser", 3)
            expect(cruiser).to be_a(Ship)
        end
    
        it 'has a name of cruiser' do
            cruiser = Ship.new("Cruiser", 3)
            expect(cruiser.name).to eq("Cruiser")
        end

        it 'has a length of 3' do
            cruiser = Ship.new("Cruiser", 3)
            expect(cruiser.length).to eq(3)
        end

        it 'has a health of 3' do
            cruiser = Ship.new("Cruiser", 3) 
            expect(cruiser.health).to eq(3)
        end
    end

    describe '#the ship is able to track health, take hits and sink' do
        it 'is sunk?' do
            #binding.pry
            cruiser = Ship.new("Cruiser", 3)
            expect(cruiser.sunk?).to eq(false)
        end

        it 'did it take a hit' do
            cruiser = Ship.new("Cruiser", 3)
            cruiser.hit
            expect(cruiser.health).to eq(2)
        end

        it 'did it take 2 hits' do
            cruiser = Ship.new("Cruiser", 3)
            cruiser.hit
            cruiser.hit
            expect(cruiser.health).to eq(1)
            expect(cruiser.sunk?).to eq(false)
        end

        #-possibly refactor health between hits-

        it 'did it take 3 hits' do
            cruiser = Ship.new("Cruiser", 3)
            cruiser.hit
            cruiser.hit
            cruiser.hit
            expect(cruiser.health).to eq(0)
            expect(cruiser.sunk?).to eq(true)
        end
    end
end 
