class DisplayedItems
  def initialize(list_count, visible_lines, index = 0)
    @list_count = list_count
    @visible_lines = visible_lines
    @index = index
  end

  def move_up
    self.index = [index - 1, 0].max
  end

  def move_down
    self.index = [index + 1, list_count - visible_lines].min
  end

  def get_items(list)
    Array(list.slice(index, visible_lines))
  end

  private
  attr_reader :list_count, :visible_lines
  attr_accessor :index
end
