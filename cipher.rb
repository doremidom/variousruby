def caesar_cipher(string, shift)
letters = ("A".."Z").to_a
string_ary = string.upcase.split('')
count = 0
	string_ary.each do |letter|
		index = letters.index(letter)
		index += shift
		if index > 26
			index -= 26
		end
		string_ary[count] = (letters[index])
		count += 1
 	end
puts string_ary.join('')
end

caesar_cipher("baby", 1)