require_relative 'spec_helper'

describe Highlight do
  subject { Highlight.new(visible_lines, index) }
  let(:visible_lines) { double 'visible lines' }

  describe 'default initializer' do
    subject { Highlight.new(visible_lines) }
    its(:upper_boundary_pushed?) { should be_false }
    its(:upper_boundary_pushed?) { should be_false }
    specify { subject.highlighted?(0).should == true }
  end

  describe '#move_up' do
    before(:each) do
      subject.move_up
    end

    let(:index) { 9 }

    it 'should decrease index by 1' do
      subject.highlighted?(index - 1).should == true
    end

    its(:upper_boundary_pushed?) { should be_false }
    its(:upper_boundary_pushed?) { should be_false }

    context 'when at highlight start' do
      let(:index) { 0 }

      it 'should not change index' do
        subject.highlighted?(index).should == true
      end

      its(:upper_boundary_pushed?) { should be_true  }
      its(:lower_boundary_pushed?) { should be_false }
    end
  end

  describe '#move_down' do
    let(:visible_lines) { 10 }

    before(:each) do
      subject.move_down
    end

    let(:index) { 1 }

    it 'should increse its index by 1' do
      subject.highlighted?(index + 1).should == true
    end

    its(:upper_boundary_pushed?) { should be_false }
    its(:upper_boundary_pushed?) { should be_false }

    context 'when at highlight end' do
      let(:index) { 9 }

      it 'should not change index' do
        subject.highlighted?(index) == true
      end

      its(:upper_boundary_pushed?) { should be_false }
      its(:lower_boundary_pushed?) { should be_true  }
    end
  end

  describe '#highlighted?' do
    let(:index) { double 'index' }
    let(:test_index) { double 'test index' }

    it 'should test index against test index' do
      index.should_receive(:==).with(test_index)
      subject.highlighted?(test_index)
    end

    it 'should return result of comparison' do
      comparison_result = double 'comparison result'
      index.stub(:==).and_return(comparison_result)
      subject.highlighted?(test_index).should == comparison_result
    end
  end
end
