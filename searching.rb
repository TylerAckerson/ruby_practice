def bsearch(array, target)
  return nil if array.length.zero?

  middle = array.length / 2
  lesser = array.take(middle)
  greater = array.drop(middle + 1)

  if array[middle] == target
    middle
  elsif array[middle] > target
    bsearch(lesser, target)
  else
    result = bsearch(greater, target)
    return nil if result.nil?
    result + middle + 1
  end
end
