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

  def display_boards(player_board, computer_board)
    puts pastel.cyan('============= COMPUTER BOARD =============')
    puts pastel.blue(computer_board.render)
    puts pastel.cyan('============== PLAYER BOARD ==============')
    puts pastel.green(player_board.render(true))
  end
end