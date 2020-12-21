function great_painter(r::Robot)
    side=Nord
    for _ in 1:4
        change=1
        while change !=0
            change=move_spec(r,side)
            putmarker!(r)
        end
        while ismarker(r)
            move_full_detour(r,inverse(side))
        end
        side=inverse(next(side))
    end
    putmarker!(r)
end

function move_full_detour(r::Robot, side::HorizonSide)
    num_steps=0
    while isborder(r,side)&&!isborder(r,next(side))
        move!(r,next(side))
        num_steps+=1
    end
    change=0
    if !isborder(r,side)
        move!(r,side)
        change+=1
    end
    if num_steps !=0
        while isborder(r,inverse(next(side)))
            move!(r,side)
            change+=1
        end
        for _ in 1:num_steps
            move!(r,inverse(next(side)))
        end
    end
    return change
end

next(side::HorizonSide)=HorizonSide(mod(Int(side)+1,4))

inverse(side::HorizonSide)=HorizonSide(mod(Int(side)+2,4))