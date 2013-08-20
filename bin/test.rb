#!/usr/bin/env ruby

require "debugger"
require "curses"
require_relative "../lib/git_curses"
include GitCurses

log = GitLog.new

ListController.new(log.lines).run
