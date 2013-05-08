#!/usr/bin/ruby

require "curses"

CURSOR_INVISIBLE = 0
VISIBLE_LINES = 15

def update_display(test_lines, window, item_index)
  screen_height = Curses.lines()
  screen_width  = Curses.cols()

  window.clear

  window.addstr("item_index = #{item_index}\n")
  window.addstr("screen_height = #{screen_height}\n")
  window.addstr("screen_width = #{screen_width}\n")
  display_lines(test_lines, window, VISIBLE_LINES, item_index)
  window.refresh
end

def display_lines(test_lines, window, visible_lines, item_index)
  display_items = Array(test_lines.slice(item_index, visible_lines))
  display_items.each { |line| window.addstr(line) }
end

test_lines = (1..50).map{|num| "Line #{num}\n"}

# Don't echo user input
Curses.noecho
# Setup colors
Curses.start_color
# Make chars typed by user availble to program instantly
Curses.cbreak
# Make cursor invisible
Curses.curs_set(CURSOR_INVISIBLE)

item_index = 0

window = Curses.init_screen
begin
  update_display(test_lines, window, item_index)

  while (ch = window.getch) != 'q' do
    if ch == 'k'
      item_index = [item_index + 1, [test_lines.length - VISIBLE_LINES, 0].max].min
    elsif ch == 'j'
      item_index = [item_index - 1, 0].max
    end

    update_display(test_lines, window, item_index)
  end
ensure
  Curses.close_screen
end
