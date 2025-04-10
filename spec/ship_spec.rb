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









end 

# pry(main)> cruiser.sunk?
# #=> false

# pry(main)> cruiser.hit

# pry(main)> cruiser.health
# #=> 2

# pry(main)> cruiser.hit

# pry(main)> cruiser.health
# #=> 1

# pry(main)> cruiser.sunk?
# #=> false

# pry(main)> cruiser.hit

# pry(main)> cruiser.sunk?
# #=> true