module BlusterBlox
	class Rectangle

		attr_accessor :x, :y, :width, :height

		def initialize x = 0, y = 0, width = 0, height = 0
			@x = x
			@y = y
			@width = width
			@height = height
		end

		def contains x, y

		end

		def scale factor
			@width *= factor
			@height *= factor
		end

		def clone
			Rectangle.new(@x, @y, @width, @height)	
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

		def draw_border game, color
			game.draw_line(left, top, color, right, top, color) # top
			game.draw_line(right, top, color, right, bottom, color) # right
			game.draw_line(left, bottom, color, right, bottom, color) # bottom
			game.draw_line(left, top, color, left, bottom + 1, color) # left
		end

		def draw game, color
			game.draw_quad(
				@x, @y, color,
				@x + @width, @y, color,
				@x + @width, @y + @height, color,
				@x, @y + @height, color
			)
		end
	end
end