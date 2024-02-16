require './lib/display_module.rb'
require 'pastel'
require 'tty-font'
require 'tty-box'

class Game

  include Display
  
  def initialize
    @player_cruiser = Ship.new("Cruiser", 3)
    @player_submarine = Ship.new("Submarine", 2)
    @computer_cruiser = Ship.new("Cruiser", 3)
    @computer_submarine = Ship.new("Submarine", 2)
    @computer_board = Board.new 
    @player_board = Board.new
  end
  
  def main_menu
    menu_display
    puts "Welcome Mariner! To BATTLESHIP. Ready up.
    Enter p to head into the sea-fight. Enter q to head back to the bunks."
  
    choice = gets.chomp.downcase
    if choice == "p"
      setup_game
      turn
    elsif choice == "q"
      puts "Thanks for playing!"
      exit
    else
      puts "Invalid choice. Please try again."
      main_menu
    end
  end

  def setup_game
    computer_place_ships
    puts "I have laid out my ships on the grid.
    You now need to lay out your two ships.
    The Cruiser is three units long and the Submarine is two units long.
      1 2 3 4
    A . . . .
    B . . . .
    C . . . .
    D . . . . "
    player_place_cruiser
    player_place_sub
    puts "Ships have been placed!"
  end
  
  def computer_place_ships
    random_cruiser_coordinates = @computer_board.cells.keys.sample(3)
    until @computer_board.valid_placement?(@computer_cruiser, random_cruiser_coordinates)
      random_cruiser_coordinates = @computer_board.cells.keys.sample(3)
    end
    @computer_board.place(@computer_cruiser, random_cruiser_coordinates)
    random_sub_coordinates = @computer_board.cells.keys.sample(2)
    until @computer_board.valid_placement?(@computer_submarine, random_sub_coordinates)
      random_sub_coordinates = @computer_board.cells.keys.sample(2)
    end
    @computer_board.place(@computer_submarine, random_sub_coordinates)
  end
  
  def  player_place_cruiser
    puts "Enter the squares for the Cruiser (3 spaces):"
    cruiser_coordinate = gets.chomp.upcase.split
    if @player_board.valid_placement?(@player_cruiser, cruiser_coordinate) == true
      @player_board.place(@player_cruiser, cruiser_coordinate)
    else
    puts "Invalid coordinates!"
    player_place_cruiser
    end
  end

  def player_place_sub
    puts "Enter the squares for the Submarine (2 spaces):"
    submarine_coordinate = gets.chomp.upcase.split
    if @player_board.valid_placement?(@player_submarine, submarine_coordinate) == true
        @player_board.place(@player_submarine, submarine_coordinate)
    else
      puts "Invalid coordinates!"
      player_place_sub
    end
  end

  def turn
    puts "Fire when ready!!!"
    shot_coordinate = gets.chomp.upcase
    if @computer_board.valid_coordinate?(shot_coordinate)
        @computer_board.cells[shot_coordinate].fire_upon
    else
      puts "Invalid coordinate, Try again"
      turn
    end
    if @computer_board.cells[shot_coordinate].ship
        puts " Your shot on #{shot_coordinate} was a HIT!"
      if @computer_board.cells[shot_coordinate].ship.sunk?
        puts "You sunk a ship!!"
    end
    else
        puts "Your shot on #{shot_coordinate} was a MISS!"
    end
    player_wins
    puts "My turn to shoot!!"
  
    cpu_shot_coordinate = @player_board.cells.keys.sample
    until !@player_board.cells[cpu_shot_coordinate].fired_upon?
        cpu_shot_coordinate = @player_board.cells.keys.sample
    end
    @player_board.cells[cpu_shot_coordinate].fire_upon
    if @player_board.cells[cpu_shot_coordinate].ship
        puts "The computer's shot on #{cpu_shot_coordinate} hit your ship!"
      if @player_board.cells[cpu_shot_coordinate].ship.sunk?
        puts "Your ship has been sunk!"
    end
    else
        puts "The computer's shot on #{cpu_shot_coordinate} missed your ship!"
    end
    display_boards(@player_board, @computer_board)
    cpu_wins
    turn
  end

  def player_wins
    if @computer_cruiser.sunk? && @computer_submarine.sunk?
      puts "You win!!"
      main_menu
    end
  end

  def cpu_wins
    if @player_cruiser.sunk? && @player_submarine.sunk? 
      puts "I win!!!"
      main_menu 
    end
  end

  def display_boards(player_board, computer_board)
    puts pastel.cyan('============= COMPUTER BOARD =============')
    puts pastel.blue(computer_board.render)
    puts pastel.cyan('============== PLAYER BOARD ==============')
    puts pastel.green(player_board.render(true))
  end
end