require 'pastel'
require 'tty-font'

module Display

  def pastel
    Pastel.new
  end

  def font(style)
    TTY::Font.new(style)
  end

  def menu_display
    puts pastel.cyan(font(:doom).write("BATTLESHIP"))
  end

  def display_boards
    puts "=============COMPUTER BOARD============="
    puts @computer_board.render
    puts "==============PLAYER BOARD=============="
    puts @player_board.render(true)
  end
end