require './Rectangle.rb'
require './Utils.rb'

class Player < Rectangle
    def initialize
        super 32, 32, 32, 32
        @image = Gosu::Image.new("res/player.png")

        @vel_x = @vel_y = @ext_vel_x = @ext_vel_y = 0.0
    end

    attr_accessor :ext_vel_x, :ext_vel_y

    def get_total_vel_x
        return @vel_x + @ext_vel_x
    end

    def get_total_vel_y
        return @vel_y + @ext_vel_y
    end

    def warp(x, y)
        @x, @y = x, y
    end

    def accel_up
        @vel_y = -3
    end

    def accel_down
        @vel_y = 3
    end

    def accel_right
        @vel_x = 3
    end

    def accel_left
        @vel_x = -3
    end

    def move
        @x += @vel_x + @ext_vel_x
        @y += @vel_y + @ext_vel_y
        @x %= 800
        @y %= 600

        @vel_x *= 0.85
        @vel_y *= 0.85

        @ext_vel_x = 0
        @ext_vel_y = 0

        if @vel_x.abs < 1
            @vel_x = 0
        end
        if @vel_y.abs < 1
            @vel_y = 0
        end
    end

    def handle_wall_touching(walls)
        for wall in walls
            if wall.touching?(self)
                wall.on_touch!(self)
            end
        end
    end

    def draw
        @image.draw(@x, @y, 1)
    end
end