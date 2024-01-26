class Game
  attr_reader :player_board, 
              :computer_board, 
              :player_cruiser, 
              :player_submarine, 
              :computer_cruiser, 
              :computer_submarine

  def initialize
    @player_cruiser = Ship.new("Cruiser", 3)
    @player_submarine = Ship.new("Submarine", 2)
    @computer_cruiser = Ship.new("Cruiser", 3)
    @computer_submarine = Ship.new("Submarine", 2)
    @player_board = Board.new
    @computer_board = Board.new
  end

end