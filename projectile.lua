require 'middleclass'
require 'ImageEntity'

Projectile = class('Projectile', ImageEntity)

function Projectile:initialize(point, image, target, speed)
    Projectile.superclass:initialize(point, image)

    self._target = target
    self._speed = speed
end