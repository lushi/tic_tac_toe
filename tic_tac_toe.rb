#!/usr/bin/env ruby
#create empty board (array)
board = Array.new(9)

def draw_board(board)
  puts "   |   |   "
	puts " " + (1..3).to_a.map {|i| board[i-1].nil? ? i : board[i-1]}.join(" | ")
	puts "---|---|---"
	puts " " + (4..6).to_a.map {|i| board[i-1].nil? ? i : board[i-1]}.join(" | ")
	puts "---|---|---"
	puts " " + (7..9).to_a.map {|i| board[i-1].nil? ? i : board[i-1]}.join(" | ")
	puts "   |   |   "
end

def check_win(board, player)
	if !board[0].nil? && board[0] == board[1] && board[1] == board[2] 
		puts "#{player[board[0]]} wins!"
		game_end = 1
	elsif !board[3].nil? && board[3] == board[4] && board[4] == board[5]
		puts "#{player[board[3]]} wins!"
		game_end = 1
	elsif !board[6].nil? && board[6] == board[7] && board[7] == board[8]
		puts "#{player[board[6]]} wins!"
		game_end = 1
	elsif !board[0].nil? && board[0] == board[3] && board[3] == board[6]
		puts "#{player[board[0]]} wins!"	
		game_end = 1
	elsif !board[1].nil? && board[1] == board[4] && board[4] == board[7]
		puts "#{player[board[1]]} wins!"	
		game_end = 1
	elsif !board[2].nil? && board[2] == board[5] && board[5] == board[8]
		puts "#{player[board[2]]} wins!"	
		game_end = 1
	elsif not board.include? nil
		puts "It's a tie."
		game_end = 1
	else
		game_end = 0
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

