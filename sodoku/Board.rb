require_relative 'Tile'
require 'colorize'

class Board
  attr_reader :grid

  def self.from_file(file_name)

    file = File.readlines(file_name)

    file_grid = file.each do |row|
      row.chomp!
    end

    file_grid.map! {|row| row.split("")}

    file_grid.each do |row|
      row.map! do |item|
        g = false
        if item.to_i > 0
          g = true
        end
         Tile.new(item, g)
      end
    end

    Board.new(file_grid)
  end

  def initialize(grid=nil)
    @grid = grid
  end

  def render
    grid.each_with_index do |row, row_idx|
      row.each_with_index do |item, col_idx|
        print "[ #{item.to_s} ]"
        if col_idx == 2 or col_idx == 5
          print " || "
        end
      end
      if row_idx == 2 or row_idx == 5
        print "\n"
        print "----- " * grid.count
      end
      print "\n"
    end
    nil
  end

  def solved?
    return true if  squares_solved? && cols_solved? && rows_solved?
    false
  end

  def rows_solved?
    grid.each do |row|
      arr = []
      row.each do |item|
        arr << item.value
      end
      return false unless (arr.uniq.length == 9 && !arr.include?("0"))
    end

    true
  end

  def cols_solved?
    9.times do |idx|
      arr = []
      grid.each do |row|
        arr << row[idx]
      end
      return false unless (arr.uniq.length == 9 && !arr.include?("0"))
    end

    true
  end

  def squares_solved?
    offset = 0

    while offset < 9
      arr = []
      3.times do |idx1|
        3.times do |idx2|
            arr << grid[idx1 + offset][idx2 + offset]
        end
      end

      return false unless (arr.uniq.length == 9 && !arr.include?("0"))
      offset += 3
    end

    true
  end

end
