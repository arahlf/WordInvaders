require 'middleclass'
require 'spaceship'
require 'missile'


local ship = SpaceShip:new()
local missiles = {};

function love.draw()
    -- draw the missiles
    for index, missile in pairs(missiles) do
        if (missile:isDestroyed() == false) then
            missile:move()
            missile:draw()
        end
    end

    ship:move()
    ship:draw()
end

function love.load()
    love.graphics.setBackgroundColor(225, 225, 225)
end

function love.keypressed(key, unicode)
    if (key == ' ') then
        table.insert(missiles, Missile:new(ship))
    end
end