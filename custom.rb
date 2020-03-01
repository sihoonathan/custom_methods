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
end

