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
end