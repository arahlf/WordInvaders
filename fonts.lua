require 'middleclass'

local Font = class('Font')

function Font:initialize(fileName, size)
    self._font = love.graphics.newFont(fileName, size)
end

function Font:set()
    love.graphics.setFont(self._font)
end


Fonts = {
    DIAGNOSTICS = Font('resources/fonts/consola.ttf', 12),
    INTRO = Font('resources/fonts/consola.ttf', 24),
    DEFAULT = Font('resources/fonts/arialbd.ttf', 14)
}