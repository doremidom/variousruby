array = [8,4,5,6,12,20, 24, 1,3]

def sort(array)
	#return the array once there is only one element
	return array if array.length == 1
	#if there is more than one element, find the middle by dividing it in half
	middle = array.length / 2
	#create two arrays, one for each half, if it is odd, one more element will be in array 2
	array1 = array[0..(middle-1)]
	array2 = array[(middle..-1)]
	#call the method again, which will continue through the array until there is only one element in each
	merge(sort(array1), sort(array2))
end

def merge(array1, array2)
	merged = []
	puts "merging #{array1} and #{array2}"
	#loop terminates once both arrays are empty
	while array1.length >= 1 || array2.length >=1
		#if either array is empty, add the not empty one to the final result, as it is already sorted
		if array1.empty?
			merged.push(array2.shift)
		elsif array2.empty?
			merged.push(array1.shift)
		#else, compare first two elements of both arrays and push + remove the smaller one			
		elsif array1[0] <= array2[0]
			#puts "ar1 is smaller, pushing #{array1[0]}"
			merged.push(array1.shift)
			#puts "array1 is now #{array1.inspect}"
		else
			#puts "ar2 is smaller, pushing #{array2[0]}"
			merged.push(array2.shift)
			#puts "array2 is now #{array2.inspect}"
		end
	end
	puts "merged is now #{merged.inspect}"
	merged
end

sort(array)

