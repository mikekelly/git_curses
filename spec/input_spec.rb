describe Input do
  subject { Input.new(window) }

  let(:window) { double 'window' }

  describe '#next_command' do
    before do
      window.stub(:getch => next_char)
    end

    describe 'pressing q' do
      let(:next_char) { 'q' }
      its(:next_command) { should == :quit }
    end

    describe 'pressing down' do
      let(:next_char) { Curses::Key::DOWN }
      its(:next_command) { should == :move_down }
    end

    describe 'pressing up' do
      let(:next_char) { Curses::Key::UP }
      its(:next_command) { should == :move_up }
    end
  end
end
