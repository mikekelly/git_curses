require 'spec_helper'

describe ListController do
  subject { ListController.new(lines) }

  let(:lines) { double 'lines' }
  let(:curses_window) { double 'curses window' }
  let(:list_state) { double 'list state' }

  describe '#run' do
    before do
      ListState.stub(:new => list_state)
      CursesWindow.stub(:new => curses_window)
      curses_window.should_receive(:init_screen)
      curses_window.should_receive(:close_screen)
      curses_window.should_receive(:update_display).with(list_state)
    end

    specify do
      subject.run
    end
  end
end
