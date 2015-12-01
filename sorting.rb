def merge_sort(array)
  return array if array.length < 2

  half_length = array.length/2
  left = array.take(half_length)
  right = array.drop(half_length)

  sorted_left = merge_sort(left)
  sorted_right = merge_sort(right)

  merge(sorted_left,sorted_right)
end

def merge(array1, array2)
  merged = []

  until array1.empty? || array2.empty?
    case array1.first <=> array2.first
    when -1
      merged << array1.shift
    when 0
      merged << array1.shift
    when 1
      merged << array2.shift
    end
  end

  merged.concat(array1).concat(array2)
end

def quick_sort(array)
  return array if array.length < 2

  pivot = array.first
  left = []
  right = []

  array.drop(1).each do |value|
    case value <=> pivot
    when -1
      left << value
    when 0
      left << value
    when 1
      right << value
    end
  end

  quick_sort(left).concat([pivot]).concat(quick_sort(right))
end

def bubble_sort(array)
  sorted = false

  last = array.length - 2

  until sorted
    sorted = true

    0.upto(last).each do |i|
      if array[i] > array[i+1]
        array[i], array[i+1] = array[i+1], array[i]
        sorted = false
      end
    end

    last -= 1
  end

  array
end

# better quick sort (in place) that won't end up with a degnerate
# tree in the case the array is already sorted
class Array
  def quick_sort!(start = 0, len = length)
    return self if len < 2 #already sorted

    #randomize to avoid degenerate tree with depth n
    swap!(start, start + rand(len))
    pivot_idx = partition!(start, len)

    left_len = pivot_idx - start
    right_len = len - left_len - 1

    quick_sort!(start, left_len)
    quick_sort!(pivot_idx + 1, right_len)

    self
  end

  def partition!(start, len)
    pivot = start
    (start + 1...start + len).each do |i|
      if self[i] < self[pivot]
        swap!(i, pivot + 1)
        swap!(pivot, pivot + 1)
        pivot += 1
      end
    end

    pivot
  end

  def swap!(index1, index2)
    self[index1], self[index2] = self[index2], self[index1]
  end
end
