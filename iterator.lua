require 'middleclass'

Iterator = class('Iterator')

function Iterator:initialize(list)
    self.list = list
    self.index = 0
end

function Iterator:hasNext()
    return self.index < self.list:size()
end

function Iterator:next()
    self.index = self.index + 1
    return self.list:getAt(self.index)
end

function Iterator:remove()
    self.list:removeAt(self.index)
    self.index = self.index - 1
end