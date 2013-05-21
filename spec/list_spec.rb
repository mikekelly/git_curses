require_relative 'spec_helper'

describe List do
  subject { List.new(list, index) }

  let(:index) { 0 }
  let(:list) { [] }

  describe 'default values' do
    subject { List.new }

    its(:index) { should == 0 }

    its(:count) { should == 0 }

    it 'should be empty' do
      subject.slice(0, 12).should == []
    end
  end

  describe '#slice' do
    it 'should delegate to list' do
      index = double 'index'
      length = double 'length'
      list.should_receive(:slice).with(index, length)
      subject.slice(index, length)
    end
  end

  describe '#move_up' do
    before(:each) do
      subject.move_up
    end

    context 'when at list start' do
      let(:index) {0}
      it 'should have the same index' do
        subject.index.should == 0
      end
    end

    let(:index) {9}
    it 'should decrease its index by one' do
      subject.index.should == 8
    end
  end

  describe '#move_down' do
    let(:list) { (1..10).to_a }

    before(:each) do
      subject.move_down
    end

    context 'when at list end' do
      let(:index) {9}
      it 'should have the same index' do
        subject.index.should == 9
      end
    end

    let(:index) {1}
    it 'should increase its index by one' do
      subject.index.should == 2
    end
  end
end
