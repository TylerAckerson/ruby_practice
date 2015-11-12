class Array

  def my_each
    len = self.length
    value = 0

    while value < len
      yield self[value]
      value += 1
    end

    self
  end


  def my_select
    output = []
    self.my_each do |el|
      output << el if yield el
    end

    output
  end

  def my_reject
    output = []
    self.my_each do |el|
      output << el unless yield el
    end

    output
  end

  def my_any
    self.my_each do |el|
      return true if yield el
    end

    false
  end

  def my_flatten
    output = []

    self.my_each do |el|
      if el.is_a? Array
        el.my_flatten.each do |subel|
          if subel.is_a? Fixnum
            output << subel
          end
        end
      elsif el.is_a? Fixnum
        #puts el
        output << el
      end
    end

    output
  end

  def my_zip(*args)
    output = []
    self.length.times do |idx|
      subarray = []
      subarray << self[idx]
      args.each do |ar|
        subarray << ar[idx]
      end
      output << subarray
    end

    output
  end

  def my_rotate(count = 1)
    count = count % self.length
    puts "COunt is #{count}"
    output = self[count..-1]
    output += self[0...count]
    #output
  end

  def my_join(sep = "")
    output = ""
    self.each_with_index do |el, idx|
      if idx == self.length - 1
        output << el
      else
        output << el << sep
      end
    end

    output
  end

  def my_reverse
    output = []
    
    (self.length - 1).downto(0) do |idx|
      output << self[idx]
    end

    output
  end
end
