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


end

