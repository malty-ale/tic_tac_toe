class Game
  attr_accessor :squares
  
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
    @winner = nil
    @current_player = @player_b
  end
  
  def start
    while @winner == nil do
      
      show_board
      
      @current_player == @player_a ? @current_player = @player_b : @current_player = @player_a
      puts "It's #{@current_player.name}'s turn!  Where would you like to go?"
      
      choice = nil
      while choice == nil do
        choice_to_test = gets.chomp.to_i
        if choice_to_test.between?(1,9) && @squares[choice_to_test] == nil
          choice = choice_to_test
        elsif choice_to_test.between?(1,9)
          puts "Someone else has already selected that square.  Please pick again."
          show_board
        else
          puts "Please write a number between 1 and 9."
          show_board
        end
      end
      
      pick_square(@current_player.name, choice)
      stalemate?
      success?
    end
    
    @winner == "Stalemate" ? (puts "It's a draw!") : (puts "Congrats #{@winner.name}, you won!")
    show_board
  end
  
  private
  
  def success?
    winners = [[1, 2, 3], [4, 5, 6], [7, 8, 9],
               [1, 4, 7], [2, 5, 8], [3, 6, 9],
               [1, 5, 9], [3, 5, 7]]
    if winners.any? {|line| line.all? {|square| @squares[square] == @current_player.name} }
      @winner = @current_player
    end
  end
  
  def stalemate?
    unless (1..9).to_a.any? {|i| @squares[i] == nil}
      @winner = "Stalemate"
    end
  end
      
    
  
  def pick_square(player, square)
    @squares[square.to_i] = player
  end
   
  def show_board
    puts " #{fill_square(1)} | #{fill_square(2)} | #{fill_square(3)}"
    puts " #{fill_square(4)} | #{fill_square(5)} | #{fill_square(6)}"
    puts " #{fill_square(7)} | #{fill_square(8)} | #{fill_square(9)}"
  end
  
  def fill_square(number)
    if @squares[number] == nil
      " "
    else
      @squares[number] == @player_a.name ? "X" : "O"
    end
  end
        
    
end

class Player
  attr_reader :name
  
  def initialize(name)
    @name = name
  end
end