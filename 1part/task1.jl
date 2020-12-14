function inverse(side::HorizonSide)
    return HorizonSide(mod(Int(side)+2, 4)) 
end

function main(r::Robot)
    for side in sides
        putmarkers!(r,side)
        followMarkers(r,inverse(side))
    end
    putmarker!(r)
end

function putmarkers!(r::Robot,side::HorizonSide)
    while isborder(r,side)==false 
        move!(r,side)
        putmarker!(r)
    end
end

function followMarkers(r::Robot,side::HorizonSide)
    while ismarker(r)==true 
        move!(r,side) 
    end
end
