class Fixnum
  def as_index
    self - 1
  end
end

module GitCurses
  class ListState
    def initialize(indexed_list, visible_lines, list_highlight = ListHighlight.new(visible_lines))
      @indexed_list = indexed_list
      @visible_lines = visible_lines
      @list_highlight = list_highlight
      self.list_index = 0
    end

    def move_up
      indexed_list.move_up

      list_highlight.move_up

      if !list_highlight.index_changed? && list_highlight.at_start?
        self.list_index = [list_index - 1, 0].max
      end
    end

    def move_down
      indexed_list.move_down

      list_highlight.move_down

      if !list_highlight.index_changed? && list_highlight.at_end?
        self.list_index = [list_index + 1, indexed_list.count - visible_lines].min
      end
    end

    def highlighted?(index)
      list_highlight.highlighted?(index)
    end

    def display_items
      Array(indexed_list.slice(list_index, visible_lines))
    end

  private
    attr_reader :visible_lines, :indexed_list, :list_highlight
    attr_accessor :item_index, :list_index
  end
end
