require "./board"
require "./player"
require "./ai"

class ConnectFour

#----------

  def initialize(num_players)

    @board = Board.new
    @player_1 = Player.new("Player 1", :x, @board)

    if num_players == 2
      @player_2 = Player.new("Player 2", :o, @board)
    else
      @player_2 = AI.new("Dumb AI", :o, @board, @player_1)
    end

    @current_player = @player_1

  end

#----------

  def play

    loop do

      @board.render
      @current_player.get_column

      break if check_game_over

      switch_players

    end
  end

#----------

  def check_game_over

    check_victory || check_tie

  end

#----------

  def check_victory

    if @board.winning_combo?(@current_player.piece)
      @board.render
      puts "#{@current_player.name} wins!"
      true
    else
      false
    end

  end

#----------

  def check_tie
    puts ".... "
    if @board.full?
      puts "It's a tie......"
      true
    else
      false
    end
  end

#----------

  def switch_players
    if @current_player == @player_1
      @current_player = @player_2
    else
      @current_player = @player_1
    end
  end

end

#----------



puts "'1' for single player."
puts "'2' for 2 players."
num_players = gets.chomp.to_i


p = ConnectFour.new(num_players)

p.play