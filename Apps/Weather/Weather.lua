local basalt = require(".BucketOS.OS.Libraries.Basalt")
local databaser = require(".BucketOS.OS.Libraries.Databaser.main")

local city = "Lutsk"

-- 76 x 30

local mainFrame = basalt.createFrame()
    
local rw, rh = mainFrame:getSize()

local currentWeather = mainFrame:addFrame()
    :setSize(rw, rh)
    :setBackground(colors.cyan)
    
local TopPanel = mainFrame:addFrame()
    :setSize(rw,1)
    :setBackground(colors.gray)

    local TopLabelBar = mainFrame:addFrame()
        :setSize(rw,1)
        :setPosition(1,2)
        :setBackground(false, "\131", colors.gray)

    local SearchBarPix = TopPanel:addFrame()
        :setPosition(rw.."-18", 1)
        :setBackground(colors.black, "\149", colors.gray)
        :setSize(1,1)
    local SearchBar = TopPanel:addInput()
        :setSize(16,1)
        :setPosition(rw.."-17", 1)
        :setBackground(colors.black)
        :setForeground(colors.white)
        :setDefaultText("Search..", colors.lightGray, colors.black)
    


local BigLabel = currentWeather:addFrame()
    :setSize(15,10)
    :setPosition(5,3)
    :setBackground(false)

    local TodayLabel = BigLabel:addLabel()
        :setText("Today")
        :setPosition(11,3)
        :setForeground(colors.white)
        :setBackground(false)
    local DateLabel = BigLabel:addLabel()
        local date = os.date("%b %d")
        DateLabel:setText(date)
        :setPosition(10,4)
        :setForeground(colors.white)
        :setBackground(false)

    local BigTemperature = BigLabel:addLabel()
        :setPosition(1,4)
        :setForeground(colors.white)
        :setBackground(colors.cyan)
        :setFontSize(2)
        :setText("00\176")

local SunSetBlock = currentWeather:addFrame()
    :setSize(12,4)
    :setPosition(4,9)
    :setBackground(colors.white)
    
    SunSetLabel = SunSetBlock:addLabel()
        :setPosition(2,2)
        :setSize(10,2)
        :setText("Sunset: \nidk")

local SunRiseBlock = currentWeather:addFrame()
    :setSize(12,4)
    :setPosition(4,14)
    :setBackground(colors.white)
        
    SunRiseLabel = SunRiseBlock:addLabel()
        :setPosition(2,2)
        :setSize(10,2)
        :setText("Sunrise: \nidk")

local RainBlock = currentWeather:addFrame()
    :setSize(12,4)
    :setPosition(17,9)
    :setBackground(colors.white)
            
    RainLabel = RainBlock:addLabel()
        :setPosition(2,2)
        :setSize(10,2)
        :setText("Weather: \n idk")

local RainBlock = currentWeather:addFrame()
    :setSize(12,4)
    :setPosition(17,14)
    :setBackground(colors.white)
                
    RainLabel = RainBlock:addLabel()
        :setPosition(2,2)
        :setSize(10,2)
        :setText("Wind: \n idk")

if fs.exists("BucketOS/AppData/Weather/location") then
    fs.open("BucketOS/AppData/Weather/location", "r")
else
    fs.open("BucketOS/AppData/Weather/location", "w")
end
    
local request = http.get("http://api.weatherbit.io/v2.0/current?city="..city.."&key=8cdb39c55d874958b006d5c569865a78")
      
Weather = request.readAll()
Weather = textutils.unserialiseJSON(Weather)

Weather = textutils.serialise(Weather)
Weather = textutils.unserialise(Weather)

basalt.debug(Weather[])

basalt.autoUpdate()

