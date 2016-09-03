class StringCalculator

	def add(*numbers)
		sum = 0
		return sum if numbers.empty?
		return numbers if numbers.length == 1
		numbers.each {|x| sum += x}
		sum
	end

end