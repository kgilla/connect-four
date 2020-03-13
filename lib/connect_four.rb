class GameBoard
  attr_accessor :board, :player_one_turn
  attr_reader :winning_combos, :player_one_symbol, :player_two_symbol

  def initialize
    @board = make_board
    @p1_symbol = "X"
    @p2_symbol = "O"
    @turn = who_first
    @winning_combos = [[0,1],[0,2],[0,3]], [[1,0],[2,0],[3,0]], 
    [[1,1],[2,2],[3,3]], [[1,-1],[2,-2],[3,-3]]
  end

  def make_board
    board = []
    7.times { board << Array.new(6,"_") }
    board
  end

  def who_first
    first_turn = rand(1..2)
    return first_turn == 1 ? 1 : 2
  end 

  def get_move
    puts "\nPlayer #{@turn}!, choose a column from 1-7 to drop your piece"
    move = gets.chomp.to_i
    if move > 0 && move < 8 && @board[move - 1][5] == "_"
      insert_move(move)
    else
      puts "\nSorry that move is invalid, choose another"
      move = nil
      get_move
    end
  end

  def insert_move (move)
    col = move -= 1; row = 0
    until @board[col][row] == "_"
      row += 1
    end
    if @turn == 1
      @board[col][row] = @p1_symbol
    elsif @turn == 2
      @board[col][row] = @p2_symbol
    end
  end

  def print_board
    puts "\n" + "*"*10 + "Choose A Number!" + "*"*9
    puts "| 1 || 2 || 3 || 4 || 5 || 6 || 7 |"
    (5).downto(0).each do |j|
      puts 
      (0).upto(6).each do |i|
        print "|_#{@board[i][j]}_|" 
      end
    end
    puts "\n" + "#"*35 + "\n" + "#"*4 + " "*27 + "#"*4 
  end

  def scan_board
    @board.each_with_index do |col, col_i|
      col.each_with_index do |row, row_i|
        if @board[col_i][row_i] == @p1_symbol && @turn == 1 
          check_win(col_i,row_i, @p1_symbol)
        elsif @board[col_i][row_i] == @p2_symbol && @turn == 2
          check_win(col_i,row_i, @p2_symbol)
        end
      end
    end
  end

  def check_win (x,y,symbol)
    @winning_combos.each do |combo|
      count = 0
      combo.each do |xy|
        cord = x + xy[0], y + xy[1] 
        if cord[0] >= 0 && cord[0] < 7 && cord[1] >= 0 && cord[1] < 6
          if @board[cord[0]][cord[1]] == symbol
          count += 1
          declare_winner if count == 3
          end
        end
      end
    end
  end

  def declare_winner 
    puts "Congrats player #{@turn}!"
    puts "Would you like to play again? (Y/N)"
    answer = gets.chomp.upcase
    if answer == "Y"
      new_game = Main.new
    else
      puts "goodbye"
      exit
    end
  end

  def change_turn
    if @turn == 1
      @turn = 2
    else 
      @turn = 1
    end
  end
end

class Main
  attr_accessor :game

  def initialize 
    @game = GameBoard.new
    header
  end

  def game_loop
    intro
    turn = 0
    while turn < 42
      game.get_move
      game.print_board
      game.scan_board
      game.change_turn
    end
  end

  def header
    puts "$"*80
    puts "#"*25 + "   C O N N E C T  F O U R !   " + "#"*25
    puts "$"*80
    title_screen
  end

  def title_screen
    puts "\n1) Start a new game"
    puts "\n2) Info"
    puts "\n3) Exit"
    answer = gets.chomp.to_i
    if answer == 1
      game_loop
    else 
      exit
    end
  end
  
  def intro
    puts "\nWelcome to Connect Four!"
    puts "\ndecide who should be player one and who will be player two"
    sleep(1)
    puts "Okay lets decide who will go first..."
    sleep(1)
  end
end

new_game = Main.new


  