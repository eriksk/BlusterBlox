module BlusterBlox
	class TileMap

		attr_accessor :textures

		def initialize textures, seed = 0, width = 64, height = 64
			@textures = textures
			@tile_width = textures.first.width
			@tile_height = textures.first.height
			@data = []
			@width = width
			@height = height
			populate
		end

		def clear
			@width.times do |x|
				@height.times do |y|
					@data[x + y * @width] = 0
				end
			end			
		end

		def populate
			@width.times do |x|
				@height.times do |y|
					@data.push((rand() * 3).to_i)
				end
			end
		end

		def get_cell col, row
			@data[col + row * @width]
		end

		def has_neighbour(col, row)
			if @data[(col - 1) + row * @width] != 0 # left
				true
			elsif @data[(col + 1) + row * @width] != 0 # right
				true
			elsif @data[col + (row - 1) * @width] != 0 # up
				true
			elsif @data[col + (row + 1) * @width] != 0 # down
				true
			else
				false
			end					
		end

		def has_roof(col, row)
			@data[col + (row - 1) * @width] != 0
		end

		def set_cell_raw col, row, cell
			@data[col + row * @width] = cell
		end

		# returns true if cell changed value
		def set_cell col, row, cell
			index = col + row * @width
			if @data[index] != cell		
				# only set if has neighbour
				if has_neighbour(col, row)
					@data[index] = cell
					true
				else
					false
				end
			else
				false
			end
		end

		def remove_cell col, row
			index = col + row * @width
			if @data[index] != 0
				@data[index] = 0
				true
			else
				false
			end
		end

		def update dt
			
		end

		def draw
			cell = 0
			@width.times do |x|
				@height.times do |y|
					cell = @data[x + y * @width] - 1
					if cell >= 0
						@textures[cell].draw(x * @tile_width, y * @tile_height, 0)
					end
				end
			end
		end
	end
end