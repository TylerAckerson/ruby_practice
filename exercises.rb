def range(min, max)
  return [] if max <= min

  range(min, max - 1) << max - 1
end

def sum_array(array)
  return 0 if array.empty?

  array.first + sum_array(array.drop(1))
end

def sum_array_iter(array)
  sum = 0
  array.each { |int| sum += int }
  sum
end

def ex_1(num, exp)
  return 1 if exp.zero?

  num * ex_1(num, exp - 1)
end

def ex_2(num, exp)
  if exp.zero?
    1
  elsif exp == 1
    num
  else
    half = ex_2(num, exp / 2)

    if exp.even?
      half * half
    else
      num * half * half
    end
  end
end

class Array
  def deep_dup
    new_array = []

    self.each do |el|
      if el.is_a? Array
        new_array << el.deep_dup
      else
        new_array << el
      end
    end

    new_array
  end
end


def fib(n)
  # return [] if n.zero?
  # return [1] if n == 1
  # return [0,1] if n == 2

  #summarized:
  if n <= 2
    [0, 1].take(n)
  else
    fibs = fib(n-1)
    fibs << fibs[-2] + fibs.last
  end
end

def bsearch(array, target)
  return nil if array.length.zero?

  middle_idx = array.length / 2

  lesser = array.take(middle_idx)
  greater = array.drop(middle_idx + 1)

  if array[middle_idx] == target
    middle_idx
  elsif target < middle_idx
    bsearch(lesser, target)
  else
    search = bsearch(greater, target)
    return nil if search.nil?
    middle_idx + 1 + search
  end
end

def make_change(amount, coins = [25, 10 , 5, 1])
  return [] if amount.zero?
  return nil if coins.none? { |coin| coin <= amount }

  best_change = nil

  coins.each_with_index do |coin, idx|
    next if coin > amount
    remaining = amount - coin
    best_remaining_coins = make_change(remaining, coins.drop(idx))
    next if best_remaining_coins.nil?

    this_change = [coin] + best_remaining_coins

    if (best_change.nil? || (this_change.count < best_change.count))
      best_change = this_change
    end
  end

  best_change
end

def merge_sort(array)
  return array if array.length < 2

  mid_point = array.length / 2
  left, right = array.take(mid_point), array.drop(mid_point)

  sorted_left = merge_sort(left)
  sorted_right = merge_sort(right)

  merge(sorted_left, sorted_right)
end

def merge(array1, array2)
  merged_a = []

  until array1.empty? || array2.empty?
    case array1.first <=> array2.first
    when -1
      merged_a << array1.shift
    when 0
      merged_a << array1.shift
    when 1
      merged_a << array2.shift
    end
  end

  merged_a.concat(array1).concat(array2)
end

def subsets(array)
  return [[]] if array.empty?

  prev_subsets = subsets(array[0...-1])
  new_subsets = prev_subsets.map { |sub| sub + [array.last] }

  prev_subsets + new_subsets
end

# p subsets([]) # => [[]]
# p subsets([1]) # => [[], [1]]
# p subsets([1, 2]) # => [[], [1], [2], [1, 2]]
# p subsets([1, 2, 3])
# p subsets([1, 2, 3, 4])
