require	'gosu'
require_relative 'blusterblox/game'
require_relative 'blusterblox/vec2'
require_relative 'blusterblox/entity'
require_relative 'blusterblox/helpers'
require_relative 'blusterblox/camera'
require_relative 'blusterblox/tile_map'

module BlusterBlox

	$WIDTH = 1280
	$HEIGHT = 720
	$FULLSCREEN = false

	game = Game.new
	game.show
end