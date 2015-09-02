require 'byebug'

def range(start, ending)
  return [] if ending < start

  array = range(start, ending - 1)
  array << ending
end

def sum_iterative(array)
  sum = 0
  array.each { |el| sum += el}
  sum
end

def sum_recursive(array)
  return 0 if array.length == 0
  array[0] + sum_recursive(array.drop(1))
end

def exponent_one(b, n)
  return 1 if n == 0
  b * exponent_one(b, n - 1)
end
#n recursive calls

def exponent_two(b,n)
  return 1 if n == 0
  if n.even?
    sqrt = exponent_two(b, n / 2)
    return sqrt * sqrt
  else
    sqrt = exponent_two(b, (n - 1 ) / 2)
    b * sqrt * sqrt
  end
end
#log(n) recursive calls

class Array
  def deep_dup
    return self.dup if self.none? { |el| el.is_a?(Array) }
    array = []
    self.each do |el|
      if el.is_a?(Array)
        array << el.deep_dup
      else
        array << el
      end
    end
    array
  end
end

def fibonacci_recursive(n)
  return [] if n < 1
  return [0] if n == 1
  return [0,1] if n == 2
  array = fibonacci_recursive(n - 1)
  array << (array[-1] + array[-2])
end

def fibonacci_iterative(n)
  a = [0,1]
  (n-2).times do |idx|
    a << (a[idx] + a[idx+1])
  end
  a[0...n]
end

# Returns the index of target in sorted Array array
# => nil if not found
def binary_search(array, target)
  return nil if array.empty?
  if array.length == 1
    return array[0] == target ? 0 : nil
  end

  guess = array.length / 2

  left = array[0...guess]
  right = array[guess..-1]

  left_result = binary_search(left,target)
  right_result = binary_search(right,target)
  right_result += guess unless right_result.nil?

  left_result || right_result || nil
end

def make_change(amount, coins = [25, 10, 5, 1])
  current_best = nil
  return [] if amount == 0
  coins.each do |coin|
    change = []
    next if amount < coin
    change << coin
    new_change = make_change(amount - coin, coins)
    change += new_change unless new_change.nil?
    current_best = change if (current_best.nil? || current_best.length > change.length)
  end
  current_best
end

def subsets(array)
  return [array] if array.empty?
  previous_array = subsets(array[0...-1])
  new_subset = previous_array.map do |subset|
    subset + [array.last]
  end
  previous_array + new_subset
end

def merge_sort(array)
  return array if array.length <= 1
  middle = array.length / 2
  left = array[0...middle]
  p left
  right = array[middle..-1]
  p right
  merge(merge_sort(left), merge_sort(right))
end

def merge(arr1, arr2)
  if arr1.first >= arr2.first
    arr1[0], arr2[0] = arr2[0], arr1[0]
  end
  arr1 + arr2
end
