require 'spec_helper'

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

        it 'returns false if the ship is not sunk' do

            cruiser = Ship.new("Cruiser", 3)
            expect(cruiser.sunk?).to eq(false)
        end


        it 'reduces health by 1 when hit' do

            cruiser = Ship.new("Cruiser", 3)
            cruiser.hit
            expect(cruiser.health).to eq(2)
        end

        it 'does not sink if it only takes 2 hits' do

            cruiser = Ship.new("Cruiser", 3)
            cruiser.hit
            cruiser.hit
            expect(cruiser.health).to eq(1)
            expect(cruiser.sunk?).to eq(false)
        end

        #-possibly refactor health between hits based on interaction pattern-

        it 'does sink if it takes enough hits to reduce health to 0 (3 hits for Cruiser)' do

            cruiser = Ship.new("Cruiser", 3)
            cruiser.hit
            cruiser.hit
            cruiser.hit
            expect(cruiser.health).to eq(0)
            expect(cruiser.sunk?).to eq(true)
        end
    end
end 
