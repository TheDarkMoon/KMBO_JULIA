function great_painter(r::Robot)
    num_steps=1
    side=Ost
    while isborder(r,Nord)==true
        check_space(r,side,k)
        side=inverse(side)
        num_steps+=1
    end
end

function check_space(r::Robot, side::HorizonSide, num_steps::Int)
    for _ in 1:num_steps
        move!(r,side)
        if isborder(r,Nord)==false
            break
        end
    end
end

inverse(side::HorizonSide)=HorizonSide(mod(Int(side)+2,4))