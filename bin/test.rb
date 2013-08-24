#!/usr/bin/env ruby

require "debugger"
require "curses"
require_relative "../lib/git_curses"
include GitCurses

test_lines = Array.new (1..50).map{|num| "Line #{num}\n"}

ListController.new(test_lines).run
