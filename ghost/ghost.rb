class Game
  attr_accessor :current_player, :previous_player

  def self.dictionary
    file = File.readlines("ghost-dictionary.txt")
    file.map! {|line| line.strip }
  end

  def initialize(*players)
    #@previous_player = player2
    @all_players = create_players(players)
    @current_player = @all_players.first
    @fragment = ""
    @dictionary = Game::dictionary
  end

  def create_players(names)
    players = []
    names.each do |player|
      Player.new(player)
    end

    players
  end

  def random_word
    @dictionary.sample
  end

  def next_player!
    # @current_player, @previous_player = @previous_player, @current_player
    current = @all_players.index_of(@current_player)
    @current_player = @all_players[(current + 1) % (@all_players.length)]
  end

  def run
    until game_over?
      play_round
    end

    puts "Game over!"
  end

  def play_round
    while true
      guess = take_turn(@current_player)

      if round_over?(guess)
        puts "Round over."
        @current_player.increase_score
        display_scores
        return @fragment
      else
        @fragment = guess
        puts "Fragment: #{@fragment}"
        next_player!
      end
    end
  end

  def display_scores
    # puts "#{@current_player.name}: #{@current_player.score}"
    # puts "#{@previous_player.name}: #{@previous_player.score}"

    @all_players.each do |player|
      puts player.name
      puts player.score
    end

  end

  def take_turn(player)
    letter = player.take_turn
    word_check = @fragment + letter
    until valid_play?(word_check)
      puts "Guess no good"
      word_check = @fragment + player.take_turn
    end

    word_check
  end

  def valid_play?(string)
    @dictionary.each do |word|
      return true if word[0...string.length] == string
    end

    return false
  end

  def round_over?(string)

    @dictionary.each do |word|
      if word == string
        return true
      # else
      #   return false
      end
    end

    false
  end

  def game_over?
    # return (@current_player.score == "GHOST" || @previous_player.score == "GHOST")
    return @all_players.any? { |player| player.score == "GHOST" }
  end

end

class Player
  attr_reader :name

  def initialize(name)
    @name = name
    @score = 0
  end

  def take_turn
    puts "#{@name}, guess a letter!"
    guess = gets.chomp
  end

  def increase_score
    @score += 1
  end

  def score
    # if @score == 0
    #   return "Score is zero"
    # else
    #   return "GHOST"[0, score]
    # end

    return @score == 0 ? "Score is zero" : "GHOST"[0, @score]
  end

end

# game =  Game.new(Player.new("scott"), Player.new("tyler"))
game = Game.new("scott", "tyler", "tony", "sarah")
game.run
# puts game.current_player
# puts game.previous_player
#  game.next_player!
# puts game.current_player
# puts game.previous_player
