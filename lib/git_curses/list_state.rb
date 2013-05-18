class Fixnum
  def as_index
    self - 1
  end
end

class ListState
  attr_reader :highlight_index

  def initialize(list, visible_lines)
    self.list = list
    @visible_lines = visible_lines
    self.item_index = 0
    self.highlight_index = 0
    self.list_index = 0
  end

  def move_up
    self.item_index = [item_index - 1, 0].max

    old_highlight_index = highlight_index
    self.highlight_index = [self.highlight_index - 1, 0].max
    highlight_index_changed = old_highlight_index != highlight_index

    if !highlight_index_changed && highlight_index == 0
      self.list_index = [list_index - 1, 0].max
    end
  end

  def move_down
    self.item_index = [item_index + 1, list.count.as_index].min

    old_highlight_index = highlight_index
    self.highlight_index = [self.highlight_index + 1, visible_lines.as_index].min
    highlight_index_changed = old_highlight_index != highlight_index

    if !highlight_index_changed && highlight_index == visible_lines.as_index
      self.list_index = [list_index + 1, list.count - visible_lines].min
    end
  end

  def display_items
    Array(list.slice(list_index, visible_lines))
  end

private
  attr_reader :visible_lines
  attr_writer  :highlight_index
  attr_accessor :list, :item_index, :list_index
end
