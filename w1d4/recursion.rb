require "byebug"

def recursive_range(start, finish)
  return [] if start > finish
  [start] + recursive_range(start+1, finish)
end

def recursive_sum(ary)
  return ary.first if ary.length == 1
  ary.first + recursive_sum(ary.drop(1))
end

def iterative_sum(ary)
  sum = 0
  ary.each {|el| sum += el}
  sum
end

def exponent1(num, pow)
  return 1 if pow == 0
  num * exponent1(num, pow - 1)
end

def exponent2(num, pow)
  return 1 if pow == 0
  return num if pow == 1
  if pow.even?
    new_num = exponent2(num, pow / 2)
    new_num *= new_num
  else
    new_num = exponent2(num, (pow - 1) / 2)
    num * new_num * new_num
  end
end

class Array
  def deep_dup
    dup = []
    self.each do |el|
      dup << dup_helper(el)
    end
    dup
  end

  def dup_helper(item)
    return item if !item.is_a?(Array) || item.length == 1
    [item.first] + dup_helper(item.drop(1))
  end

end

def recurs_fibonacci(n)
  return [ ] if n == 0
  return [0] if n == 1
  return [0, 1] if n == 2
  arr = recurs_fibonacci(n - 1)
  arr << arr[n-2] + arr[n-3]
end


def iter_fibonacci(n)
  return []  if n == 0
  return [0] if n == 1
  arr = [0, 1]
  (n - 2).times do
    arr << arr[-2] + arr[-1]
  end
  arr
end


def binary_search(ary, target)

  ary = ary.sort
  if ary.length == 1 && ary.first != target
    return nil
  end
  pivot_id = ary.length / 2

  if (ary[pivot_id] <=> target) == 1
    return binary_search(ary[0...pivot_id], target)
  elsif (ary[pivot_id] <=> target) == 0
    return pivot_id
  else
    offset = ary[0...pivot_id].length
    return offset + binary_search(ary[pivot_id..-1], target)
  end
end

def make_change(amt, coins)

  return [coins.first] * (amt / coins.first) if coins.length == 1

  coin_count = amt / coins.first

  amt = amt - coins.first * coin_count

  [coins.first] * coin_count + make_change(amt, coins.drop(1))

end

def fancy_change(amt, coins)
  change = []
  while amt > 0
    new_change = one_of_each(amt, coins)
    amt = amt - new_change.inject(0) { |t, e| t + e }
    change += new_change
  end
  change
end

def one_of_each(amt, coins)
  # debugger
  return [coins.first] if coins.length == 1
  of_these = amt >= coins.first ? 1 : 0
  amt -= coins.first * of_these
  [coins.first] * of_these + one_of_each(amt, coins.drop(1))
end

def make_change2(amt, coins)
  current_change = []
  loop do
    return coins_helper(amt, coins)
  end
end

def coins_helper(amt, coins)
  # debugger
  if coins.length == 1
    puts "I'm in base case"
    puts
    return [coins.first] * (amt / coins.first)
  end
  change = nil
  coins.length.times do |idx|
    new_amt = amt >= coins[idx] ? amt - coins[idx] : amt
    idx_buffer = new_amt < coins[idx] ? 1 : 0
    idx_buffer = 0 if coins.last == coins[idx]
    num_coins = amt >= coins[idx] ? 1 : 0
    new_change = ([coins[idx]] * num_coins) + coins_helper(new_amt, coins[idx + idx_buffer..-1])
    change ||= new_change
    change = change.length < new_change.length ? change : new_change
  end

  change

end


def merge_sort(ary)
  return ary if ary.length == 1 || ary.length == 0
  divisor = (ary.length / 2)
  left, right = ary[0...divisor], ary[divisor..-1]
  merge(merge_sort(left), merge_sort(right))
end

def merge(ary1, ary2)
  merged = []
  while ary1.length > 0 || ary2.length > 0
    if ary1.first && !ary2.first
      merged << ary1.shift
    elsif ary2.first && !ary1.first
      merged << ary2.shift
    elsif ary1.first < ary2.first
      merged << ary1.shift
    else
      merged << ary2.shift
    end
  end
  merged
end

def subsets(ary)

  return [[]] if ary.length == 0

  s = subsets(ary.drop(1))

  s += s.map do |el|
    el + [ary.first]
  end
end

p subsets([1, 2, 3])
