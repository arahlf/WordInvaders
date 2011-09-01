local function getImage(fileName)
    return love.graphics.newImage('resources/images/' .. fileName)
end

Images = {
    BOMB = getImage('bomb.png'),
    BOMB_TARGETED = getImage('bomb_targeted.png'),
    MISSILE = getImage('missile.png'),
    SPACESHIP = getImage('spaceship.png'),
    TURRET = getImage('turret.png')
}