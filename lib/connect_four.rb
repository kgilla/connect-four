class GameBoard
  def initialize
    @board = make_board
    @p1_symbol = "☻"
    @p2_symbol = "☺"
    @turn = rand(1..2)
    @winning_combos = [[0,1],[0,2],[0,3]], [[1,0],[2,0],[3,0]], 
    [[1,1],[2,2],[3,3]], [[1,-1],[2,-2],[3,-3]]
  end

  def make_board
    board = []
    7.times { board << Array.new(6,"_") }
    board
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
    @board[col][row] = @p1_symbol if @turn == 1
    @board[col][row] = @p2_symbol if @turn == 2
  end

  def print_board
    puts "\n" + "*"*5 + "  Choose A Number  " + "*"*5
    puts "|~1~|~2~|~3~|~4~|~5~|~6~|~7~|"
    (5).downto(0).each do |j|
      print "\n|   |   |   |   |   |   |   |\n" 
      (0).upto(6).each do |i|
        print "|_#{@board[i][j]}_" if i < 6
        print "|_#{@board[i][j]}_|" if i == 6 
      end
    end
    puts "\n" + "#"*29 + "\n" + "#"*4 + " "*21 + "#"*4 
  end

  def scan_board
    @board.each_with_index do |col, col_i|
      col.each_with_index do |row, row_i|
        check_win(col_i,row_i, @p1_symbol) if row == @p1_symbol && @turn == 1 
        check_win(col_i,row_i, @p2_symbol) if row == @p2_symbol && @turn == 2
      end
    end
  end

  def check_win (x,y,symbol)
    @winning_combos.each do |combo|
      count = 0
      combo.each do |combo_cords|
        cord = x + combo_cords[0], y + combo_cords[1] 
        if cord[0] >= 0 && cord[0] < 7 && cord[1] >= 0 && cord[1] < 6
          count += 1 if @board[cord[0]][cord[1]] == symbol
          declare_winner if count == 3
        end
      end
    end
  end

  def declare_winner 
    puts "\n!!!!! WINNER! WINNER! WINNER! WINNER! !!!!!"
    puts "\nCongrats Player #{@turn}!", "\nWould you like to play again? (Y/N)"
    answer = gets.chomp.upcase
    new_game = Main.new if answer == "Y"
    exit
  end

  def change_turn
    return @turn == 1 ? @turn = 2 : @turn = 1
  end
end

class Main
  attr_accessor :game, :turn_count 
  
  def initialize 
    @game = GameBoard.new
    @turn_count = 0
    game_loop
  end

  def game_loop
    intro
    while @turn_count < 42
      game.get_move
      game.print_board
      game.scan_board
      game.change_turn
      @turn_count += 1
    end
    tie_game
  end

  def intro
    puts "\nNow Get ready to Connect Four!","\nLets decide who will go first..."
    sleep(1)
    game.print_board
  end

  def tie_game
    puts "Wow you both both lost...", "Want to play again? (Y/N)"
    answer = gets.chomp.upcase
    new_game = Main.new if answer == "Y"
    exit
  end
end

def header
  puts "☻"*80, "☺"*25 + "   C O N N E C T  F O U R !   " + "☺"*25, "☻"*80
  title_screen
end

def title_screen
  puts "\n1) Start a new game", "\n2) Exit"
  answer = gets.chomp.to_i
  new_game = Main.new if answer == 1
  exit
end

header