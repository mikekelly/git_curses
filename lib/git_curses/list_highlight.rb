module GitCurses
  class ListHighlight
    def initialize(visible_lines, index = 0)
      @visible_lines = visible_lines
      self.index = index
    end

    def move_up
      old_index = index
      self.index = [index - 1, 0].max
      self.index_changed = old_index != index
    end

    def move_down
      old_index = index
      self.index = [index + 1, visible_lines.as_index].min
      self.index_changed = old_index != index
    end

    def highlighted?(test_index)
      index == test_index
    end

    def index_changed?
      index_changed
    end

    def at_start?
      index == 0
    end

    def at_end?
      index == visible_lines.as_index
    end

  private
    attr_reader :visible_lines
    attr_accessor :index, :index_changed
  end
end
