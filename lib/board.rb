require './lib/cell'
require './lib/ship'

class Board
  attr_reader :cells

  def initialize
    @cells = {
      "A1" => Cell.new("A1"),
      "A2" => Cell.new("A2"),
      "A3" => Cell.new("A3"),
      "A4" => Cell.new("A4"),
      "B1" => Cell.new("B1"),
      "B2" => Cell.new("B2"),
      "B3" => Cell.new("B3"),
      "B4" => Cell.new("B4"),
      "C1" => Cell.new("C1"),
      "C2" => Cell.new("C2"),
      "C3" => Cell.new("C3"),
      "C4" => Cell.new("C4"),
      "D1" => Cell.new("D1"),
      "D2" => Cell.new("D2"),
      "D3" => Cell.new("D3"),
      "D4" => Cell.new("D4")
    }
  end

  def valid_coordinate?(coordinate)
    @cells.keys.include?(coordinate)
  end

  def valid_placement?(ship, coordinates)
    return false if invalid_length?(ship, coordinates)
  
    sorted_coordinates = coordinates.sort
    consecutive_coordinates?(sorted_coordinates) && !diagonal_placement?(sorted_coordinates)
  end

  def invalid_length?(ship, coordinates)
    ship.length != coordinates.length
  end

  def consecutive_coordinates?(coordinates)
    letters = coordinates.map { |coordinate| coordinate[0].ord }
    numbers = coordinates.map { |coordinate| coordinate[1..-1].to_i }
    consecutive_letters = letters.each_cons(2).all? { |a, i| i == a + 1 }
    consecutive_numbers = numbers.each_cons(2).all? { |a, i| i == a + 1 }
    consecutive_letters || consecutive_numbers
  end

  def diagonal_placement?(coordinates)
    letters = coordinates.map { |coordinate| coordinate[0].ord }
    numbers = coordinates.map { |coordinate| coordinate[1..-1].to_i }

    letters.uniq.length > 1 && numbers.uniq.length > 1
  end

  def place(ship, coordinates)
    coordinates.each do |coordinate|
      @cells[coordinate].place_ship(ship)
    end
  end

  def render(show_ship = false)
    "  1 2 3 4 \n" +
    "A #{render_row(["A1", "A2", "A3", "A4"], show_ship)} \n" +
    "B #{render_row(["B1", "B2", "B3", "B4"], show_ship)} \n" +
    "C #{render_row(["C1", "C2", "C3", "C4"], show_ship)} \n" +
    "D #{render_row(["D1", "D2", "D3", "D4"], show_ship)} \n"
  end

  private

  def consecutive_letters?(letters)
    letters.each_cons(2).all? { |a, b| b.ord == a.ord + 1 }
  end

  def consecutive_numbers?(numbers)
    numbers.each_cons(2).all? { |a, b| b == a + 1 }
  end

  def render_row(coordinates, show_ship)
    coordinates.map do |coordinate|
      @cells[coordinate].render(show_ship)
    end.join(" ")
  end
end