function great_painter(r::Robot)
    side=Ost
    num_hor=moves!(r,West)
    num_ver=moves!(r,Sud)
    change=1
    while isborder(r,Nord)==false
        mark_or_no(r,abs(num_ver),abs(num_hor),1)
        while isborder(r,side)==false
            move!(r,side)
            num_hor-=change
            mark_or_no(r,abs(num_ver),abs(num_hor),1)
        end
        move!(r,Nord)
        side=inverse(side)
        num_ver-=1
        change*=-1
    end
    mark_or_no(r,abs(num_ver),abs(num_hor),1)
    while isborder(r,side)==false
        move!(r,side)
        num_hor-=change
        mark_or_no(r,abs(num_ver),abs(num_hor),1)
    end
    move_back(r,Nord,num_ver)
    move_back(r,Ost,num_hor)
end

function moves!(r::Robot,side::HorizonSide)
    num_steps=0
    while isborder(r,side)==false
        move!(r,side)
        num_steps+=1
    end
    return num_steps
end

function mark_or_no(r::Robot, x_coord::Int, y_coord::Int, size::Int)
    if ((mod(x_coord,2*size) in 0:size-1)&&(mod(y_coord,2*size) in 0:size-1))
        putmarker!(r)
    end
    if ((mod(x_coord,2*size) in size:2*size-1)&&(mod(y_coord,2*size) in size:2*size-1))
        putmarker!(r)
    end
end
    
function move_back(r::Robot,side::HorizonSide,num_steps::Int)
    if (num_steps<0)==true
        side=inverse(side)
        num_steps*=-1
    end
    for _ in 1:num_steps
        move!(r,side)
    end
end
    
inverse(side::HorizonSide)=HorizonSide(mod(Int(side)+2,4))