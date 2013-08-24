require_relative 'spec_helper'

describe DisplayedItems do
  subject { DisplayedItems.new(list, visible_lines, index) }
  let(:list)    { double 'list', count: list_count  }
  let(:visible_lines) { 5 }
  let(:test_items) { Array.new(list_count) { |n| "Item #{n}" } }
  let(:list_count) { 10 }

  describe 'initialization' do

    context 'deafult initailization' do
      subject { DisplayedItems.new(list, visible_lines) }

      it 'should be intialized with index 0' do
        list.should_receive(:slice).with(0, visible_lines).and_return([])
        subject.items
      end
    end

    context 'using nagative invalid index (< 0)' do
      let(:index) { -1 }

      it 'should be intialized with index 0' do
        expect{ subject }.to raise_error ArgumentError
      end
    end

    context 'using positive invalid index (> maximum displayable items)' do
      let(:index) { 100 }

      it 'should display maximum displayable items' do
        expect{ subject }.to raise_error ArgumentError
      end
    end
  end

  context 'when index is boyond start' do
    let(:index) { 1 }

    it 'should shift list upwards' do
      list.should_receive(:slice).with(1, visible_lines).and_return([])
      subject.items
    end
  end

  describe '#move_up' do
    context 'when at beginning of list' do
      let(:index) { 0 }

      it 'should stay in same place' do
        list.should_receive(:slice).with(0, visible_lines).twice.and_return([])
        subject.items
        subject.move_up
        subject.items
      end
    end

    context 'when before visible lines' do
      let(:index) { 5 }

      it 'shift list  up by 1' do
        list.should_receive(:slice).with(5, visible_lines).exactly(1).times.and_return([])
        list.should_receive(:slice).with(4, visible_lines).exactly(1).times.and_return([])
        subject.items
        subject.move_up
        subject.items
      end
    end
  end

  describe '#move_down' do
    context 'when bofore visible lines' do
      let(:index) { 0 }

      it 'should move down list' do
        list.should_receive(:slice).with(0, visible_lines).exactly(1).times.and_return([])
        list.should_receive(:slice).with(1, visible_lines).exactly(1).times.and_return([])
        subject.items
        subject.move_down
        subject.items
      end
    end

    context 'when at visible lines' do
      let(:index) { 5 }

      it 'should stay the same' do
        list.should_receive(:slice).with(5, visible_lines).twice.and_return([])
        subject.items
        subject.move_down
        subject.items
      end
    end
  end
end
