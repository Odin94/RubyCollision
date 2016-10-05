def rect_rect_collide?(first_rect, seconds_rect)
    return (first_rect.x < seconds_rect.x + seconds_rect.w and
    first_rect.x + first_rect.w > seconds_rect.x and
    first_rect.y < seconds_rect.y + seconds_rect.h and
    first_rect.h + first_rect.y > seconds_rect.y)
end

def rectv_rectv_collide?(x1, y1, w1, h1, x2, y2, w2, h2)
    rect1 = Rectangle.new(x1, y1, w1, h1)
    rect2 = Rectangle.new(x2, y2, w2, h2)

    return rect_rect_collide?(rect1, rect2)
end

def circle_circle_collide?(first_circle, second_circle)
    unless first_circle.x + first_circle.r + second_circle.r > second_circle.x and
        first_circle.x < second_circle.x + first_circle.r + second_circle.r and
        first_circle.y + first_circle.r + second_circle.r > second_circle.y and
        first_circle.y < second_circle.y + first_circle.r + second_circle.r
        return false
    end

    distance = sqrt(((first_circle.x - second_circle.x) * (first_circle.x - second_circle.x)) +
    ((first_circle.y - second_circle.y) * (first_circle.y - second_circle.y)))

    return distance < first_circle.r + second_circle.r
end


def circle_rect_collide?(circle, rectangle)
    rect_center_x = rectangle.x + rectangle.w / 2
    rect_center_y = rectangle.y + rectangle.h / 2

    circle_distance_x = (circle.x - rect_center_x).abs
    circle_distance_y = (circle.y - rect_center_y).abs

    if circle_distance_x > (rectangle.w / 2 + circle.r)
        return false
    end
    if circle_distance_y > (rectangle.h / 2 + circle.r)
        return false
    end

    if circle_distance_x <= (rectangle.w / 2)
        return true
    end
    if circle_distance_y <= (rectangle.h / 2)
        return true
    end

    corner_distance_sqr = (circle_distance_x - rectangle.w / 2) * (circle_distance_x - rectangle.w / 2) +
    (circle_distance_y - rectangle.h / 2) * (circle_distance_y - rectangle.h / 2)

    return (corner_distance_sqr <= (circle.r * circle.r))
end

def abs_decrease_by(number, dec_number)
    if number.abs < dec_number
        return 0

    elsif number > 0 then
        return number - dec_number
    elsif number < 0 then
        return number + dec_number
    end
end

def abs_decrease(number)
    if number.abs < 1
        return 0

    elsif number > 0 then
        return number - 1
    elsif number < 0 then
        return number + 1
    end
end

# 0 counts as positive sign
def same_sign?(number, number2)
    return (number * number2 > 0 or (number >= 0 and number2 >= 0))
end