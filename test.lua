local text = [[
    Your mum asks you
    for permission to
    send notifications
]]


os.queueEvent("notification", "Notifications", text) --, "allow", "reject"
