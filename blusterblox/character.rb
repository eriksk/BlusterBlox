module BlusterBlox
	class Character < Entity

		def initialize textures, map, animations
			super(textures.first)
			@map = map			
			@animations = animations
			@current_anim = @animations.first.key
			@grounded = false
		end

		def set_anim anim
			if @current_anim != anim
				@current_anim = anim
			end
		end

		def land
			
		end

		def fall_off
			
		end

		def jump
			
		end

		def update dt
			do_collision_x(dt)
			update_X(dt)
			do_collision_y(dt)
			update_y(dt)
		end

		def do_collision_x dt
			
		end

		def do_collision_y dt
			
		end

		def update_x dt
			
		end

		def update_y
			
		end
	end
end