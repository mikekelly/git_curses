class ScrollableList
  def initialize(lines)
    @lines = lines
  end

  def run
    with_window do |window|
      list_state = ListState.new(lines, window.visible_lines)
      window.update_display(list_state)

      while (ch = window.getch) != 'q' do
        if ch == Curses::Key::DOWN
          list_state.move_down
        elsif ch == Curses::Key::UP
          list_state.move_up
        end

        window.update_display(list_state)
      end
    end
  end

private
  attr_reader :lines

  def with_window
    window = CursesWindow.new
    window.init_screen
    begin
      yield(window)
    ensure
      window.close_screen
    end
  end
end
