#functionality to add:
#checkmate/gameover rules
#checking for pieces in the path of a moving piece
	#get coordinates of start and end position, 
	#iterate through each possible coordinate between them and see if occupied using existing 
	#method
	#in move valid you can make variable declaration on one line

class Chess

	def initialize
		@unicodes = unicode_hash
		@game_over = false
		@game = []

		puts "enter 1 for new game or 2 to load game"
		answer = gets.chomp
		if answer == "1"
			puts "Starting new game of chess. Rows are a-h, columns 1-8."
			@game = new_game
			puts "Enter player one's name (white):"
			@white_player = gets.chomp
			puts "Enter player two's name (black):"
			@black_player = gets.chomp
			board_visualizer
			lets_play
		else
			puts "enter file name (it must be in the same directory as this game)"
			file = gets.chomp
			load(file)
		end
	end

	def lets_play(starter = nil)
		until @game_over
			if starter == "black"
				puts "your move, #{@black_player}. enter piece's location and desired move (ie a2 to b2)"
				user_input = gets.chomp.split(' ')
				if user_input[0] == "save"
					save("black")
				else
					piece = user_input[0]
					location = user_input[2]
					move("black", piece, location)
				end
				puts "your move, #{@white_player}. enter piece's location and desired move (ie a2 to b2)"
				user_input = gets.chomp.split(' ')
				if user_input[0] == "save"
					save("white")				
				else
					piece = user_input[0]
					location = user_input[2]
					move("white", piece, location)
				end
			else

				puts "your move, #{@white_player}. enter piece's location and desired move (ie a2 to b2)"
				user_input = gets.chomp.split(' ')
				if user_input[0] == "save"
					save("white")				
				else
					piece = user_input[0]
					location = user_input[2]
					move("white", piece, location)
				end
				puts "your move, #{@black_player}. enter piece's location and desired move (ie a2 to b2)"
				user_input = gets.chomp.split(' ')
				if user_input[0] == "save"
					save("black")
				else
					piece = user_input[0]
					location = user_input[2]
					move("black", piece, location)
				end
			end
		end
	end

	def board_visualizer
		letters = *('A'..'H')
		@game.each_with_index do |row,index|
			row.each do |square|
				square.strip! if square.is_a?(String)
				print @unicodes[square] + "    "
			end
			print letters[index]
			puts " "
		end
		numbers = *(1..8)
		numbers.each do |number|
			print number.to_s + "    "
		end

	end

	def new_game
		#creates new board
		board = []

		board.push(['wr1','wk1','wbi1','wq','wki','wbi2','wk2','wr2'])
		board.push(['wp','wp','wp','wp','wp','wp','wp','wp'])

		2.times do |x|
			row1 = []
			row2 = []
			4.times do |x|
				row1.push(0)
				row1.push(1)
			end
			4.times do |x|
				row2.push(1)
				row2.push(0)
			end
			board.push(row1)
			board.push(row2)
		end

		board.push(['bp','bp','bp','bp','bp','bp','bp','bp'])
		board.push(['br1','bk1','bbi1','bq','bki','bbi2','bk2','br2'])		
	end

	def save(player)
		save_file = File.new("game.txt", "w")
		save_file.puts(player)
		save_file.puts(@white_player)
		save_file.puts(@black_player)
		@game.each do |row|
			row = row.join(',')
			save_file.print(row)
			save_file.puts ""
		end

		save_file.close

	end

	def load(file)
		puts "loading file"
		File.open(file, "r") do |f|
			f.each_line do |line|
				row = line.split(',')
				@game.push(row)
			end
		end
		starting_player = @game.shift.join.strip

		@white_player = @game.shift.join.strip
		@black_player = @game.shift.join.strip 

		board_visualizer
		lets_play(starting_player)

	end

	def unicode_hash
		white = ["\u2656", "\u2658", "\u2657", "\u2654", "\u2655",  "\u2657", "\u2658", "\u2656",]
		name = ['wr1','wk1','wbi1','wq','wki','wbi2','wk2','wr2']

		black = ["\u265C", "\u265E", "\u265D", "\u265A", "\u265B", "\u265D",  "\u265E", "\u265C"]
		bnames = ['br1','bk1','bbi1','bq','bki','bbi2','bk2','br2']

		yo = {"wp" => "\u2659", "bp" => "\u265F", 0 => "\u25FD", 1 => "\u25FE", '0' => "\u25FD", '1' => "\u25FE"}


		name.each_with_index do |name, index|
			yo[name] = white[index]
		end

		bnames.each_with_index do |name, index|
			yo[name] = black[index]
		end

		yo
	end


	def move(player, location_start, location_end)
		
		start_location_row = move_to_array(location_start)[0]
		start_location_col = move_to_array(location_start)[1]
			
		end_location_row = move_to_array(location_end)[0]
		end_location_col = move_to_array(location_end)[1]

		piece = @game[start_location_row][start_location_col]

		if piece.class == Fixnum
			puts "invalid move, please try again"
			reprompt(player)		
		end

		if move_valid?(player, piece, location_start, location_end)	
			if occupied?(end_location_row, end_location_col)
				puts "occupied"
				if other_team?(player, @game[end_location_row][end_location_col])
					puts "you captured a piece"	
				else
					puts "invalid move (occupied by your piece)"
					reprompt(player)
				end	
			end
			@game[start_location_row][start_location_col] = square_color(start_location_row, start_location_col)
			@game[end_location_row][end_location_col] = piece
			board_visualizer
		else
			puts "invalid move, piece doesn't work that way"
			reprompt(player)
		end



		

	end

	def square_color(row, col)
		if row%2 == 0
			if col%2 == 0
				0
			else
				1
			end
		else
			if col%2 == 0
				1
			else
				0
			end
		end
	end

	def move_valid?(player, piece, location_start, location_end)
		start_location_row = move_to_array(location_start)[0]
		start_location_col = move_to_array(location_start)[1]
		
		end_location_row = move_to_array(location_end)[0]
		end_location_col = move_to_array(location_end)[1]

		puts "piece is #{piece}"
		puts "player is #{player}"

		path_clear?(location_start, location_end)

		if other_team?(player, piece)
			puts "this isn't your piece, try again"
			return reprompt(player)
		end
		
		if piece.include?("p")
			puts "pawn!"
		 	if (start_location_row == 1) or (start_location_row == 6)
		 		puts "first move"
		 		if (end_location_row - start_location_row) <= 2 && (start_location_col == end_location_col)
					true
				else
					false
				end
			elsif ((end_location_row - start_location_row).abs == 1) && (start_location_col == end_location_col)
				true
			else
				false
			end
		elsif piece.include?("bi")
			puts "bishop!"
			puts "testing (#{end_location_row} - #{start_location_row}) and (#{end_location_col}-#{start_location_col}"
			if (end_location_row-start_location_row).abs == (end_location_col-start_location_col).abs
				true
			else
				false
			end
		elsif piece.include?("ki")
			puts "king!"
			if ((end_location_row-start_location_row).abs <= 1) && ((end_location_col-start_location_col).abs <= 1)
				true
			else
				false
			end	
		elsif piece.include?("k")
			puts "knight!"
			#puts "testing (#{end_location_row} - #{start_location_row}) and (#{end_location_col}-#{start_location_col}"
			#puts (end_location_row-start_location_row).abs
			#puts (end_location_col-start_location_col).abs
			if ((end_location_row-start_location_row).abs == 2) && ((end_location_col-start_location_col).abs == 1)
				true
			elsif ((end_location_row-start_location_row).abs == 1) && ((end_location_col-start_location_col).abs == 2)
				true
			else
				puts "nope"
				false
			end
		elsif piece.include?("r")
			puts "rook!"
			if (end_location_row-start_location_row == 0) || (end_location_col-start_location_col == 0)
				true 
			else	
				false
			end	 
		elsif piece.include?("q")
			puts "queen!"
			if (end_location_row-start_location_row == 0) || (end_location_col-start_location_col == 0)
				true 
			elsif (end_location_row-start_location_row).abs == (end_location_col-start_location_col).abs
				true
			else
				false
			end
		end
	end

	def move_to_array(move)
		row_letter = *('a'..'h')
		move = move.split('')
		row = move[0]
		col = move[1].to_i
		result = [row_letter.index(row), (col - 1)]
		result
	end

	def occupied?(row, col)
		if @game[row][col].to_i != 0 && @game[row][col].to_i != 1
			puts "this is square's value #{@game[row][col]}"
			true
		else
			false
		end
	end

	def path_clear?(location_start, location_end)
		start_row, start_col = move_to_array(location_start)
		end_row, end_col = move_to_array(location_end)

		puts "#{start_row} is this"
		puts "#{start_col} is this"

		row_span = start_row-end_row
		col_span = start_col-end_col

		if row_span >= 1
			for x in 1..row_span
				if @game[start_row - x][start_col].is_a?(String) && @game[start_row - x][start_col].strip.length > 1
					puts "found piece: #{@game[start_row - x][start_col]}"
				end
			end
		elsif row_span 
		end

	end
 
	def other_team?(player, piece)
		#puts "piece is #{piece}"
		if player == "white"
			if !piece.include?('w')
				return true
			end
		else
			return true if piece.include?('w')
		end
		false
	end

	def reprompt(player)
		puts "enter piece's location and desired move (ie a2 to b2)"

		user_input = gets.chomp.split(' ')
		piece = user_input[0]
		location = user_input[2]

		move(player, piece, location)
	end

end


game = Chess.new


