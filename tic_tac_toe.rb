#!/usr/bin/env ruby
#create empty board (array)
board = Array.new(9)

def draw_board(board)
  puts "   |   |   "
	puts " " + (1..3).map{|i| board[i-1] || i}.join(" | ")
	puts "---|---|---"
	puts " " + (4..6).map{|i| board[i-1] || i}.join(" | ")
	puts "---|---|---"
	puts " " + (7..9).map{|i| board[i-1] || i}.join(" | ")
	puts "   |   |   "
end

def check_win(board, player)
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
	game_end = 0

	winning_combos.each do |w|
		if !board[w[0]].nil? && board[w[0]] == board[w[1]] && board[w[1]] == board[w[2]]
			puts "#{player[board[w[0]]]} wins!"
			game_end = 1
			break
		else
			game_end = 0
		end
	end
	
	if not board.include? nil
		puts "It's a tie."
		game_end = 1
	end

	game_end
end

#assign marker to human and computer players 
marker = {'human' => 'X', 'computer' => 'O'}
player = {marker['human'] => 'human', marker['computer'] => 'computer'}

#declare game_end variable and loop through game until game ends
game_end = 0
until game_end == 1 do
	#draw board
  draw_board(board)

	#ask human for move input
	puts "Select your position: "
	position = gets.chomp.to_i - 1

	#put move on board
	board[position] = marker['human']

	#check for win
	game_end = check_win(board, player)

	#computer move, put on board
	computer_move = 4
	while board.include? nil do
		if not board[computer_move].nil?
			computer_move = rand(9)
		else
			board[computer_move] = marker['computer']
			break
		end
	end

	#check for win
  game_end = check_win(board, player)
end

draw_board(board)