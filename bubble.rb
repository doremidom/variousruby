def bubble_sort(array)
	array.each_with_index do |number, index|
		y = 1
		i = 0
		while y < array.size && i < array.size
				if array[i] > array[y]
					puts "#{array[i]} (#{i}) > #{array[y]} (#{y})"
					array[i], array[y] = array[y], array[i] 
					puts "#{index}: #{array.inspect}"
				# else
					# y += 1
				end
				
				i += 1
				y += 1
		end
	end
	# puts array.inspect
end

bubble_sort([5, 1, 4, 2, 8])