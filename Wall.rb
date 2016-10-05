class Wall < Rectangle
    def initialize(x, y, w: 64, h: 64)
        super x, y, w, h

        @color = 0xff330000
    end

    def draw
        Gosu::draw_quad(@x, @y, @color, @x + @w, @y, @color, @x, @y + @h, @color, @x + @w, @y + @h, @color, 0)
    end

    def update(collidingRectangles)
    end

    def touching?(actor)
        false
    end

    def on_touch!(actor)
    end
end