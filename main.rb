class Board
  attr_reader :available_cells, :cells
  def initialize
    setup
  end

  def display
    puts "*********"
    puts "* #{@cells[0]}|#{@cells[1]}|#{@cells[2]} *"
    puts "* - - - *"
    puts "* #{@cells[3]}|#{@cells[4]}|#{@cells[5]} *"
    puts "* - - - *"
    puts "* #{@cells[6]}|#{@cells[7]}|#{@cells[8]} *"
    puts "*********"
  end

  def update_cells(num, weapon)
    system("cls") || system("clear")
    @cells[num-1] = weapon
    available_cells.delete(num)
    display
  end

  def reset
    setup
  end

  def to_s
    display
  end

  private
  def setup
    @cells = [1,2,3,4,5,6,7,8,9]
    @available_cells = [1,2,3,4,5,6,7,8,9]
  end
end

class Game
  attr_reader :player_one, :player_two, :board

  def initialize
    @board = Board.new
    puts "Player 1, choose X/O?"
    while true
      p1_choice = gets.chomp.upcase
      if p1_choice == "X" or p1_choice == "O"
        @player_one = Player.new(p1_choice, @board)
        @player_one.game = self
        break
      else
        puts "Player 1, YOU MUST choose X or O?"
      end
    end
    puts "Player one chose: #{@player_one}"
    if @player_one.weapon == "X"
      @player_two = Player.new("O", @board)
    else
      @player_two = Player.new("X", @board)
    end
    @player_two.game = self
    puts "Player two you are: #{@player_two}"
    @board.display
  end

  def play_game
    while true
      unless @board.available_cells.empty?
        self.get_player_move @player_one
          if self.check_winner == @player_one.weapon
            puts "Winner = #{self.check_winner}"
            break
          elsif self.check_winner == "Tie"
            puts "The game was a tie!"
            break
          end
        unless @board.available_cells.empty?
          self.get_player_move @player_two
          if self.check_winner == @player_two.weapon
            puts "Winner = #{self.check_winner}"
            break
          elsif self.check_winner == "Tie"
            puts "The game was a tie!"
            break
          end
        end
      end
    end
    puts "Would you like to play again? [Y/N]"
    answer = gets.chomp
    if answer[0].upcase == "Y"
      @board.reset
      @board.display
      play_game
    elsif answer[0].upcase == "N"
      exit!
    else
      puts "You didn't choose Y or N, game will now exit."
      exit!
    end
  end

  def get_player_move(player)
    puts "Player #{player}, choose your move..."
    move = gets.chomp.to_i
    puts "Player #{player}, chose #{move}"
    player.choose_move move
  end

  def check_winner
    case 
      when (@board.cells[0] == @board.cells[1]) && (@board.cells[1] == @board.cells[2])
        return @board.cells[0]
      when (@board.cells[3] == @board.cells[4]) && (@board.cells[4] == @board.cells[5])
        return @board.cells[3]
      when (@board.cells[6] == @board.cells[7]) && (@board.cells[7] == @board.cells[8])
        return @board.cells[6]
      when (@board.cells[0] == @board.cells[3]) && (@board.cells[3] == @board.cells[6])
        return @board.cells[0]
      when (@board.cells[1] == @board.cells[4]) && (@board.cells[4] == @board.cells[7])
        return @board.cells[1]
      when (@board.cells[2] == @board.cells[5]) && (@board.cells[5] == @board.cells[8])
        return @board.cells[2]
      when (@board.cells[0] == @board.cells[4]) && (@board.cells[4] == @board.cells[8])
        return @board.cells[0]
      when (@board.cells[2] == @board.cells[4]) && (@board.cells[4] == @board.cells[6])
        return @board.cells[2]
      when @board.available_cells.empty?
        return "Tie"
    end
  end
end

class Player
  attr_reader :weapon
  def initialize(weapon, board)
    @weapon = weapon
    @board = board
  end

  def choose_move(choice)
    if @board.available_cells.include? choice
      @board.update_cells(choice, self.weapon)
    else
      puts "This cell is already taken, please choose again"
      @game.get_player_move(self)
    end
  end

  def game=(game)
    @game = game
  end

  def to_s
    @weapon
  end
end

game = Game.new
game.play_game