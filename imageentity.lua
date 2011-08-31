require 'middleclass'
require 'entity'

ImageEntity = class('ImageEntity', Entity)

function ImageEntity:initialize(point, image)
    ImageEntity.superclass.initialize(self, point)

    self._image = image
end

function ImageEntity:getWidth()
    return self._image:getWidth()
end

function ImageEntity:getHeight()
    return self._image:getHeight()
end

function ImageEntity:getImage()
    return self._image
end

function ImageEntity:getCenter()
    return Point(self:getX() + self:getWidth() / 2, self:getY() + self:getHeight() / 2)
end