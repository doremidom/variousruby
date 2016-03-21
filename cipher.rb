def caesar_cipher(string, shift)
letters = ("A".."Z").to_a
string_ary = string.upcase.split('')
count = 0
shift_count = 0
	string_ary.each do |letter|
		index = letters.index(letter)
		change_shift = shift[shift_count]
		index += change_shift
		if index > 26
			index -= 26
		end
		string_ary[count] = (letters[index])
		count += 1
		if shift_count < 7
			shift_count += 1
		else
			shift_count = 0
		end
 	end
puts string_ary.join('').reverse
end

caesar_cipher("NOFROMR", [1,2,0,7,1,9,2,8])