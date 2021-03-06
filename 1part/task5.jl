function inverseSide(side::HorizonSide)
    return HorizonSide(mod(Int(side)+2, 4))
end

function main(r::Robot)
    goToTheCorner(Sud, West)
    goToTheCorner(Nord, West)
    goToTheCorner(Nord, Ost)
    goToTheCorner(Sud, Ost)
end

function goToTheCorner(side1::HorizonSide, side2::HorizonSide)
    pathBack = []
    while isborder(r, side1) != true || isborder(r, side2) != true
        stepsToX = moveSide(r, side1)
        stepsToY = moveSide(r, side2)
        push!(pathBack, [inverseSide(side1), stepsToX])
        push!(pathBack, [inverseSide(side2), stepsToY])
    end
    putmarker!(r)
    for item in pathBack[end:-1:1]
        followByCount(r, item[1], item[2])
    end
end

function moveSide(r::Robot, side::HorizonSide, needMark=false)
    steps = 0
    while isborder(r, side) != true
        moveStep(r, side, needMark)
        steps += 1
    end
    return steps
end

function followByCount(r::Robot, side::HorizonSide, count::Int)
    for i = 1:count
        moveStep(r, side, false)
    end
end

function moveStep(r::Robot, side::HorizonSide, needMark::Bool)
    move!(r, side)
    if needMark
        putmarker!(r)
    end
end
