require "./lib/board"
require "./lib/cell"
require "./lib/ship"
require "./lib/game"

RSpec.describe Game do
  it "exists" do
    game = Game.new

    expect(game).to be_a(Game)
  end

  it "has a board" do
    game = Game.new

    expect(game.board).to be_a(Board)
  end

  it "can have computer ships" do
    game = Game.new

    expect(game.ships).to eq([])
  end

  it "can have player ships" do
    game = Game.new

    expect(game.player_ships).to eq([])
  end

  it "can place computer ships" do
    game = Game.new

    game.place_computer_ships

    expect(game.ships[0].length).to eq(3)
    expect(game.ships[1].length).to eq(2)
    expect(game.board.cells.values.count { |cell| cell.ship != nil }).to eq(5)    
  end
end