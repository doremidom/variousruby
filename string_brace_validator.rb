def validator(string)
	braces = get_braces(string)
	unmatched = []
	braces.each do |brace|
		#if the list of unmatched braces includes the open version of current brace:
		if unmatched.include?(open_brace(brace))
			#if the last open brace doesnt match with the closing brace, its false because its out of order, return
			if unmatched[-1] != open_brace(brace)
				puts unmatched.inspect
				puts "exception: #{unmatched[-1]} doesnt eql #{open_brace(brace)}"
				return false
			#else, find and remove the last instance of the open brace because it is now closed
			else
				puts unmatched.inspect
				unmatched.slice!(unmatched.rindex(open_brace(brace)))
			end
		#else, the brace is an open brace and needs to be pushed
		else
			puts unmatched.inspect
			unmatched.push(brace)
		end
	end
	puts braces.inspect
	#if unmatched is empty because all braces have their pairs, its true!
	return true if unmatched.empty? else false
end

def get_braces(string)
	braces = ['(', '{', '[', ']', '}', ')']
	string_braces = []
	string.each_char do |char|
		if braces.include?(char)
			string_braces.push(char)
		end
	end
	string_braces
end

def open_brace(brace)
	case brace
	when ')'
		'('
	when '}'
		'{'
	when ']'
		'['
	else
		'x'
	end
end

validator("({12)")
