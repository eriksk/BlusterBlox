module BlusterBlox
        class Entity

                attr_accessor :position, :velocity, :rotation, :scale, :texture, :width, :height, :origin, :flipped

                def initialize texture
                        @texture = texture
                        @position = Vec2.new
                        @velocity = Vec2.new
                        @origin = Vec2.new(0.5, 0.5)
                        @rotation = 0.0
                        @scale = 1.0
                        @width = texture.width
                        @height = texture.height
                        @flipped = false
                        load
                end
                
                def load
                end

                def set_position(x, y)
                        @position.x = x
                        @position.y = y
                end

                def update dt

                end

                def draw
                        @texture.draw_rot(@position.x, @position.y, 0, @rotation.to_degrees, @origin.x, @origin.y, @flipped ? -@scale : @scale, @scale)
                end
        end
end