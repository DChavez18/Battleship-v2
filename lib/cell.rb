class Cell
  attr_reader :coordinate, :ship

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @fire_upon = false
  end

  def empty?
    if @ship == nil
      true
    else
      false
    end
  end

  def place_ship(ship)
    @ship = ship
  end

  def fired_upon?
    @fire_upon
  end

  def fire_upon
    @ship.hit if @ship
    @fire_upon = true
  end

  def render(show_ship = false)
    if @fire_upon == false && show_ship == true && @ship != nil
      "S"
    elsif @fire_upon == false && show_ship == false && @ship != nil
      "."
    elsif @fire_upon == true && @ship == nil
      "M"
    elsif @fire_upon == true && @ship != nil && @ship.sunk? == false
      "H"
    elsif @fire_upon == true && @ship != nil && @ship.sunk? == true
      "X"
    else
      "."
    end
  end
end