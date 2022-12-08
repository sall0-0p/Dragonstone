local SortingService = {}

function pairsByKeys(t, f)
    local a = {}
    for n in pairs(t) do
        table.insert(a, n)
    end
    table.sort(a, f)
    local i = 0
    local iter = function ()
        i = i + 1
        if a[i] == nil then
            return nil
        else
            return a[i], t[a[i]]
        end
    end
    return iter
end

SortingService = {

    sort = function (myTable)
        local t = {}
            for title,value in pairsByKeys(myTable) do
                table.insert(t, { title = title, value = value })
            end
        myTable = t
        return myTable
    end

    -- Thats all. Very simple Library just to sort in one line

}

return SortingService