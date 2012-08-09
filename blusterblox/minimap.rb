module BlusterBlox
	class MiniMap

		def initialize game, map, camera, game_area
			@game = game
			@map = map
			@cam = camera
			@area = game_area.clone
			
			@zoom = 0.1
			@area.scale(@zoom)
			@cam_area = Rectangle.new(@area.x, @area.y, (@cam.origin.x * 2), (@cam.origin.y * 2))
			@cam_area.scale(@zoom)
			@border_color = Gosu::Color::RED
			@cam_color = Gosu::Color::GREEN
			@cell_color = Gosu::Color::BLUE

			@pixel = Rectangle.new(0, 0, 16.0 * @zoom, 16.0 * @zoom)

			@area.x = $WIDTH - (@area.width + 32)
			@area.y = 32
		end

		def update dt
			@cam_area.x = @area.x + (@cam.pos.x * @zoom)
			@cam_area.y = @area.y + (@cam.pos.y * @zoom)
		end

		def draw
			@map.width.times do |col|
				@map.height.times do |row|
					if @map.get_cell(col, row) > 0
						@pixel.x = @area.x + (col * 16) * @zoom
						@pixel.y = @area.y + (row * 16) * @zoom
						@pixel.draw @game, @cell_color
					end
				end
			end
			@cam_area.draw_border @game, @cam_color
			@area.draw_border @game, @border_color
		end
	end
end