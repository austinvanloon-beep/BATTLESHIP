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

  describe 'a cell can contain a Ship or nothing' do

    before(:each) do
      @cell = Cell.new("B4")
    end

    it 'contains nothing by default' do
      expect(@cell.ship).to eq(nil)
    end

    it 'is empty when there is no ship' do
      expect(@cell.empty?).to eq(true)
    end

    # failing because it doesn't have the ship class yet
    it 'can place a ship into the cell' do
      cruiser = Ship.new("Cruiser", 3)

      @cell.place_ship(cruiser)

      expect(@cell.ship).to eq(cruiser)
      expect(@cell.empty?).to eq(false)
    end


  end


end