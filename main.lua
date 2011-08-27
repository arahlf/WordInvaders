require 'middleclass'
require 'spaceship'
require 'missile'
require 'turret'

local ship = SpaceShip:new()
local missiles = {};
local turret = Turret:new()

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

    turret:draw()
end

function love.load()
    love.graphics.setBackgroundColor(225, 225, 225)
end

function love.keypressed(key, unicode)
    if (key == ' ') then
        table.insert(missiles, Missile:new(ship))
    end
end