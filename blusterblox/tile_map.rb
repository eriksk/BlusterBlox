module BlusterBlox
	class TileMap

		attr_accessor :textures


		def initialize textures, seed = 0, width = 64, height = 64
			@rand = Random.new(seed)
			@textures = textures
			@tile_width = textures.first.width
			@tile_height = textures.first.height
			@data = []
			@width = width
			@height = height

			@grass = 9
			@rock = 3
			@brick = 7
			@sand = 1
			@water = 5

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
			# just fill all with 0 first
			@width.times do |x|
				@height.times do |y|
					@data.push(0)
				end
			end

			add_rock_floor()
			add_grass()
			add_water()
		end		

		def add_grass			
			# add some grass
			@width.times do |col|
				row = get_top_cell_row(col)
				grass_height = @rand.rand(2).to_i + 2
				#row -= grass_height
				grass_height.times do |i|
					set_cell_raw(col, row, @grass)
					row += 1
				end
			end
		end

		def add_water
			waters = @rand.rand(4).to_i
			waters.times do |q|
				depth = @rand.rand(10) + 2
				width = @rand.rand(10) + 2
				start_col = @rand.rand(@width).to_i - width
				min_row = get_top_cell_row(start_col) + 1
				# calc lowest point, min_row
				width.times do |col|
					current_row = get_top_cell_row(start_col + col) + 1
					if current_row > min_row
						min_row = current_row
					end
				end

				width.times do |col|
					# clear up to start_col
					min_row.times do |c|
						remove_cell(start_col + col, c)
					end

					# set the water
					depth.times do |i|
						set_cell_raw(start_col + col, min_row + i, @water)
					end
				end
			end
		end

		def add_rock_floor			
			# fill floor with rock
			row = (@height - @rand.rand(10).to_i) - 1
			@width.times do |col|
				val = @rand.rand()
				if val > 0.8
					row += 1
				elsif val > 0.5
					row -= 1
				else
				end
				if row > @height - 1
					row = @height - 1
				end
				_row = row
				while _row < @height
					set_cell_raw(col, _row, @rock)
					_row += 1
				end
			end
		end

		def get_top_cell_row col
			row = 0
			while row < @height
				if get_cell(col, row) != 0
					return row
				else
					row += 1
				end
			end
			@height - 1
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