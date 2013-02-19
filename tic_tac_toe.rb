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
    @level
  end

  def play
    select_level
    until terminal?(@board) do
      draw_board
      human_turn
      computer_turn unless terminal?(@board)
    end
    announce!
    draw_board
  end

  def select_level
    puts "Select difficulty level: easy / hard"
    @level = gets.chomp.downcase

    until @level == 'easy' || @level == 'hard'
      puts "Nope. Try again: "
      @level = gets.chomp.downcase
    end
  end

  def terminal?(state)
    if utility(state) == 1 || utility(state) == -1 || utility(state) == 0
      return true
    else
      return false
    end
  end

  def utility(state)
    if WINNING_COMBOS.find { |(x,y,z)| state[x] == 'X' && state[x] == state[y] && state[y] == state[z] }
      return 1
    elsif WINNING_COMBOS.find { |(x,y,z)| state[x] == 'O' && state[x] == state[y] && state[y] == state[z] }
      return -1
    elsif !state.include? nil
      return 0
    end
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
    @level == 'easy' ? computer_turn_easy : computer_turn_hard
  end

  def computer_turn_easy
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

  def computer_turn_hard
    minimax_decision
  end

  def minimax_decision
    v = min_value(@board)
    a = successors(@board, 'O').find { |(a, s)| max_value(s) == v }
    @board[a[0]] = 'O'
  end

  def successors(state, piece)
    board = state.dup
    successors = Array.new
    moves = (0..8).select { |n| n if board[n].nil? }
    moves.map do |n|
      board[n] = piece
      successors << [n, board.dup]
      board[n] = nil
    end
    successors
  end

  def max_value(state)
    if terminal?(state)
      return utility(state)
    else
      v = -999
      v = successors(state, 'X').map { |(a, s)| min_value(s) }.max
      return v
    end
  end

  def min_value(state)
    if terminal?(state)
      return utility(state)
    else
      v = 999
      v = successors(state, 'O').map { |(a, s)| max_value(s) }.min
      return v
    end
  end

  def announce!
    case utility(@board)
    when 1
      puts "X won!"
    when -1
      puts "O won!"
    else
      puts "It's a tie!"
    end
  end
end

TicTacToe.new.play