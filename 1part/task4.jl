function inverseSide(side::HorizonSide)
    return HorizonSide(mod(Int(side)+2, 4))
end

function main(r::Robot)
    stepsToWest = moveSide(r, West)
    stepsToNord = moveSide(r, Sud)

    counter = moveSide(r, Ost)
    moveSide(r, West)

    while true
        putmarker!(r)
        moveSideByCount(r, Ost, counter)
        moveSide(r, West)
        if isborder(r, Nord) == true
            break
        end

        moveStep(r, Nord, false)
        counter -= 1
    end

    moveSide(r, West)
    moveSide(r, Sud)

    followByCount(r, Ost, stepsToWest)
    followByCount(r, Nord, stepsToNord)
end

function moveSide(r::Robot, side::HorizonSide, needMark=false)
    steps = 0
    while isborder(r, side) != true
        moveStep(r, side, needMark)
        steps += 1
    end
    return steps
end

function moveSideByCount(r::Robot, side::HorizonSide, count)
    for i in 1:count
        if isborder(r, side) != true
            moveStep(r, side, true)
        else
            break
        end
    end
end

function followByCount(r::Robot, side::HorizonSide, count::Int)
    for i = 0:count-1
        moveStep(r, side, false)
    end
end

function moveStep(r::Robot, side::HorizonSide, needMark::Bool)
    move!(r, side)
    if needMark
        putmarker!(r)
    end
end
