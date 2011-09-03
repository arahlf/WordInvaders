require 'middleclass'

local Color = class('Color')

function Color:initialize(r, g, b, a)
    self._r = r
    self._g = g
    self._b = b
    self.a = tonumber(a) or 255
end

function Color:set()
    love.graphics.setColor(self._r, self._g, self._b, self._a)
end


Colors = {
    WHITE = Color(255, 255, 255),
    BLACK = Color(0, 0, 0)
}