module BlusterBlox
	class Rectangle

		attr_accessor x:, :y, :width, :height

		def initialize x = 0, y = 0, width = 0, height = 0
			@x = x
			@y = y
			@width = width
			@height = height
		end

		def contains x, y

		end

		def left
			@x
		end

		def right
			@x + @width
		end

		def top
			@y
		end

		def bottom
			@y + @height
		end
	end
end