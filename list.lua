require 'middleclass'
require 'iterator'

List = class('List')

function List:initialize()
    self.items = {}
    self.iterating = false
end

function List:add(item)
    table.insert(self.items, item)
end

function List:getAt(index)
    return self.items[index]
end

function List:removeAt(index)
    table.remove(self.items, index)
end

function List:size()
    return #self.items
end

function List:iterator()
    return Iterator:new(self)
end
