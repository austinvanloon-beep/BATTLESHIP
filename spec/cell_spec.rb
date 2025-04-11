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
      @cell.place_ship(@cruiser)
      @cell.fire_upon("B4")

      expect(@cell.ship.health).to eq(2)
      expect(@cell.fired_upon?).to eq(false)
    end
  
  end

  describe '#Render' do

    before(:each) do
      @cell_1 = Cell.new("B4")
      @cell_2 = Cell.new("C3")
    end

    it 'returns ”.” if the cell has not been fired upon' do
      expect(@cell_1.render).to eq(".")
    end

    it 'returns "M" if the cell has been fired upon and does not contain a ship' do
      @cell_1.fire_upon("B4")
      
      expect(@cell_1.render).to eq("M")
    end

    it 'returns "H" if the cell has been fired upon and contains a ship' do
      cruiser = Ship.new("Cruiser", 3)
      @cell_2.place_ship(cruiser)

      expect(@cell_2.render).to eq(".")

      # Indicate that we want to show return "S" to show a ship with the optional argument
      # expect(@cell_2.render(true)).to ("S")
    end

    it 'returns "X" if the cell has been fired upon and its ship has sunk' do
      cruiser = Ship.new("Cruiser", 3)
      @cell_2.place_ship(cruiser)
      
      @cruiser.hit
      @cruiser.hit
      @cruiser.hit

      @cruiser.sunk?
      
      expect(@cell2.render).to eq("X")
    end

  end

end







# pry(main)> cell_2.fire_upon

# pry(main)> cell_2.render
# # => "H"

# pry(main)> cruiser.sunk?
# # => false

# pry(main)> cruiser.hit

# pry(main)> cruiser.hit

# pry(main)> cruiser.sunk?
# # => true

# pry(main)> cell_2.render
# # => "X"