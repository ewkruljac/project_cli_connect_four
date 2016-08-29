#require "./board"

class AI

  attr_accessor :name, :piece

  def initialize(name = "Dumb AI", piece, board, player_1)

    raise "Piece must be a Symbol!" unless piece.is_a?(Symbol)

    @name = name
    @piece = piece
    @board = board
    @player_1 = player_1

  end

#----------

  def get_column

    r = rand(0..6)
    ftw_horz = 8
    ftw_vert = 8
    block_vert = 8
    block_horz = 8
    ftw_tb_diag = 8
    ftw_bt_diag = 8

    until @board.piece_location_valid?(r)
      r = rand(0..6)
    end

    #ftw_horz = horizontal_win(@piece)
    #ftw_tb_diag = top_to_bottom_diagonal_win(@piece)
    #ftw_bt_diag = bottom_to_top_diagonal_win(@piece)

    #block_horz = defense_horizontal(@player_1.piece)


    #r = block_horz if block_horz < 7
    #r = ftw_horz if ftw_horz < 7 && ftw_horz >= 0
    #r = ftw_tb_diag if ftw_tb_diag < 7 && ftw_tb_diag >= 0
    #r = ftw_bt_diag if ftw_bt_diag < 7 && ftw_bt_diag >=0

    @board.add_piece(r, @piece)

    #ftw_vert = vertical_win(@piece)
    #block_vert = defense_vertical(@player_1.piece)
    #r = block_vert if block_vert < 7 && block_vert >= 0
    #r = ftw_vert if ftw_vert < 7 && ftw_vert >= 0

  end

#----------

  def defense_horizontal(player1_piece)

    block = 8

    for x in 0..5
      score = 0
      for y in 0..6
        if @board.board[x][y] == player1_piece
          score += 1
          block = y+1 if score == 1 && @board.board[x][y+2] == player1_piece && @board.board[x][y+3] == player1_piece && @board.board[x][y+1].nil?
          block = y+1 if score == 2 && @board.board[x][y+2] == player1_piece && @board.board[x][y+1].nil?
          block = y+1 if score == 3 && @board.board[x][y+1].nil?
        else
          score = 0
        end
      end
    end

    block
  end

#----------

  def defense_vertical(player1_piece)

    block = 9

    for x in 0..6
      score = 0
      for y in 0..5
        if @board.board[y][x] == player1_piece
          score += 1
        else
          score = 0
        end
      end
    end

    block
  end

#----------

  def horizontal_win(piece)
    ftw = 8

    for x in 0..5
      score = 0
      for y in 0..6
        if @board.board[x][y] == piece
          score += 1
          ftw = y+1 if score == 1 && @board.board[x][y+2] == @piece && @board.board[x][y+3] == @piece
          ftw = y+1 if score == 2 && @board.board[x][y+2] == @piece
          ftw = y+1 if score == 3
        else
          score = 0
        end
      end
      puts "Going FTHW at column #{ftw}" if ftw < 7
    end

    ftw
  end

#----------

  def vertical_win(piece)

    ftw = 8

    for x in 0..6
      score = 0
      for y in 0..5
        if @board.board[y][x] == piece
          score += 1
          ftw = x if score == 3
        else
          score = 0
        end
      end
      puts "Going FTVW at column #{ftw}" if score == 3 if ftw < 7
    end

    ftw
  end

#----------
  
  def top_to_bottom_diagonal_win(piece)

    ftw = 8

    for i in 0..2 do
      for j in 0..3 do
        ftw = j+3 if @board.board[i][j] == piece && @board.board[i+1][j+1] == piece && @board.board[i+2][j+2] == piece
        ftw = j+2 if @board.board[i][j] == piece && @board.board[i+1][j+1] == piece && @board.board[i+3][j+3] == piece
        ftw = j+1 if @board.board[i][j] == piece && @board.board[i+2][j+2] == piece && @board.board[i+3][j+3] == piece
        ftw = j if @board.board[i+1][j+1] == piece && @board.board[i+2][j+2] == piece && @board.board[i+3][j+3] == piece
      end
    end

    ftw
  end

#----------

  def bottom_to_top_diagonal_win(piece)

    ftw = 8

    5.downto(3) do |i|
      for j in 0..3 do
        ftw = j+3 if @board.board[i][j] == piece && @board.board[i-1][j+1] == piece && @board.board[i-2][j+2] == piece
        ftw = j+2 if @board.board[i][j] == piece && @board.board[i-1][j+1] == piece && @board.board[i-3][j+3] == piece
        ftw = j+1 if @board.board[i][j] == piece && @board.board[i-2][j+2] == piece && @board.board[i-3][j+3] == piece
        ftw = j if @board.board[i-1][j+1] == piece && @board.board[i-2][j+2] == piece && @board.board[i-3][j+3] == piece
      end
    end

  end


end