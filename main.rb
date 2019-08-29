class Board
  attr_reader :available_cells
  def initialize
    @cells = [1,2,3,4,5,6,7,8,9]
    @available_cells = [1,2,3,4,5,6,7,8,9]
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
    # system("cls") || system("clear")
    @cells[num-1] = weapon
    available_cells.delete(num)
    display
  end

  def to_s
    display
  end
end

class Game
  attr_reader :player_one, :player_two, :board
  def initialize
    @board = Board.new
    @board.display
    puts "Player 1, choose X/O?"
    while true
      p1_choice = gets.chomp.upcase
      if p1_choice == "X" or p1_choice == "O"
        @player_one = Player.new(p1_choice, @board)
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
    puts "Player two you are: #{@player_two}"
  end

  def set_player_one(weapon)
    
    @player_one.game = self
  end
  
  def set_player_two(weapon)
    @player_two = Player.new(weapon, @board)
    @player_two.game = self
  end

  def get_player_move(player)
    puts "Player #{player}, choose your move..."
    move = gets.chomp.to_i
    puts "Player #{player}, chose #{move}"
    player.choose_move move
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


while true
  unless game.board.available_cells.empty?
    game.get_player_move game.player_one
    unless game.board.available_cells.empty?
      game.get_player_move game.player_two
    else
      break
    end
  else
    break
  end
end