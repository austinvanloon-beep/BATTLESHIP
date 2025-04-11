require 'spec_helper'

RSpec.describe Cell do
  
  describe 'instantiation of a new cell' do

    before(:each) do
      @cell = Cell.new("B4")
    end

    it 'exists' do
      expect(@cell).to be_an(Cell)
    end

    it 'passes the provided coordinate argument through the parameter' do
      expect(@cell.coordinate).to eq("B4")
    end

  end

  describe 'can contain a Ship or nothing' do

    before(:each) do
      @cell = Cell.new("B4")
      @cruiser = Ship.new("Cruiser", 3)
    end

    it 'contains nothing by default' do
      expect(@cell.ship).to eq(nil)
    end

    it 'is empty when there is no ship' do
      expect(@cell.empty?).to eq(true)
    end

    # failing because it doesn't have the ship class yet
    it 'can place a ship into the cell' do
      @cell.place_ship(@cruiser)

      expect(@cell.ship).to eq(@cruiser)
      expect(@cell.empty?).to eq(false)
    end

  end

  describe 'knows when it has been fired upon' do

    before(:each) do
      @cell = Cell.new("B4")
      @cruiser = Ship.new("Cruiser", 3)
    end

    it 'has not been fired upon yet' do
      @cell.place_ship(@cruiser)

      expect(@cell.fired_upon?).to eq(false)
    end

    it 'has been fired upon and damages any contained ships' do
      @cell.fire_upon

      expect(@cell.ship.health).to eq(2)
      expect(@cell.fired_upon?).to eq(false)
    end
  
  end


end

# pry(main)> cell = Cell.new("B4")
# # => #<Cell:0x00007f84f0ad4720...>

# pry(main)> cruiser = Ship.new("Cruiser", 3)
# # => #<Ship:0x00007f84f0891238...>

# pry(main)> cell.place_ship(cruiser)

# pry(main)> cell.fired_upon?
# # => false

# pry(main)> cell.fire_upon

# pry(main)> cell.ship.health
# # => 2

# pry(main)> cell.fired_upon?
# # => true