function great_painter(r::Robot)
    num=0
    actions=[]
    while ((isborder(r,Sud))&&(isborder(r,West)))==false
        push!(actions,moves!(r,West))
        push!(actions,moves!(r,Sud))
        num+=2
    end
    putmarker!(r)
    while !isborder(r,Ost)
        move!(r,Ost)
        putmarker!(r)
    end
    count_mark=moves!(r,West)
    while !isborder(r,Nord)&&count_mark>0
        marks=count_mark
        move!(r,Nord)
        while marks>0
            putmarker!(r)
            marks-=move_full_detour(r,Ost)
        end
        move_back_detour(r,West)
        count_mark-=1
    end
    moves!(r,Sud)
    while (num>0)==true
        side=isodd(num) ? Ost : Nord
        for _ in 1:actions[num]
            move!(r,side)
        end
        num-=1
    end
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

function moves!(r::Robot,side::HorizonSide)
    num_steps=0
    while isborder(r,side)==false
        move!(r,side)
        num_steps+=1
    end
    return num_steps
end

function move_back_detour(r::Robot, side::HorizonSide)
    change=1
    while change!=0
        change=move_full_detour(r,side)
    end
end

next(side::HorizonSide)=(HorizonSide(mod(Int(side)+1,4)))

inverse(side::HorizonSide)=(HorizonSide(mod(Int(side)+2,4)))