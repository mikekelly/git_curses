#!/usr/bin/env ruby

require "curses"
require_relative "../lib/git_curses"

def update_display(window, list_state)
  display_lines(window, VISIBLE_LINES, list_state)
  window.refresh
end

def display_lines(window, visible_lines, list_state)
  window.setpos(0 ,0)
  window.attron(Curses::color_pair(NORMAL_COLOR)| Curses::A_NORMAL) do
    window.addstr "item index = #{list_state.item_index}\n"
    window.addstr "list start index = #{list_state.list_index}\n"
    window.addstr "highlight index = #{list_state.highlight_index}\n"
  end

  list_state.display_items.each_with_index do |line, index|
    color = index == list_state.highlight_index ? HIGHLIGHT_COLOR : NORMAL_COLOR
    window.attron(Curses::color_pair(color)| Curses::A_NORMAL) do
      window.addstr(line)
    end
  end
end

test_lines = (1..50).map{|num| "Line #{num}\n"}

CURSOR_INVISIBLE = 0

HIGHLIGHT_COLOR = 1
NORMAL_COLOR = 2

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

window = Curses.init_screen

SCREEN_HEIGHT = Curses.lines()
SCREEN_WIDTH  = Curses.cols()

VISIBLE_LINES = [15, SCREEN_HEIGHT].min

list_state = ListState.new(test_lines, VISIBLE_LINES)

begin
  window.keypad(true)
  update_display(window, list_state)

  while (ch = window.getch) != 'q' do
    if ch == Curses::Key::DOWN
      list_state.move_down
    elsif ch == Curses::Key::UP
      list_state.move_up
    end

    update_display(window, list_state)
  end
ensure
  Curses.close_screen
end
