require 'middleclass'
require 'gamestate'
require 'point'
require 'missilefactory'
require 'turret'
require 'spaceship'
require 'tableextras'
require 'threat'
require 'gamestatemanager'
require 'gameover'

game = GameState()

game.entities = {}
game.enemies = {}
game.score = 0

game.turrets = {
    Turret(Point(200, 600)),
    Turret(Point(400, 600)),
    Turret(Point(600, 600))
}

table.insert(game.entities, game.turrets[1])
table.insert(game.entities, game.turrets[2])
table.insert(game.entities, game.turrets[3])



local paused = false
local attacked = {}
local focusedEnemy
local lastShip = -1

for index, level in pairs(Threat) do
    game.enemies[level] = {}
end

local function findNewEnemy(letter)
    local index = #game.enemies

    for i = #game.enemies, 1, -1 do
        local bucket = game.enemies[i]
        for index, enemy in ipairs(bucket) do
            if enemy:getNextLetter() == letter and not table.contains(attacked, enemy) then
                return enemy
            end
        end
    end
end

local function getClosetTurret(enemy)
    local distance
    local closestTurret

    for index, turret in ipairs(game.turrets) do
        local turretDistance = Utils.getDistance(turret:getLocation(), enemy:getLocation())
        if (distance == nil or turretDistance < distance) then
            distance = turretDistance
            closestTurret = turret
        end
    end

    return closestTurret
end

function game:update(dt)
    if not paused then
        local time = love.timer.getTime()

        if (time >= lastShip + 5) then
            lastShip = time
            self:addEnemy(SpaceShip())
        end

        local toRemove = {}

        for index, entity in ipairs(self.entities) do
            if (entity:isAlive()) then
                entity:update(dt)
            else
                table.insert(toRemove, index)
            end
        end

        for index, value in ipairs(toRemove) do
            table.remove(self.entities, value - index + 1)
        end

        if (not self.turrets[1]:isAlive() and not self.turrets[2]:isAlive() and not self.turrets[3]:isAlive()) then
            GameStateManager:switch(gameover)
        end
    end
end

function game:draw()
    for index, entity in ipairs(self.entities) do
        entity:draw()
    end

    Colors.BLACK:set()
    Fonts.DIAGNOSTICS:set()
    local scoreText = "Score: " .. game.score
    love.graphics.print(scoreText, love.graphics.getWidth() - love.graphics.getFont():getWidth(scoreText) - 5, 0)
    love.graphics.print("FPS: " .. love.timer.getFPS(), 2, 0)
end

function game:keypressed(key, unicode)
    if (key == 'tab') then
        if (focusedEnemy ~= nil) then
            focusedEnemy:unfocus()
            focusedEnemy = nil
        end
    
    elseif (key == 'escape') then
        paused = not paused

    elseif (not paused) then
        local letter = key

        if (love.keyboard.isDown('lshift') or love.keyboard.isDown('rshift')) then
            letter = letter:upper()
        end

        if (focusedEnemy ~= nil) then
            if (focusedEnemy:getNextLetter() == letter) then
                focusedEnemy:removeNextLetter()

                if (focusedEnemy:getWordLength() == 0) then
                    getClosetTurret(focusedEnemy):fireMissile(focusedEnemy)
                    table.insert(attacked, focusedEnemy)
                    self.score = self.score + focusedEnemy:getPointValue()
                    focusedEnemy:unfocus()
                    focusedEnemy = nil
                    self:addEnemy(SpaceShip())
                end
            else
                self.score = self.score - 1
            end
        else
            local enemy = findNewEnemy(letter)

            if (enemy ~= nil) then
                enemy:removeNextLetter()

                if (enemy:getWordLength() == 0) then
                    getClosetTurret(enemy):fireMissile(enemy)
                    table.insert(attacked, enemy)
                    self.score = self.score + enemy:getPointValue()
                    enemy:focus()
                else
                    enemy:focus()
                    focusedEnemy = enemy
                end
            else
                self.score = self.score - 1
            end
        end
        
    end
end

function game:addEntity(entity)
    table.insert(self.entities, entity)
end

function game:removeEntity(entity)
    table.removeItem(self.entities, entity)
end

function game:addEnemy(enemy)
    self:addEntity(enemy)
    table.insert(self.enemies[enemy:getThreatLevel()], enemy)
end
function game:removeEnemy(enemy)
    self:removeEntity(enemy)
    --table.removeItem(self.enemies, enemy)
end