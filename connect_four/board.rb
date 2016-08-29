class Board

attr_reader :board

  def initialize

    @board = Array.new(6){ Array.new(7) }
    @available_cells = [5, 5, 5, 5, 5, 5, 5]

  end

#----------

  def render

    puts
      @board.each do |row|
        row.each do |cell|
          cell.nil? ? print(" - ") : print(" #{cell.to_s} ")
        end
        puts
      end
      puts

  end

#----------

  def add_piece(column, piece)

    if piece_location_valid?(column)
      @board[@available_cells[column]][column] = piece
      update_cell_status(column)
      true
    else
      false
    end

  end

#----------

  def piece_location_valid?(column)

    if within_valid_columns?(column)
      column_full?(column)
    end

  end

#----------

  def within_valid_columns?(column)

    if column.between?(0, 7)
      true
    else
      puts "Your piece cannot go there."
    end

  end

#----------

  def column_full?(column)

    if @available_cells[column] >= 0
      true
    else
      puts "That column is full."
    end

  end

#----------

  def update_cell_status(column)

    @available_cells[column] -= 1

  end

#----------

  def full?

    @board.all? do |row|
      row.none?{ |cell| cell.nil? }
    end

  end

#----------

  def winning_combo?(piece)

    check_horizontal(piece) ||
    check_vertical(piece) ||
    check_top_to_bottom_diagonal(piece) ||
    check_bottom_to_top_diagonal(piece)

  end

#----------

  def check_horizontal(piece)

    winner = false
    score = 0

    for x in 0..5
      score = 0
      for y in 0..6
        if @board[x][y] == piece
          score += 1 
          winner = true if score == 4
        else
          score = 0
        end
      end
    end

    winner
  end

#----------

  def check_vertical(piece)

    winner = false

    score = 0


    for x in 0..6
      score = 0
      for y in 0..5
        if @board[y][x] == piece
          score += 1 
          winner = true if score == 4
        else
          score = 0
        end
      end
    end

    winner
  end

#----------

  def check_top_to_bottom_diagonal(piece)

    winner = false
   
    for i in 0..2 do
      for j in 0..3 do
        winner = true if @board[i][j] == piece && @board[i+1][j+1] == piece && @board[i+2][j+2] == piece && @board[i+3][j+3] == piece
      end
    end

    winner

  end

#----------

  def check_bottom_to_top_diagonal(piece)

    winner = false

    5.downto(3) do |i|
      for j in 0..3 do
        winner = true if @board[i][j] == piece && @board[i-1][j+1] == piece && @board[i-2][j+2] == piece && @board[i-3][j+3] == piece
      end
    end

    winner

  end

#----------
=begin
  def defense_horizontal(player1_piece)

    puts @board.class

    block = 9

    for x in 0..5
      score = 0
      for y in 0..6
        if @board[x][y] == player1_piece
          score += 1 
          block = x-1 if score == 3
        else
          score = 0
        end
      end
    end

    puts "Block: #{block}"
    block
  end
=end
#----------

end