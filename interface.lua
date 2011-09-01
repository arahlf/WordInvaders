Interface = {}

function Interface.implement(class, interface)
    for method in pairs(interface) do
        if (type(class[method]) ~= 'function') then
            error(string.format('Class %q does not implement required method %q.', class.name, method))
        end
    end
end