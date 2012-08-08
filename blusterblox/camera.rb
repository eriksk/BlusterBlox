module BlusterBlox
	class Camera

		attr_accessor :pos, :origin

		def initialize game, boundary_rectangle = nil
		    @game = game
		    @area = boundary_rectangle
		    @pos = Vec2.new
		    @origin = Vec2.new($WIDTH / 2, $HEIGHT / 2)
		    @destination = Vec2.new
		    @speed = 0.1
		end

		def move x, y
		    @destination.x, @destination.y = x - @origin.x, y - @origin.y
		    @pos.x = BlusterBlox::lerp(@pos.x, @destination.x, @speed)
		    @pos.y = BlusterBlox::lerp(@pos.y, @destination.y, @speed)
		end

		def set_position x, y
		    @pos.x, @pos.y = x, y
		end

		def move_by x, y
			@destination.x += x
			@destination.y += y
		end

		def update dt
		    @pos.x = BlusterBlox::lerp(@pos.x, @destination.x, @speed)
		    @pos.y = BlusterBlox::lerp(@pos.y, @destination.y, @speed)	
		    if @area
		    	if @pos.x < @area.left
		    		@pos.x = @area.left
		    		@destination.x = @pos.x
		    	end
		    	if @pos.y < @area.top
		    		@pos.y = @area.top
		    		@destination.y = @pos.y
		    	end

		    	if @pos.x + @origin.x * 2 > @area.right
		    		@pos.x = @area.right - @origin.x * 2
		    		@destination.x = @pos.x
		    	end
		    	if @pos.y + @origin.y * 2 > @area.bottom
		    		@pos.y = @area.bottom - @origin.y * 2
		    		@destination.y = @pos.y
		    	end
			end
		end

		def translate(&block)
		    # ignore sub-pixel positioning, only integers
		    @game.translate(-@pos.x.to_i, -@pos.y.to_i) do
		            block.call()
		    end
		end
	end
end