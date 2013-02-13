#!/usr/bin/env ruby
#create empty board (array)
class TicTacToe
	def initialize
		@board ||= Array.new(9)
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
		winning_combos = [
			[0, 1, 2],
			[3, 4, 5],
			[6, 7, 8],
			[0, 3, 6],
			[1, 4, 7],
			[2, 5, 8],
			[0, 4, 8],
			[2, 4, 6]
		]

		winning_combos.each do |w|
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
		while @board[position] do 
			puts "Nope. Try again: "
			position = gets.chomp.to_i - 1
		end
		@board[position] = "X"
	end

	def computer_turn
		while @board.include? nil do
			computer_move = rand(9)
			if @board[computer_move].nil?
				@board[computer_move] = "O"
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

TicTacToe.new.play
