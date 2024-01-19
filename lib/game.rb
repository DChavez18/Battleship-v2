class Game
  attr_reader :board, :ships, :player_ships

  def initialize
    @board = Board.new
    @ships = []
    @player_ships = []
  end

  def place_computer_ships
    @ships << Ship.new("Cruiser", 3)
    @ships << Ship.new("Submarine", 2)
    @ships.each do |ship|
      loop do
        coordinates = @board.cells.keys.sample(ship.length)
        if @board.valid_placement?(ship, coordinates)
          @board.place(ship, coordinates)
          break
        end
      end
    end
  end

end