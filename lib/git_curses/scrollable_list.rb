class ScrollableList
  CURSOR_INVISIBLE = 0

  HIGHLIGHT_COLOR  = 1
  NORMAL_COLOR     = 2

  def initialize(lines)
    init_curses
    @list_state = ListState.new(lines, visible_lines)
  end

  def run
    window = Curses.init_screen

    begin
      window.keypad(true)
      update_display(window)

      while (ch = window.getch) != 'q' do
        if ch == Curses::Key::DOWN
          @list_state.move_down
        elsif ch == Curses::Key::UP
          @list_state.move_up
        end

        update_display(window)
      end
    ensure
      Curses.close_screen
    end
  end

private
  def init_curses
    # Don't echo user input
    Curses.noecho
    # Setup colors
    Curses.start_color
    Curses.init_pair(HIGHLIGHT_COLOR, Curses::COLOR_BLACK, Curses::COLOR_WHITE)
    Curses.init_pair(NORMAL_COLOR, Curses::COLOR_WHITE, Curses::COLOR_BLACK)
    # Make chars typed by user availble to program instantly
    Curses.cbreak
    # Make cursor invisible
    Curses.curs_set(CURSOR_INVISIBLE)
  end

  def screen_height
    Curses.lines()
  end

  def screen_width
    Curses.cols()
  end

  def visible_lines
    [15, screen_height].min
  end

  def update_display(window)
    display_lines(window)
    window.refresh
  end

  def display_lines(window)
    window.setpos(0 ,0)
    @list_state.display_items.each_with_index do |line, index|
      color = @list_state.highlighted?(index) ? HIGHLIGHT_COLOR : NORMAL_COLOR
      window.attron(Curses::color_pair(color)| Curses::A_NORMAL) do
        window.addstr(line)
      end
    end
  end
end
