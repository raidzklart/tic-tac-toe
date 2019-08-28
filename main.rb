class Board
  def initialize
    @cells = [1,2,3,4,5,6,7,8,9]
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
    display
  end
end

class Game
  attr_reader :player_one, :player_two, :board
  def initialize
    @board = Board.new
    @board.display
  end

  def set_player_one(weapon)
    @player_one = Player.new(weapon)
  end
  
  def set_player_two(weapon)
    @player_two = Player.new(weapon)
  end
end

class Player
  attr_reader :weapon
  def initialize(weapon)
    @weapon = weapon
  end
  def to_s
    @weapon
  end
end

game = Game.new
puts "Player 1, choose X/O?"
p1_selection = gets.chomp
game.set_player_one p1_selection.upcase
if game.player_one.weapon == "X"
  game.set_player_two "O"
else
  game.set_player_two "X"
end
game.board.update_cells 5, game.player_one
game.board.update_cells 6, game.player_two