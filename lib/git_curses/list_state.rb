module GitCurses
  class ListState
    def initialize(indexed_list, visible_lines, list_highlight = ListHighlight.new(visible_lines), displayed_list_items = DisplayedListItems.new(indexed_list.count, visible_lines))
      @indexed_list = indexed_list
      @visible_lines = visible_lines
      @list_highlight = list_highlight
      @displayed_list_items = displayed_list_items
    end

    def move_up
      indexed_list.move_up

      list_highlight.move_up

      if list_highlight.upper_boundary_pushed?
        displayed_list_items.move_up
      end
    end

    def move_down
      indexed_list.move_down

      list_highlight.move_down

      if list_highlight.lower_boundary_pushed?
        displayed_list_items.move_down
      end
    end

    def highlighted?(index)
      list_highlight.highlighted?(index)
    end

    def display_items
      displayed_list_items.get_items(indexed_list)
    end

  private
    attr_reader :visible_lines, :indexed_list, :list_highlight, :displayed_list_items
  end
end
