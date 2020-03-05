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

  def my_select(&block)
    if block_given?
      ary = []
      for each in self
        if block.call(each)
          ary << each
        end
      end
      ary
    else
      to_enum(__method__)
    end
  end

  def my_all?(&block)
    if block_given?
      for each in self
        if block.call(each) == false
          return false
        end
      end
      true
    else
      for each in self
        if !!each == false
          return false
        end
      end
      true
    end
  end

  def my_any?(&block)
    if block_given?
      for each in self
        if block.call(each)
          return true
        end
      end
      false
    else
      for each in self
        if !!each == true
          return true
        end
      end
      false
    end
  end

  def my_none?(pattern=nil, &block)
    if block_given?
      for elem in self
        if block.call(elem)
          return false
        end
      end
      true
    else
      if pattern
        for elem in self
          if elem.class == pattern
            return false
          end
        end
        true
      else
        for elem in self
          if !!elem == true
            return false
          end
        end
        true
      end
    end
  end

  def my_count(obj=nil, &block)
    counter = 0
    if block_given?
      for elem in self
        counter += 1 if block.call(elem)
      end
      counter
    elsif obj
      for elem in self
        counter += 1 if elem == obj
      end
      counter
    else
      self.size
    end
  end

  def my_map(&block)
    ary = []
    if block_given?
      self.my_each {|each| ary << block.call(each)}
      ary
    else
      self.to_enum(__method__)
    end
  end

  def my_inject(initial=nil, &block)
    array_copy = Array(self).dup
    if block_given?
      initial = initial || array_copy.shift
      array_copy.my_each {|each| initial = block.call(initial, each)}
      initial
    else
      raise LocalJumpError.new("no block given")
    end
  end

  def my_inject_yield(initial=nil)
    array_copy = Array(self).dup
    initial = initial || array_copy.shift
    array_copy.my_each {|each| initial = yield(initial, each)}
    initial
  end
end

def multiply_els(arr)
  arr.my_inject_yield {|prod, n| prod * n}
end

c = [5, 6, 7]
p c.my_inject { |sum, n| sum + n }
p multiply_els([2, 4, 5])
p c.my_inject_yield { |sum, n| sum + n }
p multiply_els([2, 4, 5])