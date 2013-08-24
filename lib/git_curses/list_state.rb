module GitCurses
  class ListState
    def initialize(list, visible_lines, highlight = Highlight.new(visible_lines), displayed_items = DisplayedItems.new(list, visible_lines))
      @list = list
      @visible_lines = visible_lines
      @highlight = highlight
      @displayed_items = displayed_items
    end

    def move_up
      list.move_up

      highlight.move_up

      if highlight.upper_boundary_pushed?
        displayed_items.move_up
      end
    end

    def move_down
      list.move_down

      highlight.move_down

      if highlight.lower_boundary_pushed?
        displayed_items.move_down
      end
    end

    def highlighted?(index)
      highlight.highlighted?(index)
    end

    def debug_message
      ""
    end

    def display_items
      displayed_items.each_with_index.map do |line, index|
        {
          :line  => line,
          :style => line_style(index)
        }
      end
    end

  private
    attr_reader :visible_lines, :list, :highlight, :displayed_items

    def line_style(index)
      if highlight.highlighted?(index)
        :highlight
      else
        :normal
      end
    end
  end
end
