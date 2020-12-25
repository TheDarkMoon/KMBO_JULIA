function go_around(r, side)
    counter_horisontal = 0
    counter_vertical = 0
    while(isborder(r, side))
        move!(r, turn_side(side)) # turn_side(side)
        counter_vertical = counter_vertical + 1
    end
    move!(r, side)
    while(isborder(r, invert_side(turn_side(side)))) # invert_side(turn_side(side))
        move!(r, side)
        counter_horisontal = counter_horisontal + 1
    end
    move!(r, invert_side(turn_side(side)))
    c = counter_vertical
    while(c > 1)
        move!(r, invert_side(turn_side(side))) # invert_side(turn_side(side))
        c = c - 1
    end
    # counter_horisontal - в побочную сторону
    # counter_vertical - в главную сторону
    return (counter_horisontal, counter_vertical)
end
function turn_side(side)
    if side == Nord
        return West
    end
    if side == Sud
        return West
    end
    if side == Ost
        return Sud
    end
    if side == West
        return Sud
    end
end
function invert_side(side)
    if side == Nord
        return Sud
    end
    if side == Sud
        return Nord
    end
    if side == Ost
        return West
    end
    if side == West
        return Ost
    end
end
function gotobegin(r)
    a = 0
    b = 0
    while(!((isborder(r, West)) & (isborder(r, Sud))))
        a = a + gotoborder(r, West)
        b = b + gotoborder(r, Sud)
    end
    return(a, b)
end
function gotoborder(r, side)
    count = 0
    while(!isborder(r, side))
        move!(r, side)
        count = count + 1
    end
    return count
end
function measure_field(r)
    y = gotoborder(r, Nord)
    gotoborder(r, Sud)
    x = gotoborder(r, Ost)
    gotoborder(r, West)
    return (x,y)
end
function push_and_mark(r, side, counter)
    b = 0
    while(counter>0)
        putmarker!(r)
        if(isborder(r, side))
            b,count = go_around(r, side)
            counter = counter - count - 1
        else
            move!(r, side)
            counter = counter - 1
        end
    end
end
function push_hor(r, side, counter)
    b = 0
    while(counter>0)
        if(isborder(r, side))
            count,b = go_around(r, side)
            counter = counter - count - 1
        else
            move!(r, side)
            counter = counter - 1
        end
    end
end
function goto_coord(r, side, coord)
    while(coord > 0)
        coord = coord - 1
        move!(r, side)
    end
end
function main(r)
    c_hor,c_vert = gotobegin(r)
    rt_x,rt_y=c_hor,c_vert
    x_dim,y_dim = measure_field(r)
    side = Nord
    move!(r, Ost)
    d = 1
    obstacle_count = 0
    while(x_dim>0)
        d = d + 1
        x_dim = x_dim - 1
        c = y_dim
        while(c>0)
            if(isborder(r, side))
                count,b = go_around(r, side)
                c = c - count - 1
                if((b == 1) & (count*b == 0))
                    obstacle_count = obstacle_count + 1
                end
                # print(count, " ", b, "\n")
            else
                move!(r, side)
                c = c - 1
            end
        end
        gotobegin(r)
        if(x_dim != 0)
            goto_coord(r, Ost, d)
        end
    end
    obstacle_count = obstacle_count + main1(r)
    # print(obstacle_count)
    return obstacle_count
end
function main1(r)
    c_hor,c_vert = gotobegin(r)
    rt_x,rt_y=c_hor,c_vert
    x_dim,y_dim = measure_field(r)
    side = Ost
    move!(r, Nord)
    d = 1
    obstacle_count = 0
    # print(x_dim, " ", y_dim, "\n\n")
    while(y_dim>0)
        d = d + 1
        y_dim = y_dim - 1
        c = x_dim
        while(c>0)
            if(isborder(r, side))
                # print("Перегородка\n")
                count,b = go_around(r, side)
                c = c - count - 1
                if((b == 1) & (count*b == 0))
                    obstacle_count = obstacle_count + 1
                end
                # print(b, " ", count, "\n")
            else
                move!(r, side)
                c = c - 1
            end
            # print(c,"\n")
        end
        gotobegin(r)
        if(y_dim != 0)
            goto_coord(r, Nord, d)
        end
    end
    # print("\n\n\n\n", obstacle_count)
    return obstacle_count
end