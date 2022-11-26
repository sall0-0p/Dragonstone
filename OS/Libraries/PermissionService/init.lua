local perm = {}

local failMessageText = [[
    Sorry! But you have no permission for that. Don`t worry! You always can turn off safe mode in settings.
]]

local lockedMessageText = [[
    Sorry! But this file is locked. You CANNOT access it. No way!
]]

perm = {
    notifyFail = function()
        os.queueEvent("notification", "Access Forbited", failMessageText)
    end

    notifyLocked = function()
        os.queueEvent("notification", "File is Locked", lockedMessageText)
    end
}