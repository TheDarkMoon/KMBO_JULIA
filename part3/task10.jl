COUNT=0

function great_painter(r::Robot)
    global COUNT=0
    overal_temp=0
    side=Ost
    while isborder(r,Nord)==false
        overal_temp+=row_temp(r,side)
        move!(r,Nord)
        side=inverse(side)
    end
    overal_temp+=row_temp(r,side)
    average_temp=overal_temp/COUNT
    return average_temp
end

function row_temp(r::Robot, side::HorizonSide)
    row_temp=0
    while isborder(r,side)==false
        row_temp+=check_temp(r)
        move!(r,side)
    end
    row_temp+=check_temp(r)
    return row_temp
end

function check_temp(r::Robot)
    global COUNT
    if ismarker(r)==true
        COUNT+=1
        return temperature(r)
    else
        return 0
    end
end

inverse(side::HorizonSide)=HorizonSide(mod(Int(side)+2,4))