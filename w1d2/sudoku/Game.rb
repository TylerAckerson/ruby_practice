require_relative 'Board'
require_relative 'Tile'


class Game
  attr_reader :board
  attr_accessor :position

  def initialize(board=nil)
    @board ||= Board::from_file("sudoku1-almost.txt")
    @position = nil
  end

  def play
    until board.solved?
      play_turn
    end

    system('clear')
    board.render
    p "You Win!"

  end

  def play_turn
      system('clear')
      board.render
      board.rows_solved?
      ask_position
      ask_number
      sleep(2)

  end

  def ask_position
    puts "What position to update (in X,Y format)?"
    ask_pos = gets.chomp

    self.position = ask_pos.split(",").map(&:to_i)
  end

  def ask_number
    puts "What number would you like in this position (from 1 to 9)?"
    num = gets.chomp
    x,y = position
    board.grid[x][y].update_value(num)
  end
end

if __FILE__ == $PROGRAM_NAME
  g = Game.new
  g.play
end
