require_relative 'Card'
require 'colorize'

class Board

  attr_accessor :board

  def self.empty_board
    Array.new(4) { Array.new(4,0) }
  end

  def initiliaze
    @board = nil
  end

  def populate
    self.board = Board::empty_board
    numbers = [1,1,2,2,3,3,4,4,5,5,6,6,7,7,8,8].shuffle

    board.each_with_index do |row, rowidx|
      row.each_with_index do |col, columnidx|
        self.board[rowidx][columnidx] = Card.new(numbers.pop)
      end
    end
    board
  end

  def render
      board.each do |row|
        row.each do |col|
          if col.hidden
            print "[ ]".colorize(:red)
          else
            print "[#{col.face_value.to_s.colorize(:blue)}]"
          end
        end
        print "\n"
      end
  end

  def won?
    return false if board.flatten.any? {|card| card.hidden}
    true
  end


  def reveal(guess_pos)
    x,y = guess_pos
    board[x][y].reveal
  end

  def hide(guess_pos)
    x,y = guess_pos
    board[x][y].hide
  end

end

# if __FILE__ == $PROGRAM_NAME
#   board = Board.new
#   board.populate
#   board.render
# end
