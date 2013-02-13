#!/usr/bin/env ruby

class TicTacToe
  def initialize
    @board ||= Array.new(9)
    @winning_combos = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6]
    ]
    @computer_move = nil
  end

  def play
    while unfinished? do
      draw_board
      human_turn
      computer_turn if state.nil?
    end
    draw_board
    announce!
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
    s = nil

    @winning_combos.each do |w|
      if !@board[w[0]].nil? && @board[w[0]] == @board[w[1]] && @board[w[1]] == @board[w[2]]
        s = ["win", @board[w[0]]]
        break
      end
    end
    
    if not @board.include? nil
      s = "tie"
    end
    s
  end

  def human_turn
    puts "Select your position: "
    position = gets.chomp.to_i - 1
    while position < 0 || position > 8 || !@board[position].nil? do
      puts "Nope. Try again: "
      position = gets.chomp.to_i - 1
    end
    @board[position] = "X"
  end

  def computer_turn
    strategic_check("O", 2)
    strategic_check("X", 2) if @computer_move.nil?
    strategic_check("O", 1) if @computer_move.nil?

    corner_center_check if @computer_move.nil?
    
    if @computer_move.nil?
      @computer_move = rand(9) 
      until @board[@computer_move].nil? do
        @computer_move = rand(9)
      end
    end

    @board[@computer_move] = "O"
    @computer_move = nil  
  end

  def strategic_check(piece, frequency)
    @winning_combos.each do |w|
        if w.select {|n| @board[n] == piece}.length == frequency
          w.each { |n| @computer_move = n if @board[n].nil? }
        end
      end
    @computer_move
  end

  def corner_center_check #corner spaces + center: [0, 2, 4, 6, 8]
    [4, 0, 2, 6, 8].each do |n| 
      if @board[n].nil? 
        @computer_move = n
        break
      end
    end
    @computer_move
  end

  def announce!
    if state == "tie"
      puts "You tied!"
    else
      puts "#{state[1]} won!"
    end
  end
end

TicTacToe.new.play