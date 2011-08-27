SpaceShip = class('SpaceShip')

function SpaceShip:initialize()
    self.img = love.graphics.newImage('resources/images/spaceship.png')
    self.x = 0;
    self.y = 0;
    self.speed = 2;
    self.dir = 'right'
end

function SpaceShip:draw()
    love.graphics.draw(self.img, self.x, self.y)
end

function SpaceShip:move()
    if (self.dir == 'right') then
        self.x = self.x + self.speed
        if (self.x > love.graphics.getWidth() - self.img:getWidth()) then
            self.dir = "left"
        end
    else
        self.x = self.x - self.speed
        if (self.x < 0) then
            self.dir = "right"
        end
    end
end