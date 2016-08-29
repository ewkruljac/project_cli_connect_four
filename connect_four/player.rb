class Player

  attr_accessor :name, :piece

#----------

  def initialize(name = "Player_1", piece, board)

    raise "Piece must be a Symbol!" unless piece.is_a?(Symbol)

    @name = name
    @piece = piece
    @board = board

  end

#----------

  def get_column

    loop do
      column = ask_for_column

      if validate_column_exists(column)

        if @board.add_piece(column, @piece)
          break
        end
      end
    end
  end

#----------

  def ask_for_column

    puts "#{@name}(#{@piece}), which column would you like to play?"
    gets.chomp.to_i - 1

  end

#----------

  def validate_column_exists(column)
    
    if column.is_a?(Integer) && column.between?(0, 6)
      true
    else
      puts "Your choice is out of range.  Choose a column '1-7'."
    end
  end

end