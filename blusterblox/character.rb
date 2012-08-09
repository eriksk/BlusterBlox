module BlusterBlox
	class Character < Entity

		def initialize textures, map, animations
			super(textures.first)
			@map = map			
			@animations = animations
			@current_anim = @animations.first[0]
			@grounded = false
		end

		def set_anim anim
			if @current_anim != anim
				@current_anim = anim
			end
		end

		def land
			@grounded = true
			@velocity.y = 0.0
		end

		def fall_off
			@grounded = false
			@velocity.y = 0.0
		end

		def jump force
			@grounded = false
			@velocity.y = -force
		end

		def update dt
			do_collision_x(dt)
			update_x(dt)
			do_collision_y(dt)
			update_y(dt)
		end

		def do_collision_x dt
			
		end

		def do_collision_y dt
			
		end

		def update_x dt
			
		end

		def update_y dt
			
		end
	end
end