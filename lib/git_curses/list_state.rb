module GitCurses
  class ListState
    def initialize(lines, visible_line_count)
      @list = List.new(lines)
      max_highlight_index = [lines.count, visible_line_count].min.as_index
      @highlight = Highlight.new(max_highlight_index)
      @displayed_items = DisplayedItems.new(@list, visible_line_count)
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

    def index
      list.index
    end

  private
    attr_reader :list, :highlight, :displayed_items

    def line_style(index)
      if highlight.highlighted?(index)
        :highlight
      else
        :normal
      end
    end
  end
end
