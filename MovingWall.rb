class MovingWall < Wall
    def initialize(x, y, w:64, h:64, vel_x:1, vel_y:0)
        super x, y, w: w, h: h

        @target_vel_x = vel_x
        @target_vel_y = vel_y

        @vel_x = @target_vel_x
        @vel_y = @target_vel_y
    end
    # attr_accessor :vel_x, :vel_y

    def update(collidingRectangles)
        @vel_x = @target_vel_x
        @vel_y = @target_vel_y

        # handle_collisions(collidingRectangles)

        @x += @vel_x
        @y += @vel_y

        @x %= 800
        @y %= 600
    end

    def on_touch!(actor)
        # I'd much rather do this part through actor.ext_vel, but it works like this and doesn't with ext_vel :(
        if((actor.x + actor.w < @x and @vel_x < 0) or (actor.x > @x + @w and @vel_x > 0))
            (1..@vel_x.abs).step(1) do
                if @vel_x > 0
                    actor.x += 1
                else
                    actor.x -= 1
                end
                if not touching?(actor) then break end
            end
        end

        if((actor.y + actor.h < @y and @vel_y < 0) or (actor.y > @y + @h and @vel_y > 0))
            (1..@vel_y.abs).step(1) do
                if @vel_y > 0
                    actor.y += 1
                else
                    actor.y -= 1
                end
                if not touching?(actor) then break end
            end
        end
        #actor.ext_vel_x += @vel_x
        #actor.ext_vel_y += @vel_y
    end

    def touching?(actor)
        rectv_rectv_collide?(actor.x + actor.get_total_vel_x, actor.y + actor.get_total_vel_y, actor.w, actor.h, @x + @vel_x, @y, @w, @h) or
        rectv_rectv_collide?(actor.x + actor.get_total_vel_x, actor.y + actor.get_total_vel_y, actor.w, actor.h, @x - @vel_x, @y, @w, @h) or
        rectv_rectv_collide?(actor.x + actor.get_total_vel_x, actor.y + actor.get_total_vel_y, actor.w, actor.h, @x, @y + @vel_y, @w, @h) or
        rectv_rectv_collide?(actor.x + actor.get_total_vel_x, actor.y + actor.get_total_vel_y, actor.w, actor.h, @x, @y - @vel_y, @w, @h)
    end
end