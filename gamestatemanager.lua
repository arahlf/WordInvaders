require 'gamestate'

GameStateManager = {}

-- used to preserve any hooks from main
local globalUpdate, globalDraw, globalKeypressed

function GameStateManager:switch(gameState)
    function love.update(dt)
        if globalUpdate then globalUpdate(dt) end
        gameState:update(dt)
    end

    function love.draw()
        if globalDraw then globalDraw() end
        gameState:draw()
    end

    function love.keypressed(key, unicode)
        if globalKeypressed then globalKeypressed(key, unicode) end
        gameState:keypressed(key, unicode)
    end
end

function GameStateManager:init()
    globalUpdate = love.update
    globalDraw = love.draw
    globalKeypressed = love.keypressed

    self:switch(GameState())
end