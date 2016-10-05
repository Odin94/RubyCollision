# sublime text 2 rubyformat: ctrl + alt + r

require 'rubygems'
require 'Gosu'
require './Player.rb'
require './Wall.rb'
require './MovingWall.rb'
require './Utils.rb'
require './Rectangle.rb'

class GameWindow < Gosu::Window
    def initialize
        super 800, 600
        self.caption = "You're Awesome! :3"

        @background = Gosu::Image.new("res/background.png", :tileable => true)

        @player = Player.new
        @player.warp(400, 240)

        # without this line the player can move into rectangles until they walk against a wall for the first time. I don't get it. At all.
        # Like seriously, is this some weird floating point arithmetic thing or something?
        # this doesn't work if vel_x = 0 or = 1
        # alternatively, setting player.warp to 400.1 instead of 400 also works. 400.0 doesn't though.
        @player.vel_x = 0.1

        @walls = [Wall.new(300, 200), Wall.new(250, 150), MovingWall.new(100, 400),
            MovingWall.new(100, 100, vel_x: 0, vel_y: 1), MovingWall.new(500, 100, vel_x: 0, vel_y: -1),
            MovingWall.new(100, 100, vel_x: 6, vel_y: 0),
        MovingWall.new(100, 100, vel_x: 1, vel_y: 1)]
    end

    def update
        if Gosu::button_down? Gosu::KbLeft or Gosu::button_down? Gosu::GpLeft
            @player.accel_left
        end
        if Gosu::button_down? Gosu::KbRight or Gosu::button_down? Gosu::GpRight
            @player.accel_right
        end
        if Gosu::button_down? Gosu::KbUp or Gosu::button_down? Gosu::GpButton0
            @player.accel_up
        end
        if Gosu::button_down? Gosu::KbDown or Gosu::button_down? Gosu::GpButton1
            @player.accel_down
        end

        for wall in @walls
            @player.handle_collisions([wall])
            @player.handle_wall_touching([wall])

            wall.update([@player])
        end

        @player.move
    end

    def draw
        @background.draw(0, 0, 0)
        @player.draw

        for wall in @walls
            wall.draw
        end

    end

    def button_down(id)
        if id == Gosu::KbEscape
            close
        end
    end
end

window = GameWindow.new
window.show