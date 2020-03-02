module Enumerable
  def my_each(&block)
    if block_given?
      for item in self
        block.call(item)
      end
      self
    else
      to_enum(__method__)
    end
  end

  def my_each_with_index(&block)
    if block_given?
      for index in (0...self.length)
        block.call(index)
      end
      self
    else
      to_enum(__method__)
    end
  end
end

[1, 2, 3].my_each_with_index {|index| puts index}

