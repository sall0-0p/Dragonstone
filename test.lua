local search = require(".UwUntuCC.OS.Libraries.SearchEngine")

local result = search("*.lua")
textutils.pagedPrint(textutils.serialise(result))