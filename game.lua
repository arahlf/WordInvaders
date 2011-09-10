require 'middleclass'
require 'gamestate'
require 'point'
require 'missilefactory'
require 'turret'
require 'spaceship'
require 'tableextras'
require 'threat'

game = GameState()

game.entities = {}

game.turrets = {
    Turret(Point(200, 600)),
    Turret(Point(400, 600)),
    Turret(Point(600, 600))
}

table.insert(game.entities, game.turrets[1])
table.insert(game.entities, game.turrets[2])
table.insert(game.entities, game.turrets[3])

game.enemies = {}

local paused = false
local attacked = {}
local focusedEnemy
local score = 0

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

function game:update(dt)
    if not paused then
        local updating = true -- TODO use in conjunction with remove

        for index, entity in ipairs(self.entities) do
            entity:update(dt)
        end
    end
end

function game:draw()
    for index, entity in ipairs(self.entities) do
        entity:draw()
    end

    Colors.BLACK:set()
    Fonts.DIAGNOSTICS:set()
    local scoreText = "Score: " .. score
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
        if (focusedEnemy ~= nil) then
            if (focusedEnemy:getNextLetter() == key) then
                focusedEnemy:removeNextLetter()

                if (focusedEnemy:getWordLength() == 0) then
                    getClosetTurret(focusedEnemy):fireMissile(focusedEnemy)
                    table.insert(attacked, focusedEnemy)
                    score = score + focusedEnemy:getPointValue()
                    focusedEnemy:unfocus()
                    focusedEnemy = nil
                    self:addEnemy(SpaceShip())
                end
            else
                score = score - 1
            end
        else
            local enemy = findNewEnemy(key)

            if (enemy ~= nil) then
                enemy:removeNextLetter()

                if (enemy:getWordLength() == 0) then
                    getClosetTurret(enemy):fireMissile(enemy)
                    table.insert(attacked, enemy)
                    score = score + enemy:getPointValue()
                    enemy:focus()
                else
                    enemy:focus()
                    focusedEnemy = enemy
                end
            else
                score = score - 1
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

game:addEnemy(SpaceShip())