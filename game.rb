class Game
  
  def initialize
    puts "What is player one's name?"
    playerA = gets.chomp
    puts "Thanks #{playerA}, you will be X's."
    @player_a = Player.new(playerA)
    puts "What is player two's name?"
    playerB = gets.chomp
    puts "Thanks #{playerB}, you will be O's."
    @player_b = Player.new(playerB)
    @squares = {}
    @success = false
    @winner = nil
    @current_player = @player_b
  end
  
  def start
    until @success do
      @current_player == @player_a ? @current_player = @player_b : @current_player = @player_a
      puts "It's #{@current_player}'s turn!  Where would you like to go?"
      #add board image, then have them pick a square
      success?
    end   
  end
  
  private
  
  def success?
    winners = [[1, 2, 3], [4, 5, 6], [7, 8, 9],
               [1, 4, 7], [2, 5, 8], [3, 6, 9],
               [1, 5, 9], [3, 5, 7]]
    if winners.any? {|line| line.all? {|square| @squares[square] = @current_player} }
      @success = true
      @winner = @current_player
    end
  end
  
  def pick_square(player, square)
    @squares[square] = player
  end
    
end

class Player
  def initialize(name)
    @name = name
  end
end