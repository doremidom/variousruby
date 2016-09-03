class VariousRuby

def caesar_cipher(string, shift)
letters = ("A".."Z").to_a
string_ary = string.upcase.split('')
result = []

	string_ary.each do |letter|
		index = letters.index(letter)
		index += shift
		if index > 26
			index -= 26
		end
		puts letters[index]
		result.push(letters[index])
 	end
puts result.join('')
end


end

