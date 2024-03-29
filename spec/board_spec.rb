require "./lib/board"
require "./lib/cell"
require "./lib/ship"

RSpec.describe Board do
  it "exists" do
    board = Board.new

    expect(board).to be_a(Board)
  end

  it "has cells" do
    board = Board.new

    expect(board.cells).to be_a(Hash)
    expect(board.cells["A1"]).to be_a(Cell)
  end

  it "can validate coordinates" do
    board = Board.new

    expect(board.valid_coordinate?("A1")).to eq(true)
    expect(board.valid_coordinate?("D4")).to eq(true)
    expect(board.valid_coordinate?("A5")).to eq(false)
    expect(board.valid_coordinate?("E1")).to eq(false)
    expect(board.valid_coordinate?("A22")).to eq(false)
  end

  it "can validate placements" do
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    expect(board.valid_placement?(cruiser, ["A1", "A2"])).to eq(false)
    expect(board.valid_placement?(submarine, ["A2", "A3", "A4"])).to eq(false)
    expect(board.valid_placement?(cruiser, ["A1", "A2", "A4"])).to eq(false)
    expect(board.valid_placement?(submarine, ["A1", "C1"])).to eq(false)
    expect(board.valid_placement?(cruiser, ["A1", "B2", "C3"])).to eq(false)
    expect(board.valid_placement?(submarine, ["C2", "D3"])).to eq(false)
    expect(board.valid_placement?(cruiser, ["A1", "B1", "C1"])).to eq(true)
    expect(board.valid_placement?(submarine, ["A2", "B2"])).to eq(true)
  end

  it "can place ships" do
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)

    board.place(cruiser, ["A1", "A2", "A3"])

    expect(board.cells["A1"].ship).to eq(cruiser)
    expect(board.cells["A2"].ship).to eq(cruiser)
    expect(board.cells["A3"].ship).to eq(cruiser)
    expect(board.cells["A1"].ship == board.cells["A2"].ship).to eq(true)
    expect(board.cells["A1"].ship == board.cells["A3"].ship).to eq(true)
  end

  it "can render a board" do
    board = Board.new

    expect(board.render).to eq("  1 2 3 4 \n" +
                               "A . . . . \n" +
                               "B . . . . \n" +
                               "C . . . . \n" +
                               "D . . . . \n")
  end

  it "can render a board with ships" do
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    board.place(cruiser, ["A1", "A2", "A3"])

    expect(board.render(true)).to eq("  1 2 3 4 \n" +
                                     "A S S S . \n" +
                                     "B . . . . \n" +
                                     "C . . . . \n" +
                                     "D . . . . \n")
  end

  it "can render a board with hits and misses" do
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    board.place(cruiser, ["A1", "A2", "A3"])
    board.cells["A1"].fire_upon
    board.cells["B4"].fire_upon

    expect(board.render).to eq("  1 2 3 4 \n" +
                               "A H . . . \n" +
                               "B . . . M \n" +
                               "C . . . . \n" +
                               "D . . . . \n")
  end

  it "can render a board with a sunk ship" do
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    board.place(cruiser, ["A1", "A2", "A3"])
    board.cells["A1"].fire_upon
    board.cells["A2"].fire_upon
    board.cells["A3"].fire_upon

    expect(board.render).to eq("  1 2 3 4 \n" +
                               "A X X X . \n" +
                               "B . . . . \n" +
                               "C . . . . \n" +
                               "D . . . . \n")
  end
end