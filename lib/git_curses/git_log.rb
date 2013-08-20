class GitLog
  def initialize
    @items ||= [].tap do |items|
      `git log --pretty=format:#{format_string}`.lines.each do |line|
        record = {}
        sections = line.split(delimiter)
        values.each_with_index do |(key, value), index|
          record[key] = sections[index].strip
        end
        items << record
      end
    end
  end

  def lines
    @lines ||= items.map do |item|
      "#{item[:sha]} - #{item[:branches]} #{item[:subject]} (#{item[:date]}) #{item[:author]}"
    end
  end

  attr_reader :items

  private
  def values
    {
      branches: '%d',
      sha:      '%h',
      author:   '%an',
      date:     '%cr',
      subject:   '%s'
    }
  end

  def format_string
    ''.tap do |result|
      values.each_with_index do |(key, value), index|
        result << escaped_delimiter unless index == 0
        result << value
      end
    end
  end

  def escaped_delimiter
    "'#{delimiter}'"
  end

  def delimiter
    '<<stop>>'
  end
end
