function table.contains(table, item)
    for key, value in pairs(table) do
        if (value == item) then
            return true
        end
    end

    return false
end

function table.removeItem(tbl, item)
    for index, value in ipairs(tbl) do
        if (value == item) then
            table.remove(tbl, index)
            return
        end
    end
end