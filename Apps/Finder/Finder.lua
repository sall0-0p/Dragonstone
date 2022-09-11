--  _  _             _ 
-- | || |___ __ _ __| |
-- | __ / -_) _` / _` |
-- |_||_\___\__,_\__,_|
                 
--> Api <--   
shell.setDir(":")
local basalt = require(".BucketOS.OS.Libraries.Basalt")
shell.setDir("BucketOS/Apps/Finder")

local mainFrame = basalt.createFrame():show()
local Window = mainFrame:addFrame():show()

local sidePanel = Window:addFrame():show()
local FilesFrame = Window:addFrame():show()
sidePanel:setPosition(1,2)
sidePanel:setSize(13,18)
sidePanel:setBackground(colors.black)

FilesFrame:setPosition(14,2)
FilesFrame:setSize(38,18)
FilesFrame:setBackground(colors.black)
Window:show()
--basalt.debug("Debug Working")
--> Values <--
local arg = { ... }

local function Update()
	basalt.autoUpdate()
end

-- disks

--local DiskL = false
--local DiskR = false
--local DiskT = false -- they are unused so far

-- Files Values

local Directory = arg[1]
local file

if Directory == nil then
	Directory = "BucketOS/User/Documents"
end

local path = "/"..fs.getName(fs.getDir(Directory)).."/"..fs.getName(Directory) -- getting last to elements to show in UI

-- Settings

local TimeFormat = true -- Clock Format: false - 12h; true - 24h;
local ModemSide = "back"
local ShowHidden = false -- Mode that shows hidded dirs
local DoubleClickTimeout = 0.5

