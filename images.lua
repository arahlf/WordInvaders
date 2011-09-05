local function getImage(fileName)
    return love.graphics.newImage('resources/images/' .. fileName)
end

Images = {
    BOMB = getImage('bomb.png'),
    MISSILE = getImage('missile.png'),
    SPACESHIP = getImage('spaceship.png'),
    SPACESHIP_FOCUSED = getImage('spaceship_focused.png'),
    TURRET = getImage('turret.png')
}