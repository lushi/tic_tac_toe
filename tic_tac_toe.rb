#!/usr/bin/env ruby
class TicTacToe
  WINNING_COMBOS = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6]
    ]
  def initialize
    @board = Array.new(9)
  end

  def play
    while unfinished? do
      draw_board
      human_turn
      computer_turn if state.nil?
    end
    announce!
    draw_board
  end

  def unfinished?
    state.nil?
  end

  def draw_board
    puts "   |   |   "
    puts " " + (1..3).map{|i| @board[i-1] || i}.join(" | ")
    puts "---|---|---"
    puts " " + (4..6).map{|i| @board[i-1] || i}.join(" | ")
    puts "---|---|---"
    puts " " + (7..9).map{|i| @board[i-1] || i}.join(" | ")
    puts "   |   |   "
  end

  def state
    s = WINNING_COMBOS.find { |(x,y,z)| @board[x] && @board[x] == @board[y] && @board[y] == @board[z] }
    s || ("tie" if !@board.include? nil)
  end

  def human_turn
    puts "Select your position: "
    position = gets.chomp.to_i - 1
    while position < 0 || position > 8 || @board[position] do
      puts "Nope. Try again: "
      position = gets.chomp.to_i - 1
    end
    @board[position] = "X"
  end

  def computer_turn
    computer_move = strategic_check("O", 2, computer_move) ||
      strategic_check("X", 2, computer_move) ||
      strategic_check("O", 1, computer_move) ||
      corner_center_check(computer_move)

    until computer_move && @board[computer_move].nil?
      computer_move = rand(9)
    end

    @board[computer_move] = "O"
  end

  def strategic_check(piece, frequency, computer_move)
    WINNING_COMBOS.each do |w|
      if w.find { |n| @board[n].nil? } && w.select { |n| @board[n] == piece }.length == frequency
        computer_move = w.find { |n| @board[n].nil? }
      end
    end
    computer_move
  end

  def corner_center_check(computer_move) #corner spaces + center: [0, 2, 4, 6, 8]
    computer_move = [0, 2, 4, 6, 8].find { |n| @board[n].nil? }
  end

  def announce!
    if state == "tie"
      puts "You tied!"
    else
      puts "#{@board[state[0]]} won!"
    end
  end
end

TicTacToe.new.play