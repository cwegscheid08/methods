module Enumerable

	def my_each
		self.length.times { |i| yield(self[i]) }
		self
	end

	def my_each_with_index
		self.length.times { |i| yield(self[i], i) }
	end

	def my_select
		ary = []
		self.my_each { |i| yield(i) ? ary.push(i) : i }
		ary
	end

	def my_all?
		self.my_each do |i|
			case yield i 
				when false
					return false
			end
		end
		true
	end

	def my_any?
		# DO ANY MATCH A CERTAIN CRITERIA, RETURN TRUE OR FALSE
		self.my_each do |i|
			case yield i
				when true
					return true
			end
		end
		false
	end

	def my_none?
		# ARE NONE OF THESE MATCHING, RETURN TRUE OR FALSE
		((self.my_any? { |i| yield(i) == true }) == true) ? false : true 
	end

	def my_count
		# COUNT HOW MANY ARE ITEM ARE IN THE OBJECT
		self.my_each_with_index { |n, i| i + 1 }
	end

	def my_map(proc = nil)
		# RETURNS NEW ARRAY WITH EACH VALUE CHANGED
		if proc
			ary = []
			self.my_each { |x| ary.push(proc.call(x)) }
		else
			ary = []
			self.my_each { |x| ary.push(yield x) }
		end
		ary
	end

	def my_inject
		x = self.shift
		y = x
		self.my_each { |num| x = yield(x, num); x }
		self.unshift(y)
		x
	end
end 

def multiply_els(ary)
	ary.my_inject { |x,num|  x *= num }
end



ary = [3,2,6,1,4]

puts ""

# EACH
puts "EACH:"
puts ary.each { |x| x }
puts ""
puts ary.my_each { |x| x }
puts ""
puts ary.my_each { |x| x.to_s + "?"}
puts "\n\n"

# EACH_WITH_INDEX
puts "EACH_WITH_INDEX:"
ary.my_each_with_index { |num, i| print "#{num} is at #{i}.\n" }
puts ""
ary.each_with_index { |num, i| print "#{num} is at #{i}.\n" }
puts ""

# SELECT
puts "SELECT:"
print ary.my_select { |x| x%2 == 0 }
puts ""
print ary.select { |x|  x%2 == 0 }
puts ""
print ary.my_select { |x| x.even? }
puts "\n\n"

# ALL?
puts "ALL?:"
puts ary.all?(3)
puts ary.my_all? { |x| x == 3 }
puts ary.all? { |x| x > 0 }
puts ary.my_all? { |x| x > 0 }
puts ""	

# ANY?
puts "ANY?:"
puts ary.any?(3)
puts ary.my_any? { |x| x == 3 }
puts ary.any?("Hello")
puts ary.my_any? { |x| x == "Hello"}
puts""

# NONE?
puts "NONE?:"
puts ary.none?(0)
puts ary.my_none? { |x| x == 0 }
puts ary.my_none? { |x| x == 3 }
puts ""

# COUNT
puts "COUNT:"
puts ary.count
puts ary.my_count
puts "Hello there to".split("").count
puts "Hello there to".split("").my_count
puts ""

# MAP
puts "MAP:"
puts ary.map { |x| x.to_s + "!" }.to_s
puts ary.my_map { |x| x.to_s + "!" }.to_s
puts ""

# INJECT
puts "INJECT:"
puts ary.inject { |sum,x| sum += x }
puts ary.my_inject { |sum,x| sum += x }

puts ary.inject { |x,num| x -= num }
puts ary.my_inject { |x,num| x -= num  }

puts ary.inject { |x,num| x = num + 2}
puts ary.my_inject { |x,num| x = num + 2}

puts ary.my_inject { |x, num| x += num}
puts ''

# MULTIPLY_ELS
puts "MULTIPLY_ELS:"
puts multiply_els([2,4,5])
puts ''


# PROC'S
puts "PROC'S"
times_two = Proc.new { |x| x *= 2 }
times_three = Proc.new { |x| x *= 3}
add_soda = Proc.new { |x| "#{x} more sodas please." }

puts ary.to_s
puts ary.my_map(&times_two).to_s
puts ary.my_map(&times_three).to_s
puts ary.my_map(&add_soda)
# puts ary.my_map(&times_two) { |x| x *= 3 }




