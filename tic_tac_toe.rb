#!/usr/bin/env ruby

class Board
  def play
    while unfinished? do
      draw
      human_turn
      computer_turn if state.nil?
    end
    draw
    announce!
  end

  private
  def board
    @board ||= Array.new(9)
  end

  def unfinished?
    state.nil?
  end

  def draw
    puts "   |   |   "
    puts " " + (1..3).map {|i| board[i-1] || i}.join(" | ")
    puts "---|---|---"
    puts " " + (4..6).map {|i| board[i-1] || i}.join(" | ")
    puts "---|---|---"
    puts " " + (7..9).map {|i| board[i-1] || i}.join(" | ")
    puts "   |   |   "
  end

  # This is gross, right?
  # nil (unfished) | "tie" | ["win", who]
  def state
    s = nil
    if !board[0].nil? &&    board[0] == board[1] && board[0] == board[2] 
      s = ["win", board[0]]
    elsif !board[0].nil? && board[0] == board[4] && board[0] == board[8] 
      s = ["win", board[0]]
    elsif !board[0].nil? && board[0] == board[3] && board[0] == board[6]
      s = ["win", board[0]]
    elsif !board[3].nil? && board[3] == board[4] && board[3] == board[5]
      s = ["win", board[3]]
    elsif !board[6].nil? && board[6] == board[7] && board[6] == board[8]
      s = ["win", board[6]]
    elsif !board[6].nil? && board[6] == board[4] && board[6] == board[2]
      s = ["win", board[6]]
    elsif !board[1].nil? && board[1] == board[4] && board[1] == board[7]
      s = ["win", board[1]]
    elsif !board[2].nil? && board[2] == board[5] && board[5] == board[8]
      s = ["win", board[2]]
    elsif not board.include? nil
      s = "tie"
    end
    s
  end

  def human_turn
      puts "Select your position: "
      position = gets.chomp.to_i - 1
      while board[position] do
        puts "Nope. Try again: "
        position = gets.chomp.to_i - 1
      end
      board[position] = "X"
  end

  def computer_turn
    while board.include? nil do
      computer_move = rand(9)
      if board[computer_move]
        computer_move = rand(9)
      else
        board[computer_move] = "O"
        break
      end
    end
  end

  def announce!
    if state == "tie"
      puts "You tied!"
    else
      puts "#{state[1]} won!"
    end
  end
end

Board.new.play
