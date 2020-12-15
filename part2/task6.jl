function great_painter(r::Robot)
    num=0
    actions=[]
    while ((isborder(r,Sud))&&(isborder(r,West)))==false
        push!(actions,moves!(r,West))
        push!(actions,moves!(r,Sud))
        num+=2
    end
    side=Nord
    while isborder(r,Ost)==false
        while isborder(r,side)==false
            move!(r,side)
            if isborder(r,Ost)==true
                break
            end           
        end
        if isborder(r,Ost)==false
            move!(r,Ost)
        end
        side=inverse(side)
    end
    while isborder(r,Ost)==true
        move!(r,Sud)
    end
    side=Nord
    for _ in 1:4
        putmarker!(r)
        move!(r,side)
        while isborder(r,next(side))==true
            putmarker!(r)
            move!(r,side)
        end
        side=next(side)
    end
    moves!(r,Sud)
    moves!(r,West)
    while (num>0)==true
        side=isodd(num) ? Ost : Nord
        for _ in 1:actions[num]
            move!(r,side)
        end
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

inverse(side::HorizonSide)=HorizonSide(mod(Int(side)+2,4))

next(side::HorizonSide)=HorizonSide(mod(Int(side)+3,4))