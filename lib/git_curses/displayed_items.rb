class DisplayedItems

  include Enumerable

  def initialize(lines, visible_lines, index = 0)
    @lines = lines
    @visible_lines = visible_lines

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
    Array(lines.slice(index, visible_lines))
  end

  def each
    items.each do |item|
      yield item
    end
  end

  private
  def max_index
    lines.count - visible_lines
  end

  attr_reader :lines, :visible_lines
  attr_accessor :index
end
