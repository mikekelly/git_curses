class DisplayedItems

  include Enumerable

  def initialize(list, visible_line_count, index = 0)
    @list = list
    @visible_line_count = visible_line_count

    raise(ArgumentError, "index cannot be < 0") if index < 0
    raise(ArgumentError, "supplied index #{index} is out of bounds for supplied list") if index > max_index
    @index = index
  end

  def move_up
    self.index = [index - 1, 0].max
  end

  def move_down
    self.index = [index + 1, max_index].min
  end

  def items
    Array(list.slice(index, visible_line_count))
  end

  def each
    items.each do |item|
      yield item
    end
  end

  private
  def max_index
    list.count - visible_line_count
  end

  attr_reader :list, :visible_line_count
  attr_accessor :index
end
