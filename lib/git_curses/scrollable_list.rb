class ScrollableList
  CURSOR_INVISIBLE = 0

  HIGHLIGHT_COLOR  = 1
  NORMAL_COLOR     = 2

  def initialize(lines)
    init_curses
    @list_state = ListState.new(lines, visible_lines)
  end

  def run
    @window = Curses.init_screen

    begin
      @window.keypad(true)
      update_display

      while (ch = @window.getch) != 'q' do
        if ch == Curses::Key::DOWN
          @list_state.move_down
        elsif ch == Curses::Key::UP
          @list_state.move_up
        end

        update_display
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

  def update_display
    reset_cursor
    display_lines
    refresh_window
  end

  def display_lines
    @list_state.display_items.each do |item|
      display_line(item.fetch(:line), item.fetch(:style))
    end
  end

  def refresh_window
    @window.refresh
  end

  def reset_cursor
    @window.setpos(0 ,0)
  end

  def color_for_style(style)
    case style
    when :normal
      NORMAL_COLOR
    when :highlight
      HIGHLIGHT_COLOR
    end
  end

  def display_line(line, style = :normal)
    @window.attron(Curses::color_pair(color_for_style(style))| Curses::A_NORMAL) do
      @window.addstr(line)
    end
  end
end
