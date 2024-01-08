require './lib/cell'
require './lib/ship'

RSpec.describe Cell do
  it 'exists' do
    cell = Cell.new("B4")

    expect(cell).to be_a(Cell)
  end

  it 'has a coordinate' do 
    cell = Cell.new("B4")

    expect(cell.coordinate).to eq("B4")
  end

  it 'starts with no ship' do
    cell = Cell.new("B4")

    expect(cell.ship).to eq(nil)
  end

  it 'starts empty' do
    cell = Cell.new("B4")

    expect(cell.empty?).to eq(true)
  end

  it 'can place a ship' do
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)

    cell.place_ship(cruiser)

    expect(cell.ship).to eq(cruiser)
    expect(cell.empty?).to eq(false)
  end

  it 'can be fired upon' do
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)

    cell.place_ship(cruiser)
    expect(cell.fired_upon?).to eq(false)

    cell.fire_upon

    expect(cell.ship.health).to eq(2)
  end

  it 'can be fired upon without a ship' do
    cell = Cell.new("B4")

    cell.fire_upon

    expect(cell.fired_upon?).to eq(true)
  end

  it 'can render a cell with no ship' do
    cell_1 = Cell.new("B4")

    expect(cell_1.render).to eq(".")
  end

  it 'can render a cell with a ship' do
    cell_1 = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)

    cell_1.place_ship(cruiser)

    expect(cell_1.render(true)).to eq("S")
  end

  it "can render a cell that's been fired upon" do
    cell_1 = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)

    cell_1.place_ship(cruiser)
    cell_1.fire_upon

    expect(cell_1.render).to eq("H")
  end

  it "can render a cell that's been fired upon and missed" do
    cell_1 = Cell.new("B4")

    cell_1.fire_upon

    expect(cell_1.render).to eq("M")
  end

  it "can render a cell that's been fired upon and sunk" do
    cell_1 = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)

    cell_1.place_ship(cruiser)
    cell_1.fire_upon

    expect(cruiser.sunk?).to eq(false)

    cruiser.hit
    cruiser.hit

    expect(cell_1.render).to eq("X")
  end
end