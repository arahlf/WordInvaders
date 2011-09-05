require 'point'

Utils = {}

function Utils.getAngle(point1, point2)
    local distanceX = point2:getX() - point1:getX()
    local distanceY = point2:getY() - point1:getY()

    return math.atan2(distanceY, distanceX)
end

function Utils.getDistance(point1, point2)
    local sideA = point1:getX() - point2:getX()
    local sideB = point1:getY() - point2:getY()

    return math.sqrt(math.pow(sideA, 2) + math.pow(sideB, 2))
end

function Utils.translatePoint(point, angle, factor)
    return Point(point:getX() + math.cos(angle) * factor,
                 point:getY() + math.sin(angle) * factor)
end

-- calling this primitive would be a compliment =)
function Utils.hitTest(entity1, entity2)
    local distance = Utils.getDistance(entity1:getCenter(), entity2:getCenter())

    return distance < 25 -- totally arbitrary...
end

function Utils.moveTowards(location, destination, factor)
    local angle = Utils.getAngle(location, destination)
    return Utils.translatePoint(location, angle, factor)
end