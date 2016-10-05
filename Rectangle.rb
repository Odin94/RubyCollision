class Rectangle
    def initialize(x, y, w, h)
        @x = x
        @y = y
        @w = w
        @h = h
    end

    attr_accessor :x, :y, :w, :h

    def handle_collisions(collidingRectangles)
        for rect in collidingRectangles
            resolve_x_collision(rect)
            resolve_y_collision(rect)
            resolve_xy_collosion(rect) # for diagonal movement it's possible to enter another rect by one pixel without this
        end
    end

    def resolve_x_collision(rect)
        while rectv_rectv_collide?(@x + @vel_x, @y, @w, @h, rect.x, rect.y, rect.w, rect.h)
            if @vel_x == 0
                break
            end

            if @vel_x.abs < 1.1
                @vel_x = abs_decrease_by(@vel_x, 0.5) # prevents leaving 1 pixel space between a rect and this
            else
                @vel_x = abs_decrease(@vel_x)
            end
        end
    end

    def resolve_y_collision(rect)
        while rectv_rectv_collide?(@x, @y + @vel_y, @w, @h, rect.x, rect.y, rect.w, rect.h)
            if @vel_y == 0
                break
            end

            if @vel_y.abs < 1.1 then
                @vel_y = abs_decrease_by(@vel_y, 0.5) # prevents leaving 1 pixel space between a rect and this
            else
                @vel_y = abs_decrease(@vel_y)
            end
        end
    end

    def resolve_xy_collosion(rect)
        while rectv_rectv_collide?(@x + @vel_x, @y + @vel_y, @w, @h, rect.x, rect.y, rect.w, rect.h)
            if @vel_y == 0 and @vel_x == 0
                break
            end

            @vel_y = abs_decrease(@vel_y)
            @vel_x = abs_decrease(@vel_x)
        end
    end
end