require 'middleclass'
require 'gamestate'
require 'point'
require 'missilefactory'
require 'turret'
require 'spaceship'
require 'tableextras'

game = GameState()

game.entities = {}
game.enemies = {}
game.missed = 0

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
    local missedText = "Missed: " .. self.missed
    love.graphics.print(missedText, love.graphics.getWidth() - love.graphics.getFont():getWidth(missedText) - 5, 0)
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
                    focusedEnemy:unfocus()
                    focusedEnemy = nil
                    self:addEnemy(SpaceShip())
                end
            end
        else
            for index, enemy in ipairs(self.enemies) do
                if enemy:getNextLetter() == key and not table.contains(attacked, enemy) then
                    enemy:removeNextLetter()

                    if (enemy:getWordLength() == 0) then
                        getClosetTurret(enemy):fireMissile(enemy)
                        table.insert(attacked, enemy)
                        enemy:focus()
                    else
                        enemy:focus()
                        focusedEnemy = enemy
                    end
                    break
                end
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
    table.insert(self.enemies, enemy)
end

function game:removeEnemy(enemy)
    self:removeEntity(enemy)
    table.removeItem(self.enemies, enemy)
end

game:addEnemy(SpaceShip())