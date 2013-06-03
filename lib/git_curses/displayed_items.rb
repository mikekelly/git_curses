class DisplayedItems
  def initialize(items, visible_lines, index = 0)
    @items = items
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

  def get_items
    Array(items.slice(index, visible_lines))
  end

  private
  def max_index
    items.count - visible_lines
  end

  attr_reader :items, :visible_lines
  attr_accessor :index
end
