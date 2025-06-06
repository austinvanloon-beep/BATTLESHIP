require_relative 'spec_helper'

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
      @cell.fire_upon

      expect(@cell.ship.health).to eq(2)
      expect(@cell.fired_upon?).to eq(true)
    end
  
  end

  describe '#Render' do

    before(:each) do
      @cell_1 = Cell.new("B4")
      @cell_2 = Cell.new("C3")
      @cruiser = Ship.new("Cruiser", 3)
    end

    it 'returns "." if the cell has not been fired upon and does not contain a ship' do
      expect(@cell_1.render).to eq(".")
    end

    it 'returns "." if the cell has not been fired upon and contains a ship and the show_ship argument is false' do
      @cell_2.place_ship(@cruiser)
      
      expect(@cell_2.render).to eq(".")

    end
    it 'returns "S" if the cell has not been fired upon and contains a ship and the show_ship argument is true' do
      @cell_2.place_ship(@cruiser)
      
      expect(@cell_2.render(true)).to eq("S")
    end

    it 'returns "M" if the cell has been fired upon and does not contain a ship' do
      @cell_1.fire_upon
      
      expect(@cell_1.render).to eq("M")
    end

    it 'returns "H" if the cell has been fired upon and contains a ship' do
      @cell_2.place_ship(@cruiser)
      @cell_2.fire_upon

      expect(@cell_2.render).to eq("H")

      # did not reduce health to 0, so does not sink
      expect(@cruiser.sunk?).to eq(false)
    end

    it 'returns "X" if the cell has been fired upon and its ship has sunk' do
      @cell_2.place_ship(@cruiser)
      3.times {@cruiser.hit}
      @cell_2.fire_upon

      expect(@cruiser.sunk?).to eq(true)
      expect(@cell_2.render).to eq("X")
    end

  end

  
end