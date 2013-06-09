module GitCurses
  class List
    def initialize(list = [], index = 0)
      if list.count > 0 && index > list.count.as_index
        raise ArgumentError.new('Index supplied out of bounds')
      end
      self.list = list
      self.index = index
    end

    attr_reader :index

    def slice(start, length)
      list.slice(start, length)
    end

    def move_up
      self.index = [index - 1, 0].max
    end

    def move_down
      self.index = [index + 1, list.count.as_index].min
    end

    def count
      list.count
    end

  private
    attr_writer :index
    attr_accessor :list
  end
end
