require_relative 'spec_helper'

describe DisplayedItems do
  subject { DisplayedItems.new(items, visible_lines, index) }
  let(:items)    { (1..10).map{|n| "Item #{n}" } }
  let(:visible_lines) { 5 }

  describe 'initialization' do
    context 'deafult initailization' do
      subject { DisplayedItems.new(items, visible_lines) }

      it 'should be intialized with index 0' do
        subject.items == ['Item 1', 'Item 2', 'Item 3', 'Item 4', 'Item 5']
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
      subject.items.should == ['Item 2', 'Item 3', 'Item 4', 'Item 5', 'Item 6']
    end
  end

  describe '#move_up' do
    context 'when at beginning of list' do
      let(:index) { 0 }

      it 'should stay in same place' do
        subject.items == ['Item 1', 'Item 2', 'Item 3', 'Item 4', 'Item 5']
        subject.move_up
        subject.items == ['Item 1', 'Item 2', 'Item 3', 'Item 4', 'Item 5']
      end
    end

    context 'when before visible lines' do
      let(:index) { 5 }

      it 'shift list  up by 1' do
        subject.items == ['Item 6', 'Item 7', 'Item 8', 'Item 9', 'Item 10']
        subject.move_up
        subject.items == ['Item 5', 'Item 6', 'Item 7', 'Item 8', 'Item 9']
      end
    end
  end

  describe '#move_down' do
    context 'when bofore visible lines' do
      let(:index) { 0 }

      it 'should move down list' do
        subject.items == ['Item 1', 'Item 2', 'Item 3', 'Item 4', 'Item 5']
        subject.move_down
        subject.items == ['Item 2', 'Item 3', 'Item 4', 'Item 5', 'Item 6']
      end
    end

    context 'when at visible lines' do
      let(:index) { 5 }

      it 'should stay the same' do
        subject.items == ['Item 6', 'Item 7', 'Item 8', 'Item 9', 'Item 10']
        subject.move_down
        subject.items == ['Item 6', 'Item 7', 'Item 8', 'Item 9', 'Item 10']
      end
    end
  end
end