-- Theme (dont do anything)
basalt.setTheme({ -- The default main theme for basalt!
    BasaltBG = colors.lightGray,
    BasaltText = colors.black,
    FrameBG = colors.gray,
    FrameText = colors.black,
    ButtonBG = colors.gray,
    ButtonText = colors.black,
    CheckboxBG = colors.gray,
    CheckboxText = colors.black,
    InputBG = colors.gray,
    InputText = colors.black,
    TextfieldBG = colors.gray,
    TextfieldText = colors.black,
    ListBG = colors.black,
    ListText = colors.white,
    MenubarBG = colors.gray,
    MenubarText = colors.black,
    DropdownBG = colors.gray,
    DropdownText = colors.black,
    RadioBG = colors.gray,
    RadioText = colors.black,
    SelectionBG = colors.black,
    SelectionText = colors.lightGray,
    GraphicBG = colors.black,
    ImageBG = colors.black,
    PaneBG = colors.black,
    ProgramBG = colors.black,
    ProgressbarBG = colors.gray,
    ProgressbarText = colors.black,
    ProgressbarActiveBG = colors.black,
    ScrollbarBG = colors.lightGray,
    ScrollbarText = colors.gray,
    ScrollbarSymbolColor = colors.black,
    SliderBG = colors.lightGray,
    SliderText = colors.gray,
    SliderSymbolColor = colors.black,
    SwitchBG = colors.lightGray,
    SwitchText = colors.gray,
    SwitchBGSymbol = colors.black,
    SwitchInactive = colors.red,
    SwitchActive = colors.green,
    
})
--  ___ _   _ _  _  ___ _____ ___ ___  _  _ ___ 
-- | __| | | | \| |/ __|_   _|_ _/ _ \| \| / __|
-- | _|| |_| | .` | (__  | |  | | (_) | .` \__ \
-- |_|  \___/|_|\_|\___| |_| |___\___/|_|\_|___/

 -- _            _                            
 --|_ o |  _    |_    ._   _ _|_ o  _  ._   _ 
 --|  | | (/_   | |_| | | (_  |_ | (_) | | _> 

--[[ local function LoadFiles()
	local FileList = fs.list(Directory)
	local tDirectories = {}
	local tFiles = {}
	local Files = Window:addList()
		-- Settings
		Files:setPosition(16,4)
		Files:setSize(24,15)
		Files:setBackground(colors.black)
		Files:setForeground(colors.white)

		-- Load Files
		for _, file in pairs(FileList) do
			if ShowHidden or string.sun(file, 1, 1) ~= "." then
				if fs.isDir(Directory.."/"..file) then
					table.insert(tDirectories, file)
				else
					table.insert(tFiles, file)
				end
			end
		end
		basalt.debug("Loaded")
		-- Paste Files
		for _, directory in pairs(tDirectories) do
			Files:addItem("/ "..directory,colors.black,colors.blue)
			basalt.debug("Added Directory")
		end
		for _, file in pairs(tFiles) do
			Files:addItem("/"..file,colors.black,colors.white)
			basalt.debug("Added Files")
		end
		basalt.debug("Added All!")
end ]]--

local Finder = FilesFrame:addFrame()
	Finder:setPosition(3,3)
	Finder:setSize(24,15)
	Finder:setBackground(colors.black)
	--Finder:addLabel():setText("Hello Kitty!"):setPosition(1,1):setBackground(colors.black):setForeground(colors.white)

local Files = Finder:addList()
	-- Settings
	Files:setPosition(1,1)
	Files:setSize(24,15)
	Files:setBackground(colors.black)
	Files:setForeground(colors.white)
	Files:setSelectedItem(colors.black,colors.orange, true)
	Files:setScrollable(true)

local function LoadFiles()
	local FileList = fs.list(Directory)
    local y1 = 4
    Files:selectItem(nil)

        for _, file in pairs(FileList) do
           if fs.isDir(Directory.."/"..file) == true then
             Files:addItem("/ "..file,colors.black,colors.blue)
           else
          	 Files:addItem("/ "..file,colors.black,colors.white)
           end
         y1 = y1 + 1
        end
end

local function open(dir)
	shell.setDir("BucketOS/Apps/Finder")
	shell.run("Finder.lua", dir)
end

local function edit(file)
	local FileList = fs.list(Directory)
	local SelectedFile = FileList[Files:getItemIndex(1)]
	if fs.isDir(Directory.."/"..SelectedFile) then
		open(Directory.."/"..SelectedFile)
	else
		if SelectedFile ~= nil then
			shell.run("edit", SelectedFile)
			shell.setDir("BucketOS/Apps/Finder")
			shell.run("Finder", Directory)
		end
	end

end

mainFrame:onKey(function(self, event, key) 
local SelectedID = Files:getItemIndex()
local FileList = fs.list(Directory)
local SelectedFile = FileList[SelectedID]
	if key == keys.enter then
		if SelectedFile ~= nil then
		edit(Directory.."/"..SelectedFile)
		end
	end
    ---------------
	if key == keys.down then
		if table.getn(FileList) ~= 0 then
			if SelectedID ~= table.getn(FileList) then
				Files:selectItem(SelectedID+1)
			end
		end
	end

	if key == keys.up then
		if table.getn(FileList) ~= 0 then
			if SelectedID ~= 1 then
			Files:selectItem(SelectedID-1)
			end
		end
	end

	if key == keys.r then
		local FileList = fs.list(Directory)
		local SelectedID = Files:getItemIndex()
		local SelectedFile = FileList[SelectedID]
		if  fs.isDir(Directory.."/"..SelectedFile) == true then
		elseif string.find(SelectedFile, ".lua") or string.find(SelectedFile, ".") ~= false then
			shell.setDir(Directory)
			shell.run(SelectedFile)
		else
		end
	end
end)

--  _      ___   _____  _   _ _____ 
-- | |    /_\ \ / / _ \| | | |_   _|
-- | |__ / _ \ V / (_) | |_| | | |  
-- |____/_/ \_\_| \___/ \___/  |_|  

		-- Finder Main Window --

Window:setBackground(colors.black)
-- Bar Settings
Window:setBar("    |        |     ", colors.black, colors.lightGray)
Window:showBar(true)   
-- Bar Buttons
local ButtonB = Window:addButton() -- ß button
	ButtonB:setText("ßoS")
	ButtonB:setForeground(colors.orange)
	ButtonB:setBackground(colors.black)
	ButtonB:setPosition(1,1)
	ButtonB:setSize(3,1)

local ButtonFinder = Window:addButton() -- Finder button
	ButtonFinder:setText("Finder")
	ButtonFinder:setForeground(colors.lightGray)
	ButtonFinder:setBackground(colors.black)
	ButtonFinder:setPosition(7,1)
	ButtonFinder:setSize(6,1)

local ButtonFile = Window:addButton() -- File Button
	ButtonFile:setText("File")
	ButtonFile:setForeground(colors.lightGray)
	ButtonFile:setBackground(colors.black)
	ButtonFile:setPosition(16,1)
	ButtonFile:setSize(4,1)

local ButtonReload = Window:addButton()
	ButtonReload:setText("®")
	ButtonReload:setForeground(colors.lightGray)
	ButtonReload:setBackground(colors.black)
	ButtonReload:setPosition(37,1)
	ButtonReload:setSize(1,1)

	ButtonReload:onClick(function() 
		shell.setDir("BucketOS/Apps/Finder")
		shell.run("Update")
	end)

local ButtonInternet = Window:addButton() 
	ButtonInternet:setText("¥")  

	if rednet.isOpen(ModemSide) then	-- check if connected to RedNet
		ButtonInternet:setForeground(colors.lightGray)  
	else
		ButtonInternet:setForeground(colors.gray)
	end

	ButtonInternet:setBackground(colors.black)       
	ButtonInternet:setPosition(39,1)
	ButtonInternet:setSize(1,1)

local ParagraphLabel = Window:addLabel():setText("¶")
	ParagraphLabel:setForeground(colors.lightGray)  
	ParagraphLabel:setBackground(colors.black)
	ParagraphLabel:setPosition(41,1)
	ParagraphLabel:setSize(1,1)           

--[[local ButtonClose = Window:addButton()
	ButtonClose:setText("x")
	ButtonClose:setForeground(colors.red)
	ButtonClose:setBackground(colors.black)
	ButtonClose:setPosition(51,1)
	ButtonClose:setSize(1,1) ]]-- -- Exit button will be in window manager program, not in Finder ¯\_(?)_/¯

-- Side Panel

local HideButton = FilesFrame:addButton()
	HideButton:setBackground(colors.black)
	HideButton:setForeground(colors.orange)
	HideButton:setSize(1,1)
	HideButton:setPosition(2,18)
	HideButton:setText("\17")

local ShowButton = FilesFrame:addButton():hide()
	ShowButton:setBackground(colors.black)
	ShowButton:setForeground(colors.orange)
	ShowButton:setSize(1,1)
	ShowButton:setPosition(2,18)
	ShowButton:setText("\16")

	local SideHideAnim = Window:addAnimation()
	local SideShowAnim = Window:addAnimation()
		--- Setting Hide Animation
			--SideHideAnim:setObject(sidePanel)
			--SideHideAnim:move(-13,2,1)
			SideHideAnim:setObject(FilesFrame)
			SideHideAnim:move(1,2,1.2):onDone(function() HideButton:hide() ShowButton:show() end)

		--- Setting Show Animation
		--SideShowAnim:setObject(sidePanel)
		--SideShowAnim:move(1,2,1)
		SideShowAnim:setObject(FilesFrame)
		SideShowAnim:move(14,2,1.2)
		SideShowAnim:onDone(function() ShowButton:hide() HideButton:show() end)

HideButton:onClickUp(function() SideHideAnim:play() end)
ShowButton:onClickUp(function() SideShowAnim:play() end)

local SidePane = FilesFrame:addLabel()
	SidePane:setSize(1,18)
	SidePane:setText("|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n")
	SidePane:setForeground(colors.orange)
	SidePane:setPosition(1,1)

local Favourites = sidePanel:addList()
	-- Items
	Favourites:addItem(" Desktop",colors.gray,colors.white)
	Favourites:addItem(" Documents",colors.gray,colors.white)
	Favourites:addItem(" Downloads",colors.gray,colors.white)
	Favourites:addItem(" Apps",colors.gray,colors.white)
	Favourites:setSelectedItem(colors.orange, colors.black, true)


local function SidePane1() -- change Directory
	if Favourites:getItemIndex() == 1 then
		open("BucketOS/User/Desktop")
	end
	if Favourites:getItemIndex() == 2 then
		open("BucketOS/User/Documents")
	end
	if Favourites:getItemIndex() == 3 then
		open("BucketOS/User/Downloads")
	end
	if Favourites:getItemIndex() == 4 then
		open("BucketOS/Apps")
	end
end


if Directory == "BucketOS/User/Desktop" then
	Favourites:selectItem(1)
elseif Directory == "BucketOS/User/Documents" then
	Favourites:selectItem(2)
elseif Directory == "BucketOS/User/Downloads" then
	Favourites:selectItem(3)
elseif Directory == "BucketOS/Apps" then
	Favourites:selectItem(4)
else
	Favourites:selectItem(nil)
end

	-- Settings

	Favourites:setSize(11,4)
	Favourites:setPosition(2,2)

	Favourites:onChange(SidePane1)

-- Disks Panel!

local DiskList = sidePanel:addList()
	DiskList:setBackground(colors.black)
	DiskList:setForeground(colors.white)
		DiskList:addItem(" Disk C:",colors.gray,colors.white)
	if disk.hasData("left") then
		DiskList:addItem(" Disk L:",colors.gray,colors.white)
	end
	if disk.hasData("right") then
		DiskList:addItem(" Disk R:",colors.gray,colors.white)
	end
	if disk.hasData("top") then
		DiskList:addItem(" Disk T:",colors.gray,colors.white)
	end
	if disk.hasData("left") or disk.hasData("right") or disk.hasData("top") then
		DiskList:setSelectedItem(colors.gray, colors.orange, true)
	end -- selected Design

local function DiskList1()
	if DiskList:getItemIndex() == 1 then
		open(":")
	end
	if DiskList:getItemIndex() == 2 then
		open("disk3")
	end
	if DiskList:getItemIndex() == 3 then
		open("disk2")
	end
	if DiskList:getItemIndex() == 4 then
		open("disk")
	end
end

	if Directory == ":" then
		DiskList:selectItem(1)
	elseif Directory == "disk3" then
		DiskList:selectItem(2)
	elseif Directory == "disk2" then
		DiskList:selectItem(3)
	elseif Directory == "disk" then
		DiskList:selectItem(4)
	else
		DiskList:selectItem(nil)
	end

-- Settings
	DiskList:setSize(11,4)
	DiskList:setPosition(2,9)

	DiskList:onChange(DiskList1)

local DownloadButton = sidePanel:addButton()
	DownloadButton:setText("[\25]")
	DownloadButton:setForeground(colors.lime)
	DownloadButton:setPosition(2,17)
	DownloadButton:setSize(3,1)
	DownloadButton:setBackground(colors.black)

local UploadButton = sidePanel:addButton()
	UploadButton:setText("[\24]")
	UploadButton:setForeground(colors.red)
	UploadButton:setPosition(6,17)
	UploadButton:setSize(3,1)
	UploadButton:setBackground(colors.black)



	-- Main Part
local PathLabel = FilesFrame:addLabel() -- Path
	PathLabel:setText(path)
	PathLabel:setBackground(colors.black)
	PathLabel:setForeground(colors.orange)
	PathLabel:setPosition(3,1)


local MemoryLabel = FilesFrame:addLabel()
	MemoryLabel:setBackground(colors.black)
	MemoryLabel:setForeground(colors.lightGray)
	MemoryLabel:setPosition(4,18)
	MemoryLabel:setText("")

local function UpdateMemory()
	local SelectedID = Files:getItemIndex()
	local FileList = fs.list(Directory)
	local SelectedFile = FileList[SelectedID]
	local SpaceLeft = fs.getFreeSpace(Directory)
	local SpaceLeftFormatted = math.floor(SpaceLeft/1024 + 0.5)
	if SelectedFile == nil then

	else
		if fs.isDir(Directory.."/"..SelectedFile) then
			FileList2 = fs.list(Directory.."/"..SelectedFile)
			local nFileList2 = table.getn(FileList2)
			MemoryLabel:setText("Contains "..nFileList2.." items | "..SpaceLeftFormatted.." KB left")
		else
			if string.find(SelectedFile, ".lua") then
				MemoryLabel:setText("Lua script | "..SpaceLeftFormatted.." KB left")
			elseif string.find(SelectedFile, ".") == false then
				MemoryLabel:setText("App | "..SpaceLeftFormatted.." KB left")
			elseif string.find(SelectedFile, ".txt") then
				MemoryLabel:setText("Text File | "..SpaceLeftFormatted.." KB left")
			elseif string.find(SelectedFile, ".nfp") then
				MemoryLabel:setText("Image | "..SpaceLeftFormatted.." KB left")
			elseif string.find(SelectedFile, ".xml") then
				MemoryLabel:setText("XML file | "..SpaceLeftFormatted.." KB left")
			elseif string.find(SelectedFile, ".nbs") then
				MemoryLabel:setText("NBS file (Music) | "..SpaceLeftFormatted.." KB left")
			else
				MemoryLabel:setText(SpaceLeftFormatted.." KB left")
			end
		end
	end
end

Files:onChange(UpdateMemory)

local UndoButton = FilesFrame:addButton()
	UndoButton:setText("<-")
	UndoButton:setBackground(colors.black)
	UndoButton:setPosition(35,1)
	UndoButton:setSize(2,1)

	if Directory == ":" then
		UndoButton:setForeground(colors.gray)
	else
		UndoButton:setForeground(colors.orange)
	end

	local function OpenUndo()
		open(fs.getDir(Directory))
	end

	UndoButton:onClickUp(OpenUndo)

local NewFolderButton = FilesFrame:addButton()
	NewFolderButton:setText("+")
	NewFolderButton:setBackground(colors.black)
	NewFolderButton:setPosition(38,1)
	NewFolderButton:setSize(1,1)

	if fs.isReadOnly(Directory) then
		NewFolderButton:setForeground(colors.gray)
	else
		NewFolderButton:setForeground(colors.orange)
	end

function NewFolder()

end

LoadFiles()
Update()