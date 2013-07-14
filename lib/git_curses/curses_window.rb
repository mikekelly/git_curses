require 'active_support/core_ext/module/delegation'

class CursesWindow
  CURSOR_INVISIBLE = 0

  HIGHLIGHT_COLOR  = 1
  NORMAL_COLOR     = 2

  def initialize
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

  attr_reader :window
  delegate :getch, :to => :window

  def init_screen
    @window = Curses.init_screen
    @window.keypad(true)
  end

  def close_screen
    Curses.close_screen
  end

  def visible_lines
    [15, screen_height].min
  end

  def update_display(list_state)
    reset_cursor
    display_lines(list_state)
    refresh_window
  end

private
  def reset_cursor
    @window.setpos(0 ,0)
  end

  def refresh_window
    @window.refresh
  end

  def display_lines(list_state)
    list_state.display_items.each do |item|
      display_line(item.fetch(:line), item.fetch(:style))
    end
  end

  def display_line(line, style = :normal)
    @window.attron(Curses::color_pair(color_for_style(style))| Curses::A_NORMAL) do
      @window.addstr(line)
    end
  end

  def color_for_style(style)
    case style
    when :normal
      NORMAL_COLOR
    when :highlight
      HIGHLIGHT_COLOR
    end
  end

  def screen_height
    Curses.lines()
  end
end
