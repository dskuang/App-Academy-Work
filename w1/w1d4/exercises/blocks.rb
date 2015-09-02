class Array
  def my_each(&blk)
    self.length.times { |idx| blk.call(self[idx]) }
  end

  def my_map(&blk)
    a = []
    self.my_each { |el| a << blk.call(el) }
    a
  end

  def my_select(&blk)
    a = []
    self.my_each { |el| a << el if blk.call(el)}
    a
  end

  def my_inject(&blk)
    sum = self[0]
    self.drop(1).my_each do |el|
      sum = blk.call(sum,el)
    end
    sum
  end

  def my_sort!(&blk)
    self.length.times do
      idx = 0
      while idx < self.length
        if blk.call(self[idx], self[idx + 1]) == 1
          self[idx] , self[idx + 1] = self[idx + 1], self[idx]
        end
        idx += 1
      end
    end
    self
  end

  def my_sort(&blk)
    array = self.dup
    array.my_sort!(&blk)
  end
end

def eval_block(*args, &blk)
  return "NO BLOCK GIVEN" unless block_given?
  blk.call(*args)
end
