local request = http.get("https://timeapi.io/api/TimeZone/AvailableTimeZones")

local content = textutils.unserialiseJSON(request.readAll())

for k,v in pairs(content)do
    print(v)
    sleep(0.1)
end
request.close()