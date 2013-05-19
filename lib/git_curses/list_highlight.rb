module GitCurses
  class ListHighlight
    def initialize(visible_lines, index = 0)
      @visible_lines = visible_lines
      self.index = index
      reset_flags
    end

    attr_reader :upper_boundary_pushed, :lower_boundary_pushed

    alias_method :upper_boundary_pushed?, :upper_boundary_pushed
    alias_method :lower_boundary_pushed?, :lower_boundary_pushed

    def move_up
      reset_flags

      old_index = index
      self.index = [index - 1, 0].max
      index_changed = old_index != index

      self.upper_boundary_pushed = at_start? && !index_changed
    end

    def move_down
      reset_flags

      old_index = index
      self.index = [index + 1, visible_lines.as_index].min
      index_changed = old_index != index

      self.lower_boundary_pushed = at_end? && !index_changed
    end

    def highlighted?(test_index)
      index == test_index
    end

  private
    attr_reader :visible_lines
    attr_accessor :index
    attr_writer :upper_boundary_pushed, :lower_boundary_pushed

    def reset_flags
      self.lower_boundary_pushed = false
      self.upper_boundary_pushed = false
    end

    def at_start?
      index == 0
    end

    def at_end?
      index == visible_lines.as_index
    end
  end
end
