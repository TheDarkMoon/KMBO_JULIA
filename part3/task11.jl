function great_painter(r::Robot)
    num=0
    actions=[]
    while ((isborder(r,Sud))&&(isborder(r,West)))==false
        push!(actions,moves!(r,West))
        push!(actions,moves!(r,Sud))
        num+=2
    end
    num_ver=0
    num_hor=0
    for i in 1:num
        if isodd(i)==true
            num_hor+=actions[i]
        else
            num_ver+=actions[i]
        end
    end
    side=Nord
    for _ in 1:2
        num_ver=mark_kord(r,side,num_ver)
        side=next(side)
        num_hor=mark_kord(r,side,num_hor)
        side=next(side)
    end
    while (num>0)==true
        side=isodd(num) ? Ost : Nord
        move_steps(r,side,actions[num])
        num-=1
    end
end

function moves!(r::Robot,side::HorizonSide)
    num_steps=0
    while isborder(r,side)==false
        move!(r,side)
        num_steps+=1
    end
    return num_steps
end

function mark_kord(r::Robot, side::HorizonSide, num_steps::Int)
    move_steps(r,side,num_steps)
    putmarker!(r)
    num_steps=moves!(r,side)
    return num_steps
end

function move_steps(r::Robot, side::HorizonSide, num_steps::Int)
    for _ in 1:num_steps
        move!(r,side)
    end
end

next(side::HorizonSide)=HorizonSide(mod(Int(side)+3,4))