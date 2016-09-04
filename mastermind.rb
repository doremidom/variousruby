class Mastermind
	def initialize
		@colors = ['r','g','y','b','o','v'] 
		puts "starting mastermind"	
		@game_over = false
		puts "press 1 to create a code, press 2 to guess"
		answer = gets.chomp
		if answer == '1'
			puts "enter a 4 digit code that contains r,g,y,b,o, or v."
			@code = gets.chomp.split('')
			computer_guess
		elsif answer == '2'
			@code = code_generator
			play
		end
	end


	def code_generator(colors=@colors)		
		code = []
		4.times do |x|
			random = rand(5)
			code.push(colors[random])
		end
		code
	end

	def play
		until @game_over
			guess
		end
	end

	def guess
		puts "Enter a guess for a code"
		guess = gets.chomp.split('')
		feedback = check_guess(guess)
	end

	def computer_guess(guess_code = code_generator, known ={}, close =[], wrong=[])
		puts "guessing #{guess_code}"

		if guess_code == @code
			@game_over = true
			puts "Computer won! It guessed #{guess_code}"
		else

			guess_code.each_with_index do |color, index|
				diagnosis = feedback(color,index)
				if diagnosis == "match"
					puts "found a match"
					if known[color]
						known[color].push(index)
					else
						known[color] = [index]
					end
				elsif diagnosis == "partial match"
					puts "found a partial match"
					close.push(color)
				else
					puts "color not found, removing from possibilities"
					wrong.push(color)
				end
			end
			puts "trying new guess"
			computer_new_guess(known, close, wrong)
		end
	end
	

	def computer_new_guess(known={}, close=[], wrong=[])
		new_colors = @colors
		wrong.each do |color|
			if new_colors.include?(color)
				new_colors.delete(color)
				puts "deleted #{color}"
			end
		end 

		new_guess = []

		if !close.empty?
			"partial matches present"
			until new_guess.include?(close[0])
				new_guess = code_generator(new_colors)
			end
			close.shift
		else
			puts "making a new code"
			4.times do |y|
				random = rand(0..(new_colors.length-1))
				new_guess.push(new_colors[random])
			end
		end

		unless known.empty?
			known.each_pair do |color, pos| 
				pos.each do |ind|
					new_guess[ind] = color
				end
			end
		end

		puts "new guess is #{new_guess}"
		computer_guess(new_guess, known, close, wrong)
	end

	def check_guess(guess)
		if guess == @code
			@game_over = true
			puts "You won!"
		else 
			guess.each_with_index do |color, index|
				response = feedback(color,index)
				hint(response)
			end
		end
	end

	def feedback(color, index)
		if @code.include?(color)
			if color == @code[index]
				"match"					
			else
				"partial match"
			end
		else
			"not found"
		end
	end

	def hint(guess_response)
		if guess_response == "match"
			puts "This color is in the right position."
		elsif guess_response == "partial match"
			puts "This color is in the wrong position."
		else
			puts "This color was not found in the code."
		end
	end


end

game = Mastermind.new
game
