require 'middleclass'
require 'projectilefactory'
require 'missile'

MissileFactory = class('MissileFactory')

function MissileFactory:initialize(point)
    self._point = point
end

function MissileFactory:create(target)
    return Missile(self._point, target, 10)
end