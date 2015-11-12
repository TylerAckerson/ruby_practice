require 'colorize'

class Tile
  attr_reader :given
  attr_accessor :value

  def initialize(value, given)
    @value = value
    @given = given
  end

  def to_s
    if given
      value.to_s.colorize(:red)
    elsif(value.to_i > 0)
      value.to_s.colorize(:blue)
    else
      return "X"
    end
  end

  def update_value(val)
      if given
        p "This tile was given!"
      else
        p "This tile has been updated to #{val}."
        self.value = val.to_s
      end
  end

end
