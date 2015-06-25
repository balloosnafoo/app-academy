class Array
  def my_each(&blk)
    counter = 0
    while counter < self.length
      blk.call(self[counter]) if block_given?
      counter += 1
    end
    self
  end

  def my_map(&blk)
    new_ary = []
    self.my_each do |el|
      new_ary << blk.call(el)
    end
    new_ary
  end

  def my_select(&blk)
    new_ary = []
    self.my_each do |el|
      new_ary << el if blk.call(el)
    end
    new_ary
  end

  def my_inject(value, &blk)
    self.my_each do |el|
      value = blk.call(value, el)
    end
    value
  end

  def sorted?
    self.length.times do |id|
      next if id >= self.length - 1
      return false if self[id] > self[id+1]
    end
    true
  end

  def my_sort!(&blk)
    blk = Proc.new { |i, j| i <=> j } unless block_given?
    until self.sorted?
      self.length.times do |i|
        result = blk.call(self[i], self[i+1])
        self[i], self[i+1] = self[i+1], self[i] if result == 1
      end
    end
    self
  end

  def my_sort(&blk)
    dup = self.dup
    dup.my_sort!
  end

end


a = [1, 2, 3, 4]
a.my_inject(0) {|accum, el| accum + el }
p a.shuffle.my_sort
