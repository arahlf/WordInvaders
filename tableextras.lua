function table.contains(table, item)
    for key, value in pairs(table) do
        if (value == item) then
            return true
        end
    end

    return false
end