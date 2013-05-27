class DisplayedItems
  def initialize(items, visible_lines, index = 0)
    @items = items
    @visible_lines = visible_lines
    @index = index
  end

  def move_up
    self.index = [index - 1, 0].max
  end

  def move_down
    self.index = [index + 1, items.count - visible_lines].min
  end

  def get_items
    Array(items.slice(index, visible_lines))
  end

  private
  attr_reader :items, :visible_lines
  attr_accessor :index
end
