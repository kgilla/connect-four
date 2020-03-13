require "./lib/connect_four"

describe GameBoard do
  
  describe "#make_board" do
    it "makes a new game board consisting of 7 arrays of size 6" do
      game = GameBoard.new
      expect(game.make_board).to eql([["_","_","_","_","_","_"], ["_","_","_","_","_","_"], ["_","_","_","_","_","_"], ["_","_","_","_","_","_"], ["_","_","_","_","_","_"], ["_","_","_","_","_","_"], ["_","_","_","_","_","_"]])
    end
  end

  describe "#insert_move" do
    it "Inserts a players move into the correct spot of the game board" do
      game = GameBoard.new
      expect(game.insert_move(1)).to eql("X")
    end
  end
end

describe Main do 

  describe "#player_turn" do
    xit "asks player for input and returns input as variable" do
      expect(player_turn)
    end
  end
end