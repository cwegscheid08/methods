module Enumerable
	def my_each
		self.length.times do |x|
			yield self[x]
		end
	end
end 


array = (1..10).to_a
array = [3,2,6,1,4]
# print array, "\n"
# array.my_each
print array.my_each { |x| puts x += 1}