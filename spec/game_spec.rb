require "./lib/board"
require "./lib/cell"
require "./lib/ship"
require "./lib/game"

RSpec.describe Game do
  it "exists" do
    game = Game.new

    expect(game).to be_a(Game)
  end

  it "has a player board" do
    game = Game.new

    expect(game.player_board).to be_a(Board)
  end

  it "has a computer board" do
    game = Game.new

    expect(game.computer_board).to be_a(Board)
  end

  it "has a player cruiser" do
    game = Game.new

    expect(game.player_cruiser).to be_a(Ship)
    expect(game.player_cruiser.name).to eq("Cruiser")
    expect(game.player_cruiser.length).to eq(3)
    expect(game.player_cruiser.health).to eq(3)
  end

  it "has a player submarine" do
    game = Game.new

    expect(game.player_submarine).to be_a(Ship)
    expect(game.player_submarine.name).to eq("Submarine")
    expect(game.player_submarine.length).to eq(2)
    expect(game.player_submarine.health).to eq(2)
  end

  it "has a computer cruiser" do
    game = Game.new

    expect(game.computer_cruiser).to be_a(Ship)
    expect(game.computer_cruiser.name).to eq("Cruiser")
    expect(game.computer_cruiser.length).to eq(3)
    expect(game.computer_cruiser.health).to eq(3)
  end

  it "has a computer submarine" do
    game = Game.new

    expect(game.computer_submarine).to be_a(Ship)
    expect(game.computer_submarine.name).to eq("Submarine")
    expect(game.computer_submarine.length).to eq(2)
    expect(game.computer_submarine.health).to eq(2)
  end
end