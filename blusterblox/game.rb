module BlusterBlox
	class Game < Gosu::Window
		
		MAX_CELLS = 21

		def initialize
			super($WIDTH, $HEIGHT, $FULLSCREEN)
			self.caption = "Bluster Blox"

			@top_color = Gosu::Color::WHITE
			@bottom_color = Gosu::Color::GRAY

			@game_area = Rectangle.new(0, 0, 16 * 128, 16 * 64)
			puts @game_area

			@font = Gosu::Font.new(self, Gosu::default_font_name, 24)

			@cam = Camera.new(self)

			tiles_tex = load_image_tiles('tiles', 16, 16)
			@map = TileMap.new(tiles_tex)
			@map.clear
			63.times do |i|
				@map.set_cell_raw(i, 32, 2)
			end

			@current_cell = 1
			@sounds = {
				:set_cell => load_sound('set_cell'),
				:remove_cell => load_sound('remove_cell')
			}

			@entities = []		
			@cursor = Entity.new(load_image('cursor'))
			@cursor.origin.x = 0.0
			@cursor.origin.y = 0.0
		end

		def add_entity(entity)
			@entities.push entity
		end

		def load_sound(name)
			Gosu::Sample.new(self, "content/audio/#{name}.wav")
		end

		def load_image(name)
			Gosu::Image.new(self, "content/gfx/#{name}.png", false)
		end

		def load_image_tiles(name, tile_width, tile_height)
			Gosu::Image.load_tiles(self, "content/gfx/#{name}.png", tile_width, tile_height, true)
		end

		def button_down(id)
			case id
				when Gosu::KbEscape
					exit
				when Gosu::KbA
					@current_cell -= 2
					if @current_cell < 1
						@current_cell = MAX_CELLS - 1 
					end
				when Gosu::KbD
					@current_cell += 2
					if @current_cell > MAX_CELLS - 1
						@current_cell = 1
					end
			end
		end

		def mouse_world_x
			mouse_x + @cam.pos.x
		end
		def mouse_world_y
			mouse_y + @cam.pos.y			
		end

		def update
			dt = 16.0

			if button_down?Gosu::KbLeftControl
				if button_down?Gosu::MsLeft
					@cam.move_by(@cursor.position.x - mouse_x, @cursor.position.y - mouse_y)
				end
			else
				if button_down?Gosu::MsLeft
					col = (mouse_world_x / 16.0).to_i
					row = (mouse_world_y / 16.0).to_i
					if @map.set_cell(col, row, @current_cell)
						@sounds[:set_cell].play()
					end	
				end
				if button_down?Gosu::MsRight
					col = (mouse_world_x / 16.0).to_i
					row = (mouse_world_y / 16.0).to_i
					if @map.remove_cell(col, row)
						@sounds[:remove_cell].play()
					end
				end
			end
		
			@cursor.set_position(mouse_x.to_i, mouse_y.to_i)

			@entities.each do |e|
				e.update dt
			end	

			@map.update dt
			@cam.update dt
		end

		def draw
			draw_background
			@cam.translate(){
				@map.draw
				#draw_grid(32, 32, 16, Gosu::Color::RED)
				draw_selected_cell()
				@entities.each do |e|
					e.draw
				end			
			}
			draw_hud
			@cursor.draw
		end

		def draw_hud
			@font.draw("x: #{mouse_x.to_i}, y: #{mouse_y.to_i}", 16, 16, 0, 1.0, 1.0, Gosu::Color::BLACK)
			@font.draw("cell: #{@current_cell}", 16, 32, 0, 1.0, 1.0, Gosu::Color::BLACK)
		end

		def draw_selected_cell
			x = (mouse_world_x / 16.0).to_i * 16
			y = (mouse_world_y / 16.0).to_i * 16
			@map.textures[@current_cell - 1].draw(x, y, 0)
			color = Gosu::Color::RED
			color.alpha = 100
			draw_quad(
				x, y, color,
				x + 16, y, color,
				x + 16, y + 16, color,
				x, y + 16, color
			)
		end

		def draw_background
			draw_quad(
				0, 0, @top_color,
				$WIDTH, 0, @top_color,
				$WIDTH, $HEIGHT, @bottom_color,
				0, $HEIGHT, @bottom_color,
			)
		end

		def draw_grid cols, rows, cell_size, color
			cols.times do |x|
				draw_line(x * cell_size, 0, color, x * cell_size, rows * cell_size, color)
				rows.times do |y|
					draw_line(0, y * cell_size, color, rows * cell_size, y * cell_size, color)
				end
			end
		end
	end
end