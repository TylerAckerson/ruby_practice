require_relative 'Card'
require_relative 'Board'

class Game
    attr_accessor :guessed_pos, :previous_guess
    attr_reader :board

    def initialize(board)
      @board = board
      @guessed_pos = []
      @previous_guess = nil
    end

  def play
    board.populate
    count = 0
    until board.won?

      if count.even?
        self.previous_guess = nil
      end

      system('clear')
      board.render
      prompt_for_guess
      board.reveal(guessed_pos)
      guess_is_match?
      self.previous_guess = guessed_pos
      count += 1
    end

    system('clear')
    puts "You win the game!"
    board.render
  end

  def prompt_for_guess
    puts "What is your guess (format: X,Y)?"
    x,y = gets.chomp.split(",").map(&:to_i)
    self.guessed_pos = [x-1,y-1]
  end

  def guess_is_match?
    unless previous_guess.nil?
      p "Previous: #{board.reveal(previous_guess)}"
      p "Guess: #{board.reveal(guessed_pos)}"
      if self.board.reveal(previous_guess) == self.board.reveal(guessed_pos)
        puts "Match!"

      else
        system('clear')
        board.render
        sleep(1)
        self.board.hide(previous_guess)
        self.board.hide(guessed_pos)
      end
    end
  end

end

if __FILE__ == $PROGRAM_NAME
  b = Board.new
  game = Game.new(b)
  game.play
end
