class Fixnum
  def as_index
    self - 1
  end
end

module GitCurses
  class ListState
    def initialize(list, visible_lines, list_highlight = ListHighlight.new(visible_lines))
      self.list = list
      @visible_lines = visible_lines
      self.item_index = 0
      self.list_highlight = list_highlight
      self.list_index = 0
    end

    def move_up
      self.item_index = [item_index - 1, 0].max

      list_highlight.move_up

      if !list_highlight.index_changed? && list_highlight.at_start?
        self.list_index = [list_index - 1, 0].max
      end
    end

    def move_down
      self.item_index = [item_index + 1, list.count.as_index].min

      list_highlight.move_down

      if !list_highlight.index_changed? && list_highlight.at_end?
        self.list_index = [list_index + 1, list.count - visible_lines].min
      end
    end

    def highlighted?(index)
      list_highlight.highlighted?(index)
    end

    def display_items
      Array(list.slice(list_index, visible_lines))
    end

  private
    attr_reader :visible_lines
    attr_accessor :list, :item_index, :list_index, :list_highlight
  end
end
