class LinkedList
	attr_accessor :head
	
	def append(node)
		if @head.nil?
			puts "no head found"
			@head = node
		else
			current = @head
			while current.next_node
				current = current.next_node
			end
			current.next_node = node
		end
	end

	def prepend(node)
		if @head.nil?
			@head = node
		else
			puts "found a head"
			old_head = @head
			node.next_node = old_head
			@head = node
		end
	end

	def size
		if @head.nil?
			return puts '0'
		end
		size = 1
		entry = @head
		while entry.next_node
			size += 1
			entry = entry.next_node
		end
		size 
	end

	def display
		puts @head.data
	end
	
	def head
		puts @head.data unless @head.nil?
	end
	
	def tail
		current = @head
		while current.next_node
			current = current.next_node
		end
		puts current.data
	end
	
	def at(index)
		current = @head
		if index == 0
			puts @head.data
		else
			index.times do |x|
				current = current.next_node
			end
			puts current.data
		end
	end
	
	def pop
		listsize = (size - 2)
		current = @head
		listsize.times do |x|
			current = current.next_node
		end
			current.next_node = nil
	end
	
	def contains?(x)
		current = @head
		while current.next_node
			return true if current.data == x
			current = current.next_node
		end
		false
	end
	
	def find(y)
		current = @head
		index = 0
		while current.next_node
			return index if current.data == y
			index += 1
			current = current.next_node
		end
		if current.data = y 
			index
		else
			nil
		end
	end

	def to_s
		current = @head
		while current.next_node 
			print "(#{current.data}) -> "
			current = current.next_node
		end
		print "(#{current.data}) -> nil"

	end
	
end

class Node
	attr_accessor :data, :next_node
end


b = Node.new
b.data = 4
c = Node.new
c.data = 5
a.append(c)
a.prepend(b)
a.size