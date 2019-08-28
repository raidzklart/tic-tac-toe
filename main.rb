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
end

class Game
  attr_reader :player_one, :player_two
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
  def initialize(weapon)
    @weapon = weapon
  end
  def to_s
    @weapon
  end
end

game = Game.new
game.set_player_one "X"
game.set_player_two "O"
puts game.player_one
puts game.player_two