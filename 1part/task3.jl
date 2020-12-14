function inverseSide(side::HorizonSide)
    return HorizonSide(mod(Int(side)+2, 4))
end

function main(r::Robot)
    stepsToWest = moveSide(r, West)
    stepsToNord = moveSide(r, Nord)

    while !ismarker(r)
        moveSide(r, Sud, true, true)
        if isborder(r, Ost) != true
            moveStep(r, Ost, true)
        end
        moveSide(r, Nord, true, true)
        if isborder(r, Ost) != true
            moveStep(r, Ost, true)
        end
    end
    moveSide(r, West)
    moveSide(r, Nord)

    followByCount(r, Ost, stepsToWest)
    followByCount(r, Sud, stepsToNord)
end

function moveSide(r::Robot, side::HorizonSide, needMark=false, needCheck=false)
    steps = 0
    while isborder(r, side) != true
        moveStep(r, side, needMark)
        if needCheck
            if ismarker(r)
                return
            end
        end
        steps += 1
    end
    return steps
end

function moveStep(r::Robot, side::HorizonSide, needMark::Bool)
    if needMark
        putmarker!(r)
    end
    move!(r, side)
end

function followByCount(r::Robot, side::HorizonSide, count::Int)
    for i = 0:count-1
        moveStep(r, side, false)
    end
end
