#!/usr/bin/env ruby

require "curses"
require_relative "../lib/git_curses"
include GitCurses

test_lines = List.new (1..50).map{|num| "Line #{num}\n"}

ScrollableList.new(test_lines).run
