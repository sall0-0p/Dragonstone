local aa={}local ba=true;local ca=require
local da=function(ab)
for bb,cb in pairs(aa)do
if(type(cb)=="table")then for db,_c in pairs(cb)do if(db==ab)then
return _c()end end else if(bb==ab)then return cb()end end end;return ca(ab)end
local _b=function(ab)if(ab~=nil)then return aa[ab]end;return aa end
aa["loadObjects"]=function(...)local ab={}if(ba)then
for db,_c in pairs(_b("objects"))do ab[db]=_c()end;return ab end;local bb=table.pack(...)local cb=fs.getDir(
bb[2]or"Basalt")if(cb==nil)then
error("Unable to find directory "..bb[2]..
" please report this bug to our discord.")end;for db,_c in
pairs(fs.list(fs.combine(cb,"objects")))do
if(_c~="example.lua")then local ac=_c:gsub(".lua","")ab[ac]=da(ac)end end;return ab end
aa["theme"]=function(...)
return
{BasaltBG=colors.lightGray,BasaltText=colors.black,FrameBG=colors.gray,FrameText=colors.black,ButtonBG=colors.gray,ButtonText=colors.black,CheckboxBG=colors.gray,CheckboxText=colors.black,InputBG=colors.gray,InputText=colors.black,TextfieldBG=colors.gray,TextfieldText=colors.black,ListBG=colors.gray,ListText=colors.black,MenubarBG=colors.gray,MenubarText=colors.black,DropdownBG=colors.gray,DropdownText=colors.black,RadioBG=colors.gray,RadioText=colors.black,SelectionBG=colors.black,SelectionText=colors.lightGray,GraphicBG=colors.black,ImageBG=colors.black,PaneBG=colors.black,ProgramBG=colors.black,ProgressbarBG=colors.gray,ProgressbarText=colors.black,ProgressbarActiveBG=colors.black,ScrollbarBG=colors.lightGray,ScrollbarText=colors.gray,ScrollbarSymbolColor=colors.black,SliderBG=false,SliderText=colors.gray,SliderSymbolColor=colors.black,SwitchBG=colors.lightGray,SwitchText=colors.gray,SwitchBGSymbol=colors.black,SwitchInactive=colors.red,SwitchActive=colors.green,LabelBG=false,LabelText=colors.black}end
aa["main"]=function(...)local ab=da("basaltEvent")()local bb=da("Frame")
local cb=da("theme")local db=da("utils")local _c=da("basaltLogs")local ac=db.uuid
local bc=db.createText;local cc=db.tableCount;local dc=300;local _d=50;local ad=term.current()local bd="1.6.2"local cd=fs.getDir(
table.pack(...)[2]or"")
local dd,__a,a_a,b_a,c_a,d_a={},{},{},{},{},{}local _aa,aaa,baa,caa;local daa={}if
not term.isColor or not term.isColor()then
error('Basalt requires an advanced (golden) computer to run.',0)end;local function _ba()caa=false
ad.clear()ad.setCursorPos(1,1)end;local aba=function(bab,cab)
c_a[bab]=cab end
local bba=function(bab)return c_a[bab]end;local cba=function(bab)cb=bab end
local dba=function(bab)return cb[bab]end
local _ca={getMainFrame=function()return _aa end,setVariable=aba,getVariable=bba,getTheme=dba,setMainFrame=function(bab)_aa=bab end,getActiveFrame=function()return aaa end,setActiveFrame=function(bab)aaa=bab end,getFocusedObject=function()return
baa end,setFocusedObject=function(bab)baa=bab end,getMonitorFrame=function(bab)
return a_a[bab]or b_a[bab][1]end,setMonitorFrame=function(bab,cab,dab)if(_aa==cab)then _aa=nil end;if(dab)then
b_a[bab]={cab,sides}else a_a[bab]=cab end
if(cab==nil)then b_a[bab]=nil end end,getBaseTerm=function()
return ad end,stop=_ba,newFrame=bb,getDirectory=function()return cd end}
local aca=function(bab)ad.clear()ad.setBackgroundColor(colors.black)
ad.setTextColor(colors.red)local cab,dab=ad.getSize()if(daa.logging)then _c(bab,"Error")end;local _bb=bc(
"Basalt error: "..bab,cab)local abb=1;for bbb,cbb in pairs(_bb)do
ad.setCursorPos(1,abb)ad.write(cbb)abb=abb+1 end;ad.setCursorPos(1,
abb+1)caa=false end
local function bca(bab,cab,dab,_bb,abb)
if(#d_a>0)then local bbb={}
for n=1,#d_a do
if(d_a[n]~=nil)then
if
(coroutine.status(d_a[n])=="suspended")then
local cbb,dbb=coroutine.resume(d_a[n],bab,cab,dab,_bb,abb)if not(cbb)then aca(dbb)end else table.insert(bbb,n)end end end
for n=1,#bbb do table.remove(d_a,bbb[n]- (n-1))end end end
local function cca()if(caa==false)then return end;if(_aa~=nil)then _aa:draw()
_aa:updateTerm()end
for bab,cab in pairs(a_a)do cab:draw()cab:updateTerm()end
for bab,cab in pairs(b_a)do cab[1]:draw()cab[1]:updateTerm()end end;local dca,_da,ada=nil,nil,nil;local bda=nil
local function cda(bab,cab,dab)dca,_da,ada=dca,cab,dab;if(bda==nil)then
bda=os.startTimer(dc/1000)end end
local function dda()bda=nil;_aa:hoverHandler(_da,ada,dca)aaa=_aa end;local __b,a_b,b_b=nil,nil,nil;local c_b=nil
local function d_b(bab,cab,dab)__b,a_b,b_b=bab,cab,dab;if(c_b==nil)then
c_b=os.startTimer(_d/1000)end end
local function _ab()c_b=nil;_aa:dragHandler(__b,a_b,b_b)aaa=_aa end
local function aab(bab,cab,dab,_bb,abb)if
(ab:sendEvent("basaltEventCycle",bab,cab,dab,_bb,abb)==false)then return end
if(_aa~=nil)then
if(bab=="mouse_click")then
_aa:mouseHandler(cab,dab,_bb,false)aaa=_aa elseif(bab=="mouse_drag")then d_b(cab,dab,_bb)elseif(bab=="mouse_up")then
_aa:mouseUpHandler(cab,dab,_bb,abb)aaa=_aa elseif(bab=="mouse_scroll")then
_aa:scrollHandler(cab,dab,_bb,abb)aaa=_aa elseif(bab=="mouse_move")then cda(cab,dab,_bb)end end
if(bab=="monitor_touch")then if(a_a[cab]~=nil)then
a_a[cab]:mouseHandler(1,dab,_bb,true)aaa=a_a[cab]end
if(cc(b_a)>0)then for bbb,cbb in pairs(b_a)do
cbb[1]:mouseHandler(1,dab,_bb,true,cab)end end end
if(bab=="char")then if(aaa~=nil)then aaa:charHandler(cab)end end;if(bab=="key_up")then if(aaa~=nil)then aaa:keyUpHandler(cab)end
dd[cab]=false end;if(bab=="key")then if(aaa~=nil)then
aaa:keyHandler(cab,dab)end;dd[cab]=true end
if(
bab=="terminate")then if(aaa~=nil)then aaa:eventHandler(bab)
if(caa==false)then return end end end
if




(bab~="mouse_click")and(bab~="mouse_up")and(bab~="mouse_scroll")and(bab~="mouse_drag")and
(bab~="mouse_move")and(bab~="key")and(bab~="key_up")and(bab~="char")and(bab~="terminate")then
if(bab=="timer")and(cab==bda)then dda()elseif(bab=="timer")and(cab==c_b)then
_ab()else
for bbb,cbb in pairs(__a)do cbb:eventHandler(bab,cab,dab,_bb,abb)end end end;bca(bab,cab,dab,_bb,abb)cca()end
daa={logging=false,setTheme=cba,getTheme=dba,drawFrames=cca,getVersion=function()return bd end,setVariable=aba,getVariable=bba,setBaseTerm=function(bab)ad=bab end,log=function(...)_c(...)end,setMouseMoveThrottle=function(bab)
if
(_HOST:find("CraftOS%-PC"))then if(config.get("mouse_move_throttle")~=10)then
config.set("mouse_move_throttle",10)end
if(bab<100)then dc=100 else dc=bab end;return true end;return false end,setMouseDragThrottle=function(bab)if(
bab<50)then _d=50 else _d=bab end end,autoUpdate=function(bab)caa=bab;if
(bab==nil)then caa=true end;local function cab()cca()
while caa do aab(os.pullEventRaw())end end
local dab,_bb=xpcall(cab,debug.traceback)if not(dab)then aca(_bb)return end end,update=function(bab,cab,dab,_bb,abb)
if(
bab~=nil)then
local bbb,cbb=xpcall(aab,debug.traceback,bab,cab,dab,_bb,abb)if not(bbb)then aca(cbb)return end end end,stop=_ba,stopUpdate=_ba,isKeyDown=function(bab)if(
dd[bab]==nil)then return false end;return dd[bab]end,getFrame=function(bab)for cab,dab in
pairs(__a)do if(dab.name==bab)then return dab end end end,getActiveFrame=function()return
aaa end,setActiveFrame=function(bab)
if(bab:getType()=="Frame")then aaa=bab;return true end;return false end,onEvent=function(...)
for bab,cab in
pairs(table.pack(...))do if(type(cab)=="function")then
ab:registerEvent("basaltEventCycle",cab)end end end,schedule=function(bab)
assert(bab~=
"function","Schedule needs a function in order to work!")return
function(...)local cab=coroutine.create(bab)
local dab,_bb=coroutine.resume(cab,...)if(dab)then table.insert(d_a,cab)else aca(_bb)end end end,createFrame=function(bab)bab=
bab or ac()
for dab,_bb in pairs(__a)do if(_bb.name==bab)then return nil end end;local cab=bb(bab,nil,nil,_ca)cab:init()
table.insert(__a,cab)if
(_aa==nil)and(cab:getName()~="basaltDebuggingFrame")then cab:show()end;return cab end,removeFrame=function(bab)__a[bab]=
nil end,setProjectDir=function(bab)cd=bab end,debug=function(...)local bab={...}if(_aa==nil)then print(...)
return end
if(_aa.name~="basaltDebuggingFrame")then if(_aa~=daa.debugFrame)then
daa.debugLabel:setParent(_aa)end end;local cab=""
for dab,_bb in pairs(bab)do cab=cab..
tostring(_bb).. (#bab~=dab and", "or"")end;daa.debugLabel:setText("[Debug] "..cab)
for dab,_bb in
pairs(bc(cab,daa.debugList:getWidth()))do daa.debugList:addItem(_bb)end;if(daa.debugList:getItemCount()>50)then
daa.debugList:removeItem(1)end
daa.debugList:setValue(daa.debugList:getItem(daa.debugList:getItemCount()))if
(daa.debugList.getItemCount()>daa.debugList:getHeight())then
daa.debugList:setOffset(daa.debugList:getItemCount()-
daa.debugList:getHeight())end
daa.debugLabel:show()end}
daa.debugFrame=daa.createFrame("basaltDebuggingFrame"):showBar():setBackground(colors.lightGray):setBar("Debug",colors.black,colors.gray)
daa.debugFrame:addButton("back"):setAnchor("topRight"):setSize(1,1):setText("\22"):onClick(function()if(
daa.oldFrame~=nil)then daa.oldFrame:show()end end):setBackground(colors.red):show()
daa.debugList=daa.debugFrame:addList("debugList"):setSize("parent.w - 2","parent.h - 3"):setPosition(2,3):setScrollable(true):show()
daa.debugLabel=daa.debugFrame:addLabel("debugLabel"):onClick(function()
daa.oldFrame=_aa;daa.debugFrame:show()end):setBackground(colors.black):setForeground(colors.white):setAnchor("bottomLeft"):ignoreOffset():setZIndex(20):show()return daa end
aa["Object"]=function(...)local ab=da("basaltEvent")local bb=da("utils")
local cb=bb.splitString;local db=bb.numberFromString;local _c=bb.getValueFromXML
return
function(ac)local bc="Object"local cc={}local dc=1
local _d;local ad="topLeft"local bd=false;local cd=true;local dd=false;local __a=false;local a_a=false
local b_a={left=false,right=false,top=false,bottom=false}local c_a=colors.black;local d_a=true;local _aa=false;local aaa,baa,caa,daa=0,0,0,0;local _ba=true;local aba={}
local bba=ab()
cc={x=1,y=1,width=1,height=1,bgColor=colors.black,bgSymbol=" ",bgSymbolColor=colors.black,fgColor=colors.white,transparentColor=false,name=ac or"Object",parent=nil,show=function(cba)cd=true
cba:updateDraw()return cba end,hide=function(cba)cd=false;cba:updateDraw()return cba end,enable=function(cba)
d_a=true;return cba end,disable=function(cba)d_a=false;return cba end,isEnabled=function(cba)return d_a end,generateXMLEventFunction=function(cba,dba,_ca)
local aca=function(bca)
if(
bca:sub(1,1)=="#")then
local cca=cba:getBaseFrame():getDeepObject(bca:sub(2,bca:len()))
if(cca~=nil)and(cca.internalObjetCall~=nil)then dba(cba,function()
cca:internalObjetCall()end)end else
dba(cba,cba:getBaseFrame():getVariable(bca))end end;if(type(_ca)=="string")then aca(_ca)elseif(type(_ca)=="table")then
for bca,cca in pairs(_ca)do aca(cca)end end;return cba end,setValuesByXMLData=function(cba,dba)
local _ca=cba:getBaseFrame()if(_c("x",dba)~=nil)then
cba:setPosition(_c("x",dba),cba.y)end;if(_c("y",dba)~=nil)then
cba:setPosition(cba.x,_c("y",dba))end;if(_c("width",dba)~=nil)then
cba:setSize(_c("width",dba),cba.height)end;if(_c("height",dba)~=nil)then
cba:setSize(cba.width,_c("height",dba))end;if(_c("bg",dba)~=nil)then
cba:setBackground(colors[_c("bg",dba)])end;if(_c("fg",dba)~=nil)then
cba:setForeground(colors[_c("fg",dba)])end;if(_c("value",dba)~=nil)then
cba:setValue(colors[_c("value",dba)])end
if(_c("visible",dba)~=nil)then if
(_c("visible",dba))then cba:show()else cba:hide()end end
if(_c("enabled",dba)~=nil)then if(_c("enabled",dba))then cba:enable()else
cba:disable()end end;if(_c("zIndex",dba)~=nil)then
cba:setZIndex(_c("zIndex",dba))end;if(_c("anchor",dba)~=nil)then
cba:setAnchor(_c("anchor",dba))end;if(_c("shadowColor",dba)~=nil)then
cba:setShadow(colors[_c("shadowColor",dba)])end;if(_c("border",dba)~=nil)then
cba:setBorder(colors[_c("border",dba)])end;if(_c("borderLeft",dba)~=nil)then
b_a["left"]=_c("borderLeft",dba)end;if(_c("borderTop",dba)~=nil)then
b_a["top"]=_c("borderTop",dba)end;if(_c("borderRight",dba)~=nil)then
b_a["right"]=_c("borderRight",dba)end;if(_c("borderBottom",dba)~=nil)then
b_a["bottom"]=_c("borderBottom",dba)end;if(_c("borderColor",dba)~=nil)then
cba:setBorder(colors[_c("borderColor",dba)])end;if
(_c("ignoreOffset",dba)~=nil)then
if(_c("ignoreOffset",dba))then cba:ignoreOffset(true)end end;if
(_c("onClick",dba)~=nil)then
cba:generateXMLEventFunction(cba.onClick,_c("onClick",dba))end;if
(_c("onClickUp",dba)~=nil)then
cba:generateXMLEventFunction(cba.onClickUp,_c("onClickUp",dba))end;if
(_c("onScroll",dba)~=nil)then
cba:generateXMLEventFunction(cba.onScroll,_c("onScroll",dba))end;if
(_c("onDrag",dba)~=nil)then
cba:generateXMLEventFunction(cba.onDrag,_c("onDrag",dba))end;if(_c("onHover",dba)~=nil)then
cba:generateXMLEventFunction(cba.onHover,_c("onHover",dba))end;if
(_c("onLeave",dba)~=nil)then
cba:generateXMLEventFunction(cba.onLeave,_c("onLeave",dba))end;if(_c("onKey",dba)~=nil)then
cba:generateXMLEventFunction(cba.onKey,_c("onKey",dba))end;if(_c("onKeyUp",dba)~=nil)then
cba:generateXMLEventFunction(cba.onKeyUp,_c("onKeyUp",dba))end;if
(_c("onChange",dba)~=nil)then
cba:generateXMLEventFunction(cba.onChange,_c("onChange",dba))end;if
(_c("onResize",dba)~=nil)then
cba:generateXMLEventFunction(cba.onResize,_c("onResize",dba))end;if
(_c("onReposition",dba)~=nil)then
cba:generateXMLEventFunction(cba.onReposition,_c("onReposition",dba))end;if
(_c("onEvent",dba)~=nil)then
cba:generateXMLEventFunction(cba.onEvent,_c("onEvent",dba))end;if
(_c("onGetFocus",dba)~=nil)then
cba:generateXMLEventFunction(cba.onGetFocus,_c("onGetFocus",dba))end;if
(_c("onLoseFocus",dba)~=nil)then
cba:generateXMLEventFunction(cba.onLoseFocus,_c("onLoseFocus",dba))end
cba:updateDraw()return cba end,isVisible=function(cba)return
cd end,setFocus=function(cba)if(cba.parent~=nil)then
cba.parent:setFocusedObject(cba)end;return cba end,setZIndex=function(cba,dba)
dc=dba
if(cba.parent~=nil)then cba.parent:removeObject(cba)
cba.parent:addObject(cba)cba:updateEventHandlers()end;return cba end,updateEventHandlers=function(cba)
for dba,_ca in
pairs(aba)do if(_ca)then cba.parent:addEvent(dba,cba)end end end,getZIndex=function(cba)return dc end,getType=function(cba)return bc end,getName=function(cba)return
cba.name end,remove=function(cba)if(cba.parent~=nil)then
cba.parent:removeObject(cba)end;cba:updateDraw()return cba end,setParent=function(cba,dba)
if(
dba.getType~=nil and dba:getType()=="Frame")then
cba:remove()dba:addObject(cba)if(cba.draw)then cba:show()end end;return cba end,setValue=function(cba,dba)
if(
_d~=dba)then _d=dba;cba:updateDraw()cba:valueChangedHandler()end;return cba end,getValue=function(cba)return _d end,getDraw=function(cba)return
_ba end,updateDraw=function(cba,dba)_ba=dba;if(dba==nil)then _ba=true end;if(_ba)then if(cba.parent~=nil)then
cba.parent:updateDraw()end end;return cba end,getEventSystem=function(cba)return
bba end,getParent=function(cba)return cba.parent end,setPosition=function(cba,dba,_ca,aca)
if(type(dba)=="number")then cba.x=
aca and cba:getX()+dba or dba end;if(type(_ca)=="number")then
cba.y=aca and cba:getY()+_ca or _ca end
if(cba.parent~=nil)then if(type(dba)=="string")then
cba.x=cba.parent:newDynamicValue(cba,dba)end;if(type(_ca)=="string")then
cba.y=cba.parent:newDynamicValue(cba,_ca)end
cba.parent:recalculateDynamicValues()end;bba:sendEvent("basalt_reposition",cba)
cba:updateDraw()return cba end,getX=function(cba)return

type(cba.x)=="number"and cba.x or math.floor(cba.x[1]+0.5)end,getY=function(cba)return

type(cba.y)=="number"and cba.y or math.floor(cba.y[1]+0.5)end,getPosition=function(cba)return
cba:getX(),cba:getY()end,getVisibility=function(cba)return cd end,setVisibility=function(cba,dba)
cd=dba or not cd;cba:updateDraw()return cba end,setSize=function(cba,dba,_ca,aca)if(type(dba)==
"number")then
cba.width=aca and cba:getWidth()+dba or dba end
if(type(_ca)=="number")then cba.height=aca and
cba:getHeight()+_ca or _ca end
if(cba.parent~=nil)then if(type(dba)=="string")then
cba.width=cba.parent:newDynamicValue(cba,dba)end;if(type(_ca)=="string")then
cba.height=cba.parent:newDynamicValue(cba,_ca)end
cba.parent:recalculateDynamicValues()end;bba:sendEvent("basalt_resize",cba)
cba:updateDraw()return cba end,getHeight=function(cba)
return
type(cba.height)=="number"and cba.height or
math.floor(cba.height[1]+0.5)end,getWidth=function(cba)return

type(cba.width)=="number"and cba.width or math.floor(cba.width[1]+0.5)end,getSize=function(cba)return
cba:getWidth(),cba:getHeight()end,calculateDynamicValues=function(cba)
if(
type(cba.width)=="table")then cba.width:calculate()end
if(type(cba.height)=="table")then cba.height:calculate()end
if(type(cba.x)=="table")then cba.x:calculate()end
if(type(cba.y)=="table")then cba.y:calculate()end;cba:updateDraw()return cba end,setBackground=function(cba,dba,_ca,aca)cba.bgColor=
dba or false
cba.bgSymbol=_ca or(cba.bgColor~=false and cba.bgSymbol or
false)cba.bgSymbolColor=aca or cba.bgSymbolColor
cba:updateDraw()return cba end,setTransparent=function(cba,dba)cba.transparentColor=
dba or false;cba.bgSymbol=false;cba.bgSymbolColor=false
cba:updateDraw()return cba end,getBackground=function(cba)return
cba.bgColor end,setForeground=function(cba,dba)cba.fgColor=dba or false
cba:updateDraw()return cba end,getForeground=function(cba)return cba.fgColor end,setShadow=function(cba,dba)if(
dba==false)then a_a=false else c_a=dba;a_a=true end
cba:updateDraw()return cba end,isShadowActive=function(cba)return a_a end,setBorder=function(cba,...)
if(
...~=nil)then local dba={...}
for _ca,aca in pairs(dba)do if(aca=="left")or(#dba==1)then
b_a["left"]=dba[1]end;if(aca=="top")or(#dba==1)then
b_a["top"]=dba[1]end;if(aca=="right")or(#dba==1)then
b_a["right"]=dba[1]end;if(aca=="bottom")or(#dba==1)then
b_a["bottom"]=dba[1]end end end;cba:updateDraw()return cba end,getBorder=function(cba,dba)if(
dba=="left")then return borderLeft end
if(dba=="top")then return borderTop end;if(dba=="right")then return borderRight end;if(dba=="bottom")then
return borderBottom end end,draw=function(cba)
if
(cd)then
if(cba.parent~=nil)then local dba,_ca=cba:getAnchorPosition()
local aca,bca=cba:getSize()local cca,dca=cba.parent:getSize()
if(dba+aca<1)or(dba>cca)or(_ca+
bca<1)or(_ca>dca)then return false end;if(cba.transparentColor~=false)then
cba.parent:drawForegroundBox(dba,_ca,aca,bca,cba.transparentColor)end;if(cba.bgColor~=false)then
cba.parent:drawBackgroundBox(dba,_ca,aca,bca,cba.bgColor)end
if(cba.bgSymbol~=false)then
cba.parent:drawTextBox(dba,_ca,aca,bca,cba.bgSymbol)if(cba.bgSymbol~=" ")then
cba.parent:drawForegroundBox(dba,_ca,aca,bca,cba.bgSymbolColor)end end
if(a_a)then
cba.parent:drawBackgroundBox(dba+1,_ca+bca,aca,1,c_a)
cba.parent:drawBackgroundBox(dba+aca,_ca+1,1,bca,c_a)
cba.parent:drawForegroundBox(dba+1,_ca+bca,aca,1,c_a)
cba.parent:drawForegroundBox(dba+aca,_ca+1,1,bca,c_a)end;local _da=cba.bgColor
if(b_a["left"]~=false)then
cba.parent:drawTextBox(dba,_ca,1,bca,"\149")if(_da~=false)then
cba.parent:drawBackgroundBox(dba,_ca,1,bca,cba.bgColor)end
cba.parent:drawForegroundBox(dba,_ca,1,bca,b_a["left"])end
if(b_a["top"]~=false)then
cba.parent:drawTextBox(dba,_ca,aca,1,"\131")if(_da~=false)then
cba.parent:drawBackgroundBox(dba,_ca,aca,1,cba.bgColor)end
cba.parent:drawForegroundBox(dba,_ca,aca,1,b_a["top"])end
if(b_a["left"]~=false)and(b_a["top"]~=false)then
cba.parent:drawTextBox(dba,_ca,1,1,"\151")if(_da~=false)then
cba.parent:drawBackgroundBox(dba,_ca,1,1,cba.bgColor)end
cba.parent:drawForegroundBox(dba,_ca,1,1,b_a["left"])end
if(b_a["right"]~=false)then
cba.parent:drawTextBox(dba+aca-1,_ca,1,bca,"\149")if(_da~=false)then
cba.parent:drawForegroundBox(dba+aca-1,_ca,1,bca,cba.bgColor)end
cba.parent:drawBackgroundBox(dba+aca-1,_ca,1,bca,b_a["right"])end
if(b_a["bottom"]~=false)then
cba.parent:drawTextBox(dba,_ca+bca-1,aca,1,"\143")if(_da~=false)then
cba.parent:drawForegroundBox(dba,_ca+bca-1,aca,1,cba.bgColor)end
cba.parent:drawBackgroundBox(dba,_ca+bca-1,aca,1,b_a["bottom"])end
if(b_a["top"]~=false)and(b_a["right"]~=false)then cba.parent:drawTextBox(
dba+aca-1,_ca,1,1,"\148")if
(_da~=false)then
cba.parent:drawForegroundBox(dba+aca-1,_ca,1,1,cba.bgColor)end
cba.parent:drawBackgroundBox(dba+aca-1,_ca,1,1,b_a["right"])end
if(b_a["right"]~=false)and(b_a["bottom"]~=false)then
cba.parent:drawTextBox(
dba+aca-1,_ca+bca-1,1,1,"\133")if(_da~=false)then
cba.parent:drawForegroundBox(dba+aca-1,_ca+bca-1,1,1,cba.bgColor)end
cba.parent:drawBackgroundBox(dba+aca-1,
_ca+bca-1,1,1,b_a["right"])end
if(b_a["bottom"]~=false)and(b_a["left"]~=false)then cba.parent:drawTextBox(dba,
_ca+bca-1,1,1,"\138")if(_da~=false)then
cba.parent:drawForegroundBox(
dba-1,_ca+bca-1,1,1,cba.bgColor)end
cba.parent:drawBackgroundBox(dba,_ca+bca-1,1,1,b_a["left"])end end;_ba=false;return true end;return false end,getAbsolutePosition=function(cba,dba,_ca)
if(
dba==nil)or(_ca==nil)then dba,_ca=cba:getAnchorPosition()end
if(cba.parent~=nil)then
local aca,bca=cba.parent:getAbsolutePosition()dba=aca+dba-1;_ca=bca+_ca-1 end;return dba,_ca end,getAnchorPosition=function(cba,dba,_ca,aca)if(
dba==nil)then dba=cba:getX()end
if(_ca==nil)then _ca=cba:getY()end
if(cba.parent~=nil)then local bca,cca=cba.parent:getSize()
if(ad=="top")then dba=math.floor(
bca/2)+dba-1 elseif(ad=="topRight")then
dba=bca+dba-1 elseif(ad=="right")then dba=bca+dba-1
_ca=math.floor(cca/2)+_ca-1 elseif(ad=="bottomRight")then dba=bca+dba-1;_ca=cca+_ca-1 elseif(ad=="bottom")then dba=math.floor(
bca/2)+dba-1;_ca=cca+_ca-1 elseif(ad==
"bottomLeft")then _ca=cca+_ca-1 elseif(ad=="left")then
_ca=math.floor(cca/2)+_ca-1 elseif(ad=="center")then dba=math.floor(bca/2)+dba-1;_ca=math.floor(
cca/2)+_ca-1 end;local dca,_da=cba.parent:getOffsetInternal()if not(bd or aca)then return dba+
dca,_ca+_da end end;return dba,_ca end,ignoreOffset=function(cba,dba)
bd=dba;if(dba==nil)then bd=true end;return cba end,getBaseFrame=function(cba)
if(
cba.parent~=nil)then return cba.parent:getBaseFrame()end;return cba end,setAnchor=function(cba,dba)ad=dba
cba:updateDraw()return cba end,getAnchor=function(cba)return ad end,onChange=function(cba,...)
for dba,_ca in
pairs(table.pack(...))do if(type(_ca)=="function")then
cba:registerEvent("value_changed",_ca)end end;return cba end,onClick=function(cba,...)
for dba,_ca in
pairs(table.pack(...))do if(type(_ca)=="function")then
cba:registerEvent("mouse_click",_ca)end end;if(cba.parent~=nil)then
cba.parent:addEvent("mouse_click",cba)aba["mouse_click"]=true end;return
cba end,onClickUp=function(cba,...)for dba,_ca in
pairs(table.pack(...))do
if(type(_ca)=="function")then cba:registerEvent("mouse_up",_ca)end end;if(cba.parent~=nil)then
cba.parent:addEvent("mouse_up",cba)aba["mouse_up"]=true end;return cba end,onScroll=function(cba,...)
for dba,_ca in
pairs(table.pack(...))do if(type(_ca)=="function")then
cba:registerEvent("mouse_scroll",_ca)end end
if(cba.parent~=nil)then
cba.parent:addEvent("mouse_scroll",cba)aba["mouse_scroll"]=true end;return cba end,onHover=function(cba,...)
for dba,_ca in
pairs(table.pack(...))do if(type(_ca)=="function")then
cba:registerEvent("mouse_hover",_ca)end end;if(cba.parent~=nil)then
cba.parent:addEvent("mouse_move",cba)aba["mouse_move"]=true end
return cba end,onLeave=function(cba,...)
for dba,_ca in
pairs(table.pack(...))do if(type(_ca)=="function")then
cba:registerEvent("mouse_leave",_ca)end end;if(cba.parent~=nil)then
cba.parent:addEvent("mouse_move",cba)aba["mouse_move"]=true end
return cba end,onDrag=function(cba,...)
for dba,_ca in
pairs(table.pack(...))do if(type(_ca)=="function")then
cba:registerEvent("mouse_drag",_ca)end end
if(cba.parent~=nil)then
cba.parent:addEvent("mouse_drag",cba)aba["mouse_drag"]=true
cba.parent:addEvent("mouse_click",cba)aba["mouse_click"]=true
cba.parent:addEvent("mouse_up",cba)aba["mouse_up"]=true end;return cba end,onEvent=function(cba,...)
for dba,_ca in
pairs(table.pack(...))do if(type(_ca)=="function")then
cba:registerEvent("other_event",_ca)end end;if(cba.parent~=nil)then
cba.parent:addEvent("other_event",cba)aba["other_event"]=true end;return
cba end,onKey=function(cba,...)
if
(d_a)then for dba,_ca in pairs(table.pack(...))do
if(type(_ca)=="function")then
cba:registerEvent("key",_ca)cba:registerEvent("char",_ca)end end
if
(cba.parent~=nil)then cba.parent:addEvent("key",cba)
cba.parent:addEvent("char",cba)aba["key"]=true;aba["char"]=true end end;return cba end,onResize=function(cba,...)
for dba,_ca in
pairs(table.pack(...))do if(type(_ca)=="function")then
cba:registerEvent("basalt_resize",_ca)end end;return cba end,onReposition=function(cba,...)
for dba,_ca in
pairs(table.pack(...))do if(type(_ca)=="function")then
cba:registerEvent("basalt_reposition",_ca)end end;return cba end,onKeyUp=function(cba,...)for dba,_ca in
pairs(table.pack(...))do
if(type(_ca)=="function")then cba:registerEvent("key_up",_ca)end end;if(cba.parent~=nil)then
cba.parent:addEvent("key_up",cba)aba["key_up"]=true end;return cba end,isFocused=function(cba)if(
cba.parent~=nil)then
return cba.parent:getFocusedObject()==cba end;return false end,onGetFocus=function(cba,...)
for dba,_ca in
pairs(table.pack(...))do if(type(_ca)=="function")then
cba:registerEvent("get_focus",_ca)end end;if(cba.parent~=nil)then
cba.parent:addEvent("mouse_click",cba)aba["mouse_click"]=true end;return
cba end,onLoseFocus=function(cba,...)
for dba,_ca in
pairs(table.pack(...))do if(type(_ca)=="function")then
cba:registerEvent("lose_focus",_ca)end end;if(cba.parent~=nil)then
cba.parent:addEvent("mouse_click",cba)aba["mouse_click"]=true end;return
cba end,registerEvent=function(cba,dba,_ca)return
bba:registerEvent(dba,_ca)end,removeEvent=function(cba,dba,_ca)
return bba:removeEvent(dba,_ca)end,sendEvent=function(cba,dba,...)return bba:sendEvent(dba,cba,...)end,isCoordsInObject=function(cba,dba,_ca)
if
(cd)and(d_a)then if(dba==nil)or(_ca==nil)then return false end
local aca,bca=cba:getAbsolutePosition(cba:getAnchorPosition())local cca,dca=cba:getSize()
if
(aca<=dba)and(aca+cca>dba)and(bca<=_ca)and(bca+dca>_ca)then return true end end;return false end,mouseHandler=function(cba,dba,_ca,aca,bca)
if
(cba:isCoordsInObject(_ca,aca))then
local cca=bba:sendEvent("mouse_click",cba,"mouse_click",dba,_ca,aca,bca)if(cca==false)then return false end;if(cba.parent~=nil)then
cba.parent:setFocusedObject(cba)end;_aa=true;aaa,baa=_ca,aca;return true end;return false end,mouseUpHandler=function(cba,dba,_ca,aca)
_aa=false
if(cba:isCoordsInObject(_ca,aca))then
local bca=bba:sendEvent("mouse_up",cba,"mouse_up",dba,_ca,aca)if(bca==false)then return false end;return true end;return false end,dragHandler=function(cba,dba,_ca,aca)
if
(_aa)then
local bca,cca=cba:getAbsolutePosition(cba:getAnchorPosition())local dca,_da=_ca-bca+1,aca-cca+1
local ada=bba:sendEvent("mouse_drag",cba,"mouse_drag",dba,dca,_da,aaa-_ca,baa-aca,_ca,aca)aaa,baa=_ca,aca;if(ada~=nil)then return ada end;if(cba.parent~=nil)then
cba.parent:setFocusedObject(cba)end;return true end
if(cba:isCoordsInObject(_ca,aca))then
local bca,cca=cba:getAbsolutePosition(cba:getAnchorPosition())aaa,baa=_ca,aca;caa,daa=bca-_ca,cca-aca end;return false end,scrollHandler=function(cba,dba,_ca,aca)
if
(cba:isCoordsInObject(_ca,aca))then
local bca=bba:sendEvent("mouse_scroll",cba,"mouse_scroll",dba,_ca,aca)if(bca==false)then return false end;if(cba.parent~=nil)then
cba.parent:setFocusedObject(cba)end;return true end;return false end,hoverHandler=function(cba,dba,_ca,aca)
if
(cba:isCoordsInObject(dba,_ca))then
local bca=bba:sendEvent("mouse_hover",cba,"mouse_hover",dba,_ca,aca)if(bca==false)then return false end;__a=true;return true end
if(__a)then
local bca=bba:sendEvent("mouse_leave",cba,"mouse_leave",dba,_ca,aca)if(bca==false)then return false end;__a=false end;return false end,keyHandler=function(cba,dba,_ca)if
(d_a)and(cd)then
if(cba:isFocused())then
local aca=bba:sendEvent("key",cba,"key",dba,_ca)if(aca==false)then return false end;return true end end;return
false end,keyUpHandler=function(cba,dba)if
(d_a)and(cd)then
if(cba:isFocused())then
local _ca=bba:sendEvent("key_up",cba,"key_up",dba)if(_ca==false)then return false end;return true end end;return
false end,charHandler=function(cba,dba)if
(d_a)and(cd)then
if(cba:isFocused())then
local _ca=bba:sendEvent("char",cba,"char",dba)if(_ca==false)then return false end;return true end end
return false end,valueChangedHandler=function(cba)
bba:sendEvent("value_changed",cba,_d)end,eventHandler=function(cba,dba,_ca,aca,bca,cca)
local dca=bba:sendEvent("other_event",cba,dba,_ca,aca,bca,cca)if(dca~=nil)then return dca end;return true end,getFocusHandler=function(cba)
local dba=bba:sendEvent("get_focus",cba)if(dba~=nil)then return dba end;return true end,loseFocusHandler=function(cba)
_aa=false;local dba=bba:sendEvent("lose_focus",cba)
if(dba~=nil)then return dba end;return true end,init=function(cba)
if
(cba.parent~=nil)then for dba,_ca in pairs(aba)do
if(_ca)then cba.parent:addEvent(dba,cba)end end end;if not(dd)then dd=true;return true end end}cc.__index=cc;return cc end end
aa["Frame"]=function(...)local ab=da("Object")local bb=da("loadObjects")
local cb=da("basaltDraw")local db=da("utils")local _c=da("layout")local ac=da("basaltMon")
local bc=db.uuid;local cc=db.rpairs;local dc=db.getValueFromXML;local _d=db.tableCount
local ad,bd,cd=string.sub,math.min,math.max
return
function(dd,__a,a_a,b_a)local c_a=ab(dd)local d_a="Frame"local _aa={}local aaa={}local baa={}local caa={}local daa={}local _ba={}local aba={}
local bba={}local cba=0;local dba=a_a or term.current()local _ca=""local aca=false
local bca=false;local cca=false;local dca=0;local _da=0;local ada=false;local bda=0;local cda=false;local dda=false;local __b=""local a_b=false
local b_b=false;local c_b;local d_b;local _ab=true;local aab=true;local bab=false;local cab={}c_a:setZIndex(10)
local dab=cb(dba)local _bb=false;local abb=1;local bbb=1;local cbb=colors.white;local dbb,_cb=0,0;local acb={}local function bcb(dac,_bc)if(_bc~=nil)then
_bc:setValuesByXMLData(dac)end end
local function ccb(dac,_bc,abc)
if(dac~=nil)then if(
dac.properties~=nil)then dac={dac}end
for bbc,cbc in pairs(dac)do
local dbc=_bc(abc,cbc["@id"]or bc())table.insert(acb,dbc)bcb(cbc,dbc)end end end
local function dcb(dac)for _bc,abc in pairs(_aa)do
for bbc,cbc in pairs(abc)do if(cbc:getName()==dac)then return cbc end end end end
local function _db(dac)local _bc=dcb(dac)if(_bc~=nil)then return _bc end
for abc,bbc in pairs(_aa)do
for cbc,dbc in pairs(bbc)do if(
dbc:getType()=="Frame")then local _cc=dbc:getDeepObject(dac)
if(_cc~=nil)then return _cc end end end end end
local function adb(dac)local _bc=dac:getZIndex()
if(dcb(dac.name)~=nil)then return nil end
if(_aa[_bc]==nil)then
for x=1,#aaa+1 do if(aaa[x]~=nil)then if(_bc==aaa[x])then break end;if
(_bc>aaa[x])then table.insert(aaa,x,_bc)break end else
table.insert(aaa,_bc)end end;if(#aaa<=0)then table.insert(aaa,_bc)end;_aa[_bc]={}end;dac.parent=baa;if(dac.init~=nil)then dac:init()end
table.insert(_aa[_bc],dac)return dac end
local function bdb(dac,_bc)
for abc,bbc in pairs(caa)do
for cbc,dbc in pairs(bbc)do
for _cc,acc in pairs(dbc)do
if(acc==_bc)then
table.remove(caa[abc][cbc],_cc)if(dac.parent~=nil)then if(_d(caa[abc])<=0)then
dac.parent:removeEvent(abc,dac)end end end end end end end
local function cdb(dac,_bc)
for abc,bbc in pairs(_aa)do
for cbc,dbc in pairs(bbc)do
if(type(_bc)=="string")then
if(dbc:getName()==_bc)then
table.remove(_aa[abc],cbc)bdb(baa,dbc)dac:updateDraw()return true end else if(dbc==_bc)then table.remove(_aa[abc],cbc)bdb(baa,dbc)
dac:updateDraw()return true end end end end;return false end;local function ddb(dac,_bc,abc)
for bbc,cbc in pairs(caa[_bc])do for dbc,_cc in pairs(cbc)do
if(_cc:getName()==abc)then return _cc end end end end
local function __c(dac,_bc,abc)
local bbc=abc:getZIndex()if(caa[_bc]==nil)then caa[_bc]={}end;if(daa[_bc]==nil)then
daa[_bc]={}end
if(ddb(dac,_bc,abc.name)~=nil)then return nil end
if(dac.parent~=nil)then dac.parent:addEvent(_bc,dac)end;cab[_bc]=true
if(caa[_bc][bbc]==nil)then
for x=1,#daa[_bc]+1 do
if
(daa[_bc][x]~=nil)then if(bbc==daa[_bc][x])then break end;if(bbc>daa[_bc][x])then
table.insert(daa[_bc],x,bbc)break end else
table.insert(daa[_bc],bbc)end end
if(#daa[_bc]<=0)then table.insert(daa[_bc],bbc)end;caa[_bc][bbc]={}end;table.insert(caa[_bc][bbc],abc)return abc end
local function a_c(dac,_bc,abc)
if(caa[_bc]~=nil)then
for bbc,cbc in pairs(caa[_bc])do
for dbc,_cc in pairs(cbc)do
if(_cc==abc)then
table.remove(caa[_bc][bbc],dbc)if(#caa[_bc][bbc]<=0)then caa[_bc][bbc]=nil
if(dac.parent~=nil)then if(
_d(caa[_bc])<=0)then cab[_bc]=false
dac.parent:removeEvent(_bc,dac)end end end;return
true end end end end;return false end
local function b_c(dac)local _bc,abc=pcall(load("return "..dac))
if not(_bc)then error(dac..
" is not a valid dynamic code")end;return load("return "..dac)()end
local function c_c(dac,_bc,abc)for bbc,cbc in pairs(bba)do
if(cbc[2]==abc)and(cbc[4]==_bc)then return cbc end end;cba=cba+1
bba[cba]={0,abc,{},_bc,cba}return bba[cba]end
local function d_c(dac,_bc)local abc={}local bbc={}for cbc in _bc:gmatch("%a+%.x")do local dbc=cbc:gsub("%.x","")
if
(dbc~="self")and(dbc~="parent")then table.insert(abc,dbc)end end
for cbc in
_bc:gmatch("%w+%.y")do local dbc=cbc:gsub("%.y","")if(dbc~="self")and(dbc~="parent")then
table.insert(abc,dbc)end end;for cbc in _bc:gmatch("%a+%.w")do local dbc=cbc:gsub("%.w","")
if(dbc~="self")and
(dbc~="parent")then table.insert(abc,dbc)end end
for cbc in
_bc:gmatch("%a+%.h")do local dbc=cbc:gsub("%.h","")if(dbc~="self")and(dbc~="parent")then
table.insert(abc,dbc)end end
for cbc,dbc in pairs(abc)do bbc[dbc]=dcb(dbc)if(bbc[dbc]==nil)then
error("Dynamic Values - unable to find object "..dbc)end end;bbc["self"]=dac;bbc["parent"]=dac:getParent()return bbc end
local function _ac(dac,_bc)local abc=dac;for bbc in dac:gmatch("%w+%.x")do
abc=abc:gsub(bbc,_bc[bbc:gsub("%.x","")]:getX())end;for bbc in dac:gmatch("%w+%.y")do
abc=abc:gsub(bbc,_bc[bbc:gsub("%.y","")]:getY())end;for bbc in dac:gmatch("%w+%.w")do
abc=abc:gsub(bbc,_bc[bbc:gsub("%.w","")]:getWidth())end;for bbc in dac:gmatch("%w+%.h")do
abc=abc:gsub(bbc,_bc[bbc:gsub("%.h","")]:getHeight())end;return abc end
local function aac(dac)
if(#bba>0)then
for n=1,cba do
if(bba[n]~=nil)then local _bc;if(#bba[n][3]<=0)then
bba[n][3]=d_c(bba[n][4],bba[n][2])end
_bc=_ac(bba[n][2],bba[n][3])bba[n][1]=b_c(_bc)if(bba[n][4]:getType()=="Frame")then
bba[n][4]:recalculateDynamicValues()end end end
for _bc,abc in pairs(aaa)do if(_aa[abc]~=nil)then
for bbc,cbc in pairs(_aa[abc])do if(cbc.eventHandler~=nil)then
cbc:eventHandler("dynamicValueEvent",dac)end end end end end end;local function bac(dac)return bba[dac][1]end
local function cac(dac)
for _bc,abc in pairs(_aa)do
for bbc,cbc in pairs(abc)do
if
(cbc.getHeight~=nil)and(cbc.getY~=nil)then
local dbc,_cc=cbc:getHeight(),cbc:getY()if(dbc+_cc-dac:getHeight()>bda)then
bda=cd(dbc+_cc-dac:getHeight(),0)end end end end end
baa={barActive=false,barBackground=colors.gray,barTextcolor=colors.black,barText="New Frame",barTextAlign="left",addEvent=__c,removeEvent=a_c,removeEvents=bdb,getEvent=ddb,newDynamicValue=c_c,recalculateDynamicValues=aac,getDynamicValue=bac,getType=function(dac)return d_a end,setFocusedObject=function(dac,_bc)
if(d_b~=_bc)then if
(d_b~=nil)then d_b:loseFocusHandler()end;if(_bc~=nil)then
_bc:getFocusHandler()end;d_b=_bc end;return dac end,getVariable=function(dac,_bc)return
b_a.getVariable(_bc)end,setSize=function(dac,_bc,abc,bbc)
c_a.setSize(dac,_bc,abc,bbc)if(dac.parent==nil)then dab=cb(dba)end
for cbc,dbc in pairs(aaa)do if(_aa[dbc]~=nil)then
for _cc,acc in
pairs(_aa[dbc])do if(acc.eventHandler~=nil)then
acc:eventHandler("basalt_resize",acc,dac)end end end end;dac:recalculateDynamicValues()_ab=false;return dac end,setTheme=function(dac,_bc,abc)
if(
type(_bc)=="table")then aba=_bc elseif(type(_bc)=="string")then aba[_bc]=abc end;dac:updateDraw()return dac end,getTheme=function(dac,_bc)
return
aba[_bc]or(dac.parent~=nil and dac.parent:getTheme(_bc)or
b_a.getTheme(_bc))end,setPosition=function(dac,_bc,abc,bbc)
c_a.setPosition(dac,_bc,abc,bbc)
for cbc,dbc in pairs(aaa)do if(_aa[dbc]~=nil)then
for _cc,acc in pairs(_aa[dbc])do if(acc.eventHandler~=nil)then
acc:eventHandler("basalt_reposition",acc,dac)end end end end;dac:recalculateDynamicValues()return dac end,getBasaltInstance=function(dac)return
b_a end,setOffset=function(dac,_bc,abc)
dbb=_bc~=nil and
math.floor(_bc<0 and math.abs(_bc)or-_bc)or dbb
_cb=abc~=nil and
math.floor(abc<0 and math.abs(abc)or-abc)or _cb;dac:updateDraw()return dac end,getOffsetInternal=function(dac)return
dbb,_cb end,getOffset=function(dac)
return dbb<0 and math.abs(dbb)or-dbb,
_cb<0 and math.abs(_cb)or-_cb end,removeFocusedObject=function(dac)if(d_b~=nil)then
d_b:loseFocusHandler()end;d_b=nil;return dac end,getFocusedObject=function(dac)
return d_b end,setCursor=function(dac,_bc,abc,bbc,cbc)
if(dac.parent~=nil)then local dbc,_cc=dac:getAnchorPosition()
dac.parent:setCursor(
_bc or false,(abc or 0)+dbc-1,(bbc or 0)+_cc-1,cbc or cbb)else
local dbc,_cc=dac:getAbsolutePosition(dac:getAnchorPosition(dac:getX(),dac:getY(),true))_bb=_bc or false;if(abc~=nil)then abb=dbc+abc-1 end;if(bbc~=nil)then bbb=_cc+
bbc-1 end;cbb=cbc or cbb;if(_bb)then
dba.setTextColor(cbb)dba.setCursorPos(abb,bbb)dba.setCursorBlink(_bb)else
dba.setCursorBlink(false)end end;return dac end,setMovable=function(dac,_bc)
if(
dac.parent~=nil)then a_b=_bc or not a_b
dac.parent:addEvent("mouse_click",dac)cab["mouse_click"]=true
dac.parent:addEvent("mouse_up",dac)cab["mouse_up"]=true
dac.parent:addEvent("mouse_drag",dac)cab["mouse_drag"]=true end;return dac end,setScrollable=function(dac,_bc)ada=(
_bc or _bc==nil)and true or false
if(
dac.parent~=nil)then dac.parent:addEvent("mouse_scroll",dac)end;cab["mouse_scroll"]=true;return dac end,setScrollAmount=function(dac,_bc)bda=
_bc or bda;aab=false;return dac end,getScrollAmount=function(dac)return
aab and bda or cac(dac)end,show=function(dac)c_a.show(dac)
if(dac.parent==nil)then
b_a.setActiveFrame(dac)
if(aca)and not(bca)then b_a.setMonitorFrame(_ca,dac)elseif(bca)then
b_a.setMonitorFrame(dac:getName(),dac,_ca)else b_a.setMainFrame(dac)end end;return dac end,hide=function(dac)
c_a.hide(dac)
if(dac.parent==nil)then if(activeFrame==dac)then activeFrame=nil end
if(aca)and
not(bca)then if(b_a.getMonitorFrame(_ca)==dac)then
b_a.setActiveFrame(nil)end elseif(bca)then
if(
b_a.getMonitorFrame(dac:getName())==dac)then b_a.setActiveFrame(nil)end else
if(b_a.getMainFrame()==dac)then b_a.setMainFrame(nil)end end end;return dac end,addLayout=function(dac,_bc)
if(
_bc~=nil)then
if(fs.exists(_bc))then local abc=fs.open(_bc,"r")
local bbc=_c:ParseXmlText(abc.readAll())abc.close()acb={}dac:setValuesByXMLData(bbc)end end;return dac end,getLastLayout=function(dac)return
acb end,addLayoutFromString=function(dac,_bc)if(_bc~=nil)then local abc=_c:ParseXmlText(_bc)
dac:setValuesByXMLData(abc)end;return dac end,setValuesByXMLData=function(dac,_bc)
c_a.setValuesByXMLData(dac,_bc)if(dc("movable",_bc)~=nil)then if(dc("movable",_bc))then
dac:setMovable(true)end end;if(
dc("scrollable",_bc)~=nil)then
if(dc("scrollable",_bc))then dac:setScrollable(true)end end;if
(dc("monitor",_bc)~=nil)then
dac:setMonitor(dc("monitor",_bc)):show()end;if(dc("mirror",_bc)~=nil)then
dac:setMirror(dc("mirror",_bc))end
if(dc("bar",_bc)~=nil)then if(dc("bar",_bc))then
dac:showBar(true)else dac:showBar(false)end end
if(dc("barText",_bc)~=nil)then dac.barText=dc("barText",_bc)end;if(dc("barBG",_bc)~=nil)then
dac.barBackground=colors[dc("barBG",_bc)]end;if(dc("barFG",_bc)~=nil)then
dac.barTextcolor=colors[dc("barFG",_bc)]end;if(dc("barAlign",_bc)~=nil)then
dac.barTextAlign=dc("barAlign",_bc)end;if(dc("layout",_bc)~=nil)then
dac:addLayout(dc("layout",_bc))end;if(dc("xOffset",_bc)~=nil)then
dac:setOffset(dc("xOffset",_bc),_cb)end;if(dc("yOffset",_bc)~=nil)then
dac:setOffset(_cb,dc("yOffset",_bc))end;if(dc("scrollAmount",_bc)~=nil)then
dac:setScrollAmount(dc("scrollAmount",_bc))end;local abc=_bc:children()
for bbc,cbc in
pairs(abc)do if(cbc.___name~="animation")then
local dbc=cbc.___name:gsub("^%l",string.upper)
if(bb[dbc]~=nil)then ccb(cbc,dac["add"..dbc],dac)end end end;ccb(_bc["frame"],dac.addFrame,dac)
ccb(_bc["animation"],dac.addAnimation,dac)return dac end,showBar=function(dac,_bc)dac.barActive=
_bc or not dac.barActive;dac:updateDraw()
return dac end,setBar=function(dac,_bc,abc,bbc)dac.barText=_bc or""dac.barBackground=
abc or dac.barBackground
dac.barTextcolor=bbc or dac.barTextcolor;dac:updateDraw()return dac end,setBarTextAlign=function(dac,_bc)dac.barTextAlign=
_bc or"left"dac:updateDraw()return dac end,setMirror=function(dac,_bc)if(
dac.parent~=nil)then
error("Frame has to be a base frame in order to attach a mirror.")end;__b=_bc;if(mirror~=nil)then
dab.setMirror(mirror)end;cda=true;return dac end,removeMirror=function(dac)mirror=
nil;cda=false;dab.setMirror(nil)return dac end,setMonitorScale=function(dac,_bc)if
(aca)then dba.setTextScale(_bc)end;return dac end,setMonitor=function(dac,_bc,abc)
if(
_bc~=nil)and(_bc~=false)then
if(type(_bc)=="string")then
if(
peripheral.getType(_bc)=="monitor")then dba=peripheral.wrap(_bc)cca=true end
if(dac.parent~=nil)then dac.parent:removeObject(dac)end;aca=true;b_a.setMonitorFrame(_bc,dac)elseif(type(_bc)=="table")then
dba=ac(_bc)cca=true;aca=true;bca=true
b_a.setMonitorFrame(dac:getName(),dac,true)end else dba=parentTerminal;aca=false;bca=false
if(type(_ca)=="string")then
if(
b_a.getMonitorFrame(_ca)==dac)then b_a.setMonitorFrame(_ca,nil)end else
if(b_a.getMonitorFrame(dac:getName())==dac)then b_a.setMonitorFrame(dac:getName(),
nil)end end end;if(abc~=nil)then dba.setTextScale(abc)end;dab=cb(dba)
dac:setSize(dba.getSize())_ab=true;_ca=_bc or nil;dac:updateDraw()return dac end,loseFocusHandler=function(dac)
c_a.loseFocusHandler(dac)if(d_b~=nil)then d_b:loseFocusHandler()d_b=nil end end,getFocusHandler=function(dac)
c_a.getFocusHandler(dac)
if(dac.parent~=nil)then
if(a_b)then dac.parent:removeEvents(dac)
dac.parent:removeObject(dac)dac.parent:addObject(dac)for _bc,abc in pairs(cab)do if(abc)then
dac.parent:addEvent(_bc,dac)end end
dac:updateDraw()end end;if(d_b~=nil)then d_b:getFocusHandler()end end,eventHandler=function(dac,_bc,abc,bbc,cbc,dbc)
c_a.eventHandler(dac,_bc,abc,bbc,cbc,dbc)
if(caa["other_event"]~=nil)then
for _cc,acc in ipairs(daa["other_event"])do
if(
caa["other_event"][acc]~=nil)then for bcc,ccc in cc(caa["other_event"][acc])do
if
(ccc.eventHandler~=nil)then if(ccc:eventHandler(_bc,abc,bbc,cbc,dbc))then return true end end end end end end;if(_ab)and not(aca)then
if(dac.parent==nil)then if(_bc=="term_resize")then
dac:setSize(dba.getSize())_ab=true end end end
if(aca)then
if(_ab)then
if
(_bc=="monitor_resize")then
if(type(_ca)=="string")then dac:setSize(dba.getSize())elseif(
type(_ca)=="table")then
for _cc,acc in pairs(_ca)do for bcc,ccc in pairs(acc)do if(abc==ccc)then
dac:setSize(dba.getSize())end end end end;_ab=true;dac:updateDraw()end end
if(_bc=="peripheral")and(abc==_ca)then if
(peripheral.getType(_ca)=="monitor")then cca=true;dba=peripheral.wrap(_ca)dab=cb(dba)
dac:updateDraw()end end
if(_bc=="peripheral_detach")and(abc==_ca)then cca=false end end
if(cda)then if(peripheral.getType(__b)=="monitor")then dda=true
dab.setMirror(peripheral.wrap(__b))end;if(_bc=="peripheral_detach")and
(abc==__b)then cca=false end
if
(_bc=="monitor_touch")and(__b==abc)then dac:mouseHandler(1,bbc,cbc,true)end end
if(_bc=="terminate")and(dac.parent==nil)then b_a.stop()end end,mouseHandler=function(dac,_bc,abc,bbc,cbc,dbc)
if
(bca)then if(dba.calculateClick~=nil)then
abc,bbc=dba.calculateClick(dbc,abc,bbc)end end
if(c_a.mouseHandler(dac,_bc,abc,bbc))then
if(caa["mouse_click"]~=nil)then
dac:setCursor(false)
for _cc,acc in ipairs(daa["mouse_click"])do
if
(caa["mouse_click"][acc]~=nil)then for bcc,ccc in cc(caa["mouse_click"][acc])do
if(ccc.mouseHandler~=nil)then if
(ccc:mouseHandler(_bc,abc,bbc))then return true end end end end end end
if(a_b)then
local _cc,acc=dac:getAbsolutePosition(dac:getAnchorPosition())if
(abc>=_cc)and(abc<=_cc+dac:getWidth()-1)and(bbc==acc)then b_b=true;dca=_cc-abc
_da=yOff and 1 or 0 end end;dac:removeFocusedObject()return true end;return false end,mouseUpHandler=function(dac,_bc,abc,bbc)if
(b_b)then b_b=false end
if(c_a.mouseUpHandler(dac,_bc,abc,bbc))then
if
(caa["mouse_up"]~=nil)then
for cbc,dbc in ipairs(daa["mouse_up"])do
if(caa["mouse_up"][dbc]~=nil)then
for _cc,acc in
cc(caa["mouse_up"][dbc])do if(acc.mouseUpHandler~=nil)then
if(acc:mouseUpHandler(_bc,abc,bbc))then return true end end end end end end;return true end;return false end,scrollHandler=function(dac,_bc,abc,bbc)
if
(c_a.scrollHandler(dac,_bc,abc,bbc))then
if(caa["mouse_scroll"]~=nil)then
for dbc,_cc in pairs(daa["mouse_scroll"])do
if(
caa["mouse_scroll"][_cc]~=nil)then
for acc,bcc in cc(caa["mouse_scroll"][_cc])do if(bcc.scrollHandler~=
nil)then
if(bcc:scrollHandler(_bc,abc,bbc))then return true end end end end end end;local cbc=_cb
if(ada)then cac(dac)if(_bc>0)or(_bc<0)then
_cb=cd(bd(_cb-_bc,0),-bda)dac:updateDraw()end end;dac:removeFocusedObject()if(_cb==cbc)then return false end
return true end;return false end,hoverHandler=function(dac,_bc,abc,bbc)
if
(c_a.hoverHandler(dac,_bc,abc,bbc))then
if(caa["mouse_move"]~=nil)then
for cbc,dbc in pairs(daa["mouse_move"])do
if(
caa["mouse_move"][dbc]~=nil)then for _cc,acc in cc(caa["mouse_move"][dbc])do
if
(acc.hoverHandler~=nil)then if(acc:hoverHandler(_bc,abc,bbc))then return true end end end end end end end;return false end,dragHandler=function(dac,_bc,abc,bbc)
if
(b_b)then local cbc,dbc=dac.parent:getOffsetInternal()cbc=cbc<0 and
math.abs(cbc)or-cbc;dbc=
dbc<0 and math.abs(dbc)or-dbc;local _cc=1;local acc=1;if(dac.parent~=nil)then
_cc,acc=dac.parent:getAbsolutePosition(dac.parent:getAnchorPosition())end
dac:setPosition(
abc+dca- (_cc-1)+cbc,bbc+_da- (acc-1)+dbc)dac:updateDraw()return true end
if(dac:isVisible())and(dac:isEnabled())then
if
(caa["mouse_drag"]~=nil)then
for cbc,dbc in ipairs(daa["mouse_drag"])do
if
(caa["mouse_drag"][dbc]~=nil)then for _cc,acc in cc(caa["mouse_drag"][dbc])do
if(acc.dragHandler~=nil)then if
(acc:dragHandler(_bc,abc,bbc))then return true end end end end end end end;c_a.dragHandler(dac,_bc,abc,bbc)return false end,keyHandler=function(dac,_bc,abc)
if
(dac:isFocused())or(dac.parent==nil)then
local bbc=dac:getEventSystem():sendEvent("key",dac,"key",_bc)if(bbc==false)then return false end
if(caa["key"]~=nil)then
for cbc,dbc in pairs(daa["key"])do
if(
caa["key"][dbc]~=nil)then
for _cc,acc in cc(caa["key"][dbc])do if(acc.keyHandler~=nil)then if
(acc:keyHandler(_bc,abc))then return true end end end end end end end;return false end,keyUpHandler=function(dac,_bc)
if
(dac:isFocused())or(dac.parent==nil)then
local abc=dac:getEventSystem():sendEvent("key_up",dac,"key_up",_bc)if(abc==false)then return false end
if(caa["key_up"]~=nil)then
for bbc,cbc in
pairs(daa["key_up"])do
if(caa["key_up"][cbc]~=nil)then for dbc,_cc in cc(caa["key_up"][cbc])do
if(
_cc.keyUpHandler~=nil)then if(_cc:keyUpHandler(_bc))then return true end end end end end end end;return false end,charHandler=function(dac,_bc)
if
(dac:isFocused())or(dac.parent==nil)then
local abc=dac:getEventSystem():sendEvent("char",dac,"char",_bc)if(abc==false)then return false end
if(caa["char"]~=nil)then
for bbc,cbc in
pairs(daa["char"])do
if(caa["char"][cbc]~=nil)then for dbc,_cc in cc(caa["char"][cbc])do
if
(_cc.charHandler~=nil)then if(_cc:charHandler(_bc))then return true end end end end end end end;return false end,setText=function(dac,_bc,abc,bbc)
local cbc,dbc=dac:getAnchorPosition()
if(abc>=1)and(abc<=dac:getHeight())then
if(dac.parent~=nil)then
dac.parent:setText(cd(
_bc+ (cbc-1),cbc),dbc+abc-1,ad(bbc,cd(1 -_bc+1,1),cd(
dac:getWidth()-_bc+1,1)))else
dab.setText(cd(_bc+ (cbc-1),cbc),dbc+abc-1,ad(bbc,cd(1 -_bc+1,1),cd(
dac:getWidth()-_bc+1,1)))end end end,setBG=function(dac,_bc,abc,bbc)
local cbc,dbc=dac:getAnchorPosition()
if(abc>=1)and(abc<=dac:getHeight())then
if(dac.parent~=nil)then
dac.parent:setBG(cd(
_bc+ (cbc-1),cbc),dbc+abc-1,ad(bbc,cd(1 -_bc+1,1),cd(
dac:getWidth()-_bc+1,1)))else
dab.setBG(cd(_bc+ (cbc-1),cbc),dbc+abc-1,ad(bbc,cd(1 -_bc+1,1),cd(
dac:getWidth()-_bc+1,1)))end end end,setFG=function(dac,_bc,abc,bbc)
local cbc,dbc=dac:getAnchorPosition()
if(abc>=1)and(abc<=dac:getHeight())then
if(dac.parent~=nil)then
dac.parent:setFG(cd(
_bc+ (cbc-1),cbc),dbc+abc-1,ad(bbc,cd(1 -_bc+1,1),cd(
dac:getWidth()-_bc+1,1)))else
dab.setFG(cd(_bc+ (cbc-1),cbc),dbc+abc-1,ad(bbc,cd(1 -_bc+1,1),cd(
dac:getWidth()-_bc+1,1)))end end end,writeText=function(dac,_bc,abc,bbc,cbc,dbc)
local _cc,acc=dac:getAnchorPosition()
if(abc>=1)and(abc<=dac:getHeight())then
if(dac.parent~=nil)then
dac.parent:writeText(cd(
_bc+ (_cc-1),_cc),acc+abc-1,ad(bbc,cd(1 -_bc+1,1),
dac:getWidth()-_bc+1),cbc,dbc)else
dab.writeText(cd(_bc+ (_cc-1),_cc),acc+abc-1,ad(bbc,cd(1 -_bc+1,1),cd(
dac:getWidth()-_bc+1,1)),cbc,dbc)end end end,blit=function(dac,_bc,abc,bbc,cbc,dbc)
local _cc,acc=dac:getAnchorPosition()
if(abc>=1)and(abc<=dac:getHeight())then
local bcc=dac:getWidth()
if(dac.parent~=nil)then
bbc=ad(bbc,cd(1 -_bc+1,1),bcc-_bc+1)cbc=ad(cbc,cd(1 -_bc+1,1),bcc-_bc+1)dbc=ad(dbc,cd(
1 -_bc+1,1),bcc-_bc+1)
dac.parent:blit(cd(
_bc+ (_cc-1),_cc),acc+abc-1,bbc,cbc,dbc)else
bbc=ad(bbc,cd(1 -_bc+1,1),cd(bcc-_bc+1,1))
cbc=ad(cbc,cd(1 -_bc+1,1),cd(bcc-_bc+1,1))
dbc=ad(dbc,cd(1 -_bc+1,1),cd(bcc-_bc+1,1))
dab.blit(cd(_bc+ (_cc-1),_cc),acc+abc-1,bbc,cbc,dbc)end end end,drawBackgroundBox=function(dac,_bc,abc,bbc,cbc,dbc)
local _cc,acc=dac:getAnchorPosition()
cbc=(abc<1 and(
cbc+abc>dac:getHeight()and dac:getHeight()or cbc+abc-1)or(
cbc+
abc>dac:getHeight()and dac:getHeight()-abc+1 or cbc))
bbc=(_bc<1 and(bbc+_bc>dac:getWidth()and dac:getWidth()or bbc+
_bc-1)or(

bbc+_bc>dac:getWidth()and dac:getWidth()-_bc+1 or bbc))
if(dac.parent~=nil)then
dac.parent:drawBackgroundBox(cd(_bc+ (_cc-1),_cc),cd(abc+ (acc-1),acc),bbc,cbc,dbc)else
dab.drawBackgroundBox(cd(_bc+ (_cc-1),_cc),cd(abc+ (acc-1),acc),bbc,cbc,dbc)end end,drawTextBox=function(dac,_bc,abc,bbc,cbc,dbc)
local _cc,acc=dac:getAnchorPosition()
cbc=(abc<1 and(
cbc+abc>dac:getHeight()and dac:getHeight()or cbc+abc-1)or(
cbc+
abc>dac:getHeight()and dac:getHeight()-abc+1 or cbc))
bbc=(_bc<1 and(bbc+_bc>dac:getWidth()and dac:getWidth()or bbc+
_bc-1)or(

bbc+_bc>dac:getWidth()and dac:getWidth()-_bc+1 or bbc))
if(dac.parent~=nil)then
dac.parent:drawTextBox(cd(_bc+ (_cc-1),_cc),cd(abc+ (acc-1),acc),bbc,cbc,ad(dbc,1,1))else
dab.drawTextBox(cd(_bc+ (_cc-1),_cc),cd(abc+ (acc-1),acc),bbc,cbc,ad(dbc,1,1))end end,drawForegroundBox=function(dac,_bc,abc,bbc,cbc,dbc)
local _cc,acc=dac:getAnchorPosition()
cbc=(abc<1 and(
cbc+abc>dac:getHeight()and dac:getHeight()or cbc+abc-1)or(
cbc+
abc>dac:getHeight()and dac:getHeight()-abc+1 or cbc))
bbc=(_bc<1 and(bbc+_bc>dac:getWidth()and dac:getWidth()or bbc+
_bc-1)or(

bbc+_bc>dac:getWidth()and dac:getWidth()-_bc+1 or bbc))
if(dac.parent~=nil)then
dac.parent:drawForegroundBox(cd(_bc+ (_cc-1),_cc),cd(abc+ (acc-1),acc),bbc,cbc,dbc)else
dab.drawForegroundBox(cd(_bc+ (_cc-1),_cc),cd(abc+ (acc-1),acc),bbc,cbc,dbc)end end,draw=function(dac,_bc)if
(aca)and not(cca)then return false end
if(dac.parent==nil)then if(dac:getDraw()==
false)then return false end end
if(c_a.draw(dac))then
local abc,bbc=dac:getAbsolutePosition(dac:getAnchorPosition())local cbc,dbc=dac:getAnchorPosition()local _cc,acc=dac:getSize()
if(
dac.parent==nil)then
if(dac.bgColor~=false)then
dab.drawBackgroundBox(cbc,dbc,_cc,acc,dac.bgColor)dab.drawTextBox(cbc,dbc,_cc,acc," ")end;if(dac.fgColor~=false)then
dab.drawForegroundBox(cbc,dbc,_cc,acc,dac.fgColor)end end
if(dac.barActive)then
if(dac.parent~=nil)then
dac.parent:writeText(cbc,dbc,db.getTextHorizontalAlign(dac.barText,_cc,dac.barTextAlign),dac.barBackground,dac.barTextcolor)else
dab.writeText(cbc,dbc,db.getTextHorizontalAlign(dac.barText,_cc,dac.barTextAlign),dac.barBackground,dac.barTextcolor)end
if(dac:getBorder("left"))then
if(dac.parent~=nil)then
dac.parent:drawBackgroundBox(cbc-1,dbc,1,1,dac.barBackground)if(dac.bgColor~=false)then
dac.parent:drawBackgroundBox(cbc-1,dbc+1,1,acc-1,dac.bgColor)end end end
if(dac:getBorder("top"))then if(dac.parent~=nil)then
dac.parent:drawBackgroundBox(cbc-1,dbc-1,_cc+1,1,dac.barBackground)end end end;for bcc,ccc in cc(aaa)do
if(_aa[ccc]~=nil)then for dcc,_dc in pairs(_aa[ccc])do
if(_dc.draw~=nil)then _dc:draw()end end end end end end,updateTerm=function(dac)if
(aca)and not(cca)then return false end;dab.update()end,addObject=function(dac,_bc)return
adb(_bc)end,removeObject=cdb,getObject=function(dac,_bc)return dcb(_bc)end,getDeepObject=function(dac,_bc)return _db(_bc)end,addFrame=function(dac,_bc)local abc=b_a.newFrame(
_bc or bc(),dac,nil,b_a)return adb(abc)end,init=function(dac)
if
not(bab)then
if(__a~=nil)then c_a.width,c_a.height=__a:getSize()
dac:setBackground(__a:getTheme("FrameBG"))
dac:setForeground(__a:getTheme("FrameText"))else c_a.width,c_a.height=dba.getSize()
dac:setBackground(b_a.getTheme("BasaltBG"))
dac:setForeground(b_a.getTheme("BasaltText"))end;bab=true end end}
for dac,_bc in pairs(bb)do baa["add"..dac]=function(abc,bbc)
return adb(_bc(bbc or bc(),abc))end end;setmetatable(baa,c_a)return baa end end;aa["objects"]={}
aa["objects"]["Radio"]=function(...)local ab=da("Object")
local bb=da("utils")local cb=bb.getValueFromXML
return
function(db)local _c=ab(db)local ac="Radio"_c.width=8
_c:setZIndex(5)local bc={}local cc;local dc;local _d;local ad;local bd;local cd;local dd=true;local __a="\7"local a_a="left"
local b_a={getType=function(c_a)return ac end,setValuesByXMLData=function(c_a,d_a)
_c.setValuesByXMLData(c_a,d_a)if(cb("selectionBG",d_a)~=nil)then
cc=colors[cb("selectionBG",d_a)]end;if(cb("selectionFG",d_a)~=nil)then
dc=colors[cb("selectionFG",d_a)]end;if(cb("boxBG",d_a)~=nil)then
_d=colors[cb("boxBG",d_a)]end;if(cb("inactiveBoxBG",d_a)~=nil)then
bd=colors[cb("inactiveBoxBG",d_a)]end;if(cb("inactiveBoxFG",d_a)~=nil)then
cd=colors[cb("inactiveBoxFG",d_a)]end;if(cb("boxFG",d_a)~=nil)then
ad=colors[cb("boxFG",d_a)]end;if(cb("symbol",d_a)~=nil)then
__a=cb("symbol",d_a)end
if(d_a["item"]~=nil)then local _aa=d_a["item"]if(
_aa.properties~=nil)then _aa={_aa}end;for aaa,baa in pairs(_aa)do
c_a:addItem(cb("text",baa),cb("x",baa),cb("y",baa),colors[cb("bg",baa)],colors[cb("fg",baa)])end end;return c_a end,addItem=function(c_a,d_a,_aa,aaa,baa,caa,...)
table.insert(bc,{x=
_aa or 1,y=aaa or 1,text=d_a,bgCol=baa or c_a.bgColor,fgCol=caa or c_a.fgColor,args={...}})if(#bc==1)then c_a:setValue(bc[1])end
c_a:updateDraw()return c_a end,getAll=function(c_a)return
bc end,removeItem=function(c_a,d_a)table.remove(bc,d_a)c_a:updateDraw()
return c_a end,getItem=function(c_a,d_a)return bc[d_a]end,getItemIndex=function(c_a)
local d_a=c_a:getValue()for _aa,aaa in pairs(bc)do if(aaa==d_a)then return _aa end end end,clear=function(c_a)
bc={}c_a:setValue({})c_a:updateDraw()return c_a end,getItemCount=function(c_a)return
#bc end,editItem=function(c_a,d_a,_aa,aaa,baa,caa,daa,...)table.remove(bc,d_a)
table.insert(bc,d_a,{x=aaa or 1,y=baa or 1,text=_aa,bgCol=
caa or c_a.bgColor,fgCol=daa or c_a.fgColor,args={...}})c_a:updateDraw()return c_a end,selectItem=function(c_a,d_a)c_a:setValue(
bc[d_a]or{})c_a:updateDraw()return c_a end,setActiveSymbol=function(c_a,d_a)
__a=d_a:sub(1,1)c_a:updateDraw()return c_a end,setSelectedItem=function(c_a,d_a,_aa,aaa,baa,caa)
cc=d_a or cc;dc=_aa or dc;_d=aaa or _d;ad=baa or ad
dd=caa~=nil and caa or true;c_a:updateDraw()return c_a end,mouseHandler=function(c_a,d_a,_aa,aaa)
if(
#bc>0)then
local baa,caa=c_a:getAbsolutePosition(c_a:getAnchorPosition())
for daa,_ba in pairs(bc)do
if(baa+_ba.x-1 <=_aa)and(
baa+_ba.x-1 +_ba.text:len()+1 >=_aa)and(
caa+_ba.y-1 ==aaa)then
c_a:setValue(_ba)
local aba=c_a:getEventSystem():sendEvent("mouse_click",c_a,"mouse_click",d_a,_aa,aaa)if(aba==false)then return aba end;if(c_a.parent~=nil)then
c_a.parent:setFocusedObject(c_a)end;c_a:updateDraw()return true end end end;return false end,draw=function(c_a)
if(
c_a.parent~=nil)then local d_a,_aa=c_a:getAnchorPosition()
for aaa,baa in pairs(bc)do
if(baa==
c_a:getValue())then if(a_a=="left")then
c_a.parent:writeText(baa.x+d_a-1,baa.y+_aa-1,__a,_d,ad)
c_a.parent:writeText(baa.x+2 +d_a-1,baa.y+_aa-1,baa.text,cc,dc)end else
c_a.parent:drawBackgroundBox(
baa.x+d_a-1,baa.y+_aa-1,1,1,bd or c_a.bgColor)
c_a.parent:writeText(baa.x+2 +d_a-1,baa.y+_aa-1,baa.text,baa.bgCol,baa.fgCol)end end;return true end end,init=function(c_a)
c_a.bgColor=c_a.parent:getTheme("MenubarBG")c_a.fgColor=c_a.parent:getTheme("MenubarFG")
cc=c_a.parent:getTheme("SelectionBG")dc=c_a.parent:getTheme("SelectionText")
_d=c_a.parent:getTheme("MenubarBG")ad=c_a.parent:getTheme("MenubarText")
c_a.parent:addEvent("mouse_click",c_a)end}return setmetatable(b_a,_c)end end
aa["objects"]["Menubar"]=function(...)local ab=da("Object")local bb=da("utils")
local cb=bb.getValueFromXML;local db=da("tHex")
return
function(_c)local ac=ab(_c)local bc="Menubar"local cc={}ac.width=30;ac.height=1
ac:setZIndex(5)local dc={}local _d;local ad;local bd=true;local cd="left"local dd=0;local __a=1;local a_a=false
local function b_a()local c_a=0;local d_a=0
local _aa=cc:getWidth()
for n=1,#dc do if(d_a+dc[n].text:len()+__a*2 >_aa)then
if(
d_a<_aa)then
c_a=c_a+ (dc[n].text:len()+__a*2 - (_aa-d_a))else c_a=c_a+dc[n].text:len()+__a*2 end end;d_a=
d_a+dc[n].text:len()+__a*2 end;return c_a end
cc={getType=function(c_a)return bc end,addItem=function(c_a,d_a,_aa,aaa,...)
table.insert(dc,{text=tostring(d_a),bgCol=_aa or c_a.bgColor,fgCol=aaa or c_a.fgColor,args={...}})if(#dc==1)then c_a:setValue(dc[1])end
c_a:updateDraw()return c_a end,getAll=function(c_a)return
dc end,getItemIndex=function(c_a)local d_a=c_a:getValue()for _aa,aaa in pairs(dc)do
if(aaa==d_a)then return _aa end end end,clear=function(c_a)
dc={}c_a:setValue({})c_a:updateDraw()return c_a end,setSpace=function(c_a,d_a)__a=
d_a or __a;c_a:updateDraw()return c_a end,setOffset=function(c_a,d_a)dd=
d_a or 0;if(dd<0)then dd=0 end;local _aa=b_a()if(dd>_aa)then dd=_aa end
c_a:updateDraw()return c_a end,getOffset=function(c_a)return dd end,setScrollable=function(c_a,d_a)
a_a=d_a;if(d_a==nil)then a_a=true end;return c_a end,setValuesByXMLData=function(c_a,d_a)
ac.setValuesByXMLData(c_a,d_a)if(cb("selectionBG",d_a)~=nil)then
_d=colors[cb("selectionBG",d_a)]end;if(cb("selectionFG",d_a)~=nil)then
ad=colors[cb("selectionFG",d_a)]end;if(cb("scrollable",d_a)~=nil)then
if
(cb("scrollable",d_a))then c_a:setScrollable(true)else c_a:setScrollable(false)end end
if(
cb("offset",d_a)~=nil)then c_a:setOffset(cb("offset",d_a))end
if(cb("space",d_a)~=nil)then __a=cb("space",d_a)end
if(d_a["item"]~=nil)then local _aa=d_a["item"]
if(_aa.properties~=nil)then _aa={_aa}end;for aaa,baa in pairs(_aa)do
c_a:addItem(cb("text",baa),colors[cb("bg",baa)],colors[cb("fg",baa)])end end;return c_a end,removeItem=function(c_a,d_a)
table.remove(dc,d_a)c_a:updateDraw()return c_a end,getItem=function(c_a,d_a)
return dc[d_a]end,getItemCount=function(c_a)return#dc end,editItem=function(c_a,d_a,_aa,aaa,baa,...)table.remove(dc,d_a)
table.insert(dc,d_a,{text=_aa,bgCol=
aaa or c_a.bgColor,fgCol=baa or c_a.fgColor,args={...}})c_a:updateDraw()return c_a end,selectItem=function(c_a,d_a)c_a:setValue(
dc[d_a]or{})c_a:updateDraw()return c_a end,setSelectedItem=function(c_a,d_a,_aa,aaa)_d=
d_a or c_a.bgColor;ad=_aa or c_a.fgColor;bd=aaa
c_a:updateDraw()return c_a end,mouseHandler=function(c_a,d_a,_aa,aaa)
if
(ac.mouseHandler(c_a,d_a,_aa,aaa))then
local baa,caa=c_a:getAbsolutePosition(c_a:getAnchorPosition())local daa,_ba=c_a:getSize()local aba=0
for n=1,#dc do
if(dc[n]~=nil)then
if
(baa+aba<=_aa+dd)and(baa+aba+
dc[n].text:len()+ (__a*2)>_aa+dd)and(caa==aaa)then
c_a:setValue(dc[n])
c_a:getEventSystem():sendEvent(event,c_a,event,0,_aa,aaa,dc[n])end;aba=aba+dc[n].text:len()+__a*2 end end;c_a:updateDraw()return true end;return false end,scrollHandler=function(c_a,d_a,_aa,aaa)
if
(ac.scrollHandler(c_a,d_a,_aa,aaa))then if(a_a)then dd=dd+d_a;if(dd<0)then dd=0 end;local baa=b_a()if(dd>baa)then dd=baa end
c_a:updateDraw()end;return true end;return false end,draw=function(c_a)
if
(ac.draw(c_a))then
if(c_a.parent~=nil)then local d_a,_aa=c_a:getAnchorPosition()
local aaa,baa=c_a:getSize()if(c_a.bgColor~=false)then
c_a.parent:drawBackgroundBox(d_a,_aa,aaa,baa,c_a.bgColor)end;local caa=""local daa=""local _ba=""
for aba,bba in pairs(dc)do
local cba=
(" "):rep(__a)..bba.text.. (" "):rep(__a)caa=caa..cba
if(bba==c_a:getValue())then daa=daa..
db[_d or bba.bgCol or c_a.bgColor]:rep(cba:len())_ba=_ba..
db[
ad or bba.FgCol or c_a.fgColor]:rep(cba:len())else daa=daa..
db[bba.bgCol or c_a.bgColor]:rep(cba:len())_ba=_ba..
db[bba.FgCol or c_a.fgColor]:rep(cba:len())end end
c_a.parent:setText(d_a,_aa,caa:sub(dd+1,aaa+dd))
c_a.parent:setBG(d_a,_aa,daa:sub(dd+1,aaa+dd))
c_a.parent:setFG(d_a,_aa,_ba:sub(dd+1,aaa+dd))end end end,init=function(c_a)
c_a.bgColor=c_a.parent:getTheme("MenubarBG")c_a.fgColor=c_a.parent:getTheme("MenubarText")
_d=c_a.parent:getTheme("SelectionBG")ad=c_a.parent:getTheme("SelectionText")
c_a.parent:addEvent("mouse_click",c_a)c_a.parent:addEvent("mouse_scroll",c_a)end}return setmetatable(cc,ac)end end
aa["objects"]["Animation"]=function(...)local ab=da("utils").getValueFromXML
local bb=da("basaltEvent")local cb,db,_c,ac=math.floor,math.sin,math.cos,math.pi;local bc=function(c_a,d_a,_aa)return
c_a+ (d_a-c_a)*_aa end
local cc=function(c_a)return c_a end;local dc=function(c_a)return 1 -c_a end
local _d=function(c_a)return c_a*c_a*c_a end;local ad=function(c_a)return dc(_d(dc(c_a)))end;local bd=function(c_a)return
bc(_d(c_a),ad(c_a),c_a)end;local cd=function(c_a)return
db((c_a*ac)/2)end;local dd=function(c_a)return
dc(_c((c_a*ac)/2))end;local __a=function(c_a)return
- (_c(ac*x)-1)/2 end
local a_a={linear=cc,lerp=bc,flip=dc,easeIn=_d,easeOut=ad,easeInOut=bd,easeOutSine=cd,easeInSine=dd,easeInOutSine=__a}local b_a={}
return
function(c_a)local d_a={}local _aa="Animation"local aaa;local baa={}local caa=0;local daa=false;local _ba=1;local aba=false
local bba=bb()local cba=0;local dba;local _ca=false;local aca=false;local bca="easeOut"local cca;local function dca(cda)for dda,__b in pairs(cda)do
__b(d_a,baa[_ba].t,_ba)end end
local function _da(cda)if(_ba==1)then
cda:animationStartHandler()end;if(baa[_ba]~=nil)then dca(baa[_ba].f)
caa=baa[_ba].t end;_ba=_ba+1
if(baa[_ba]==nil)then if(aba)then _ba=1;caa=0 else
cda:animationDoneHandler()return end end;if(baa[_ba].t>0)then
aaa=os.startTimer(baa[_ba].t-caa)else _da(cda)end end
local function ada(cda,dda)for n=1,#baa do
if(baa[n].t==cda)then table.insert(baa[n].f,dda)return end end
for n=1,#baa do
if(baa[n].t>cda)then if
(baa[n-1]~=nil)then if(baa[n-1].t<cda)then
table.insert(baa,n-1,{t=cda,f={dda}})return end else
table.insert(baa,n,{t=cda,f={dda}})return end end end
if(#baa<=0)then table.insert(baa,1,{t=cda,f={dda}})return elseif(
baa[#baa].t<cda)then table.insert(baa,{t=cda,f={dda}})end end
local function bda(cda,dda,__b,a_b,b_b,c_b,d_b,_ab)local aab=cca;local bab,cab;local dab=""if(aab.parent~=nil)then
dab=aab.parent:getName()end;dab=dab..aab:getName()
ada(a_b+0.05,function()
if
(d_b~=nil)then if(b_a[d_b]==nil)then b_a[d_b]={}end;if(b_a[d_b][dab]~=nil)then
if(
b_a[d_b][dab]~=_ab)then b_a[d_b][dab]:cancel()end end;b_a[d_b][dab]=_ab end;bab,cab=b_b(aab)end)
for n=0.05,__b+0.01,0.05 do
ada(a_b+n,function()
local _bb=math.floor(a_a.lerp(bab,cda,a_a[bca](n/__b))+0.5)
local abb=math.floor(a_a.lerp(cab,dda,a_a[bca](n/__b))+0.5)c_b(aab,_bb,abb)
if(d_b~=nil)then if(n>=__b-0.01)then if(b_a[d_b][dab]==_ab)then b_a[d_b][dab]=
nil end end end end)end end
d_a={name=c_a,getType=function(cda)return _aa end,getBaseFrame=function(cda)if(cda.parent~=nil)then
return cda.parent:getBaseFrame()end;return cda end,setMode=function(cda,dda)
bca=dda;return cda end,generateXMLEventFunction=function(cda,dda,__b)
local a_b=function(b_b)
if(b_b:sub(1,1)=="#")then
local c_b=cda:getBaseFrame():getDeepObject(b_b:sub(2,b_b:len()))
if(c_b~=nil)and(c_b.internalObjetCall~=nil)then dda(cda,function()
c_b:internalObjetCall()end)end else
dda(cda,cda:getBaseFrame():getVariable(b_b))end end;if(type(__b)=="string")then a_b(__b)elseif(type(__b)=="table")then
for b_b,c_b in pairs(__b)do a_b(c_b)end end;return cda end,setValuesByXMLData=function(cda,dda)_ca=
ab("loop",dda)==true and true or false
if(
ab("object",dda)~=nil)then
local __b=cda:getBaseFrame():getDeepObject(ab("object",dda))if(__b==nil)then
__b=cda:getBaseFrame():getVariable(ab("object",dda))end
if(__b~=nil)then cda:setObject(__b)end end
if(dda["move"]~=nil)then local __b=ab("x",dda["move"])
local a_b=ab("y",dda["move"])local b_b=ab("duration",dda["move"])
local c_b=ab("time",dda["move"])cda:move(__b,a_b,b_b,c_b)end
if(dda["size"]~=nil)then local __b=ab("width",dda["size"])
local a_b=ab("height",dda["size"])local b_b=ab("duration",dda["size"])
local c_b=ab("time",dda["size"])cda:size(__b,a_b,b_b,c_b)end
if(dda["offset"]~=nil)then local __b=ab("x",dda["offset"])
local a_b=ab("y",dda["offset"])local b_b=ab("duration",dda["offset"])
local c_b=ab("time",dda["offset"])cda:offset(__b,a_b,b_b,c_b)end
if(dda["textColor"]~=nil)then
local __b=ab("duration",dda["textColor"])local a_b=ab("time",dda["textColor"])local b_b={}
local c_b=dda["textColor"]["color"]
if(c_b~=nil)then if(c_b.properties~=nil)then c_b={c_b}end;for d_b,_ab in pairs(c_b)do
table.insert(b_b,colors[_ab:value()])end end;if(__b~=nil)and(#b_b>0)then
cda:changeTextColor(__b,a_b or 0,table.unpack(b_b))end end
if(dda["background"]~=nil)then
local __b=ab("duration",dda["background"])local a_b=ab("time",dda["background"])local b_b={}
local c_b=dda["background"]["color"]
if(c_b~=nil)then if(c_b.properties~=nil)then c_b={c_b}end;for d_b,_ab in pairs(c_b)do
table.insert(b_b,colors[_ab:value()])end end;if(__b~=nil)and(#b_b>0)then
cda:changeBackground(__b,a_b or 0,table.unpack(b_b))end end
if(dda["text"]~=nil)then local __b=ab("duration",dda["text"])
local a_b=ab("time",dda["text"])local b_b={}local c_b=dda["text"]["text"]
if(c_b~=nil)then if(c_b.properties~=nil)then
c_b={c_b}end;for d_b,_ab in pairs(c_b)do
table.insert(b_b,_ab:value())end end;if(__b~=nil)and(#b_b>0)then
cda:changeText(__b,a_b or 0,table.unpack(b_b))end end;if(ab("onDone",dda)~=nil)then
cda:generateXMLEventFunction(cda.onDone,ab("onDone",dda))end;if(ab("onStart",dda)~=nil)then
cda:generateXMLEventFunction(cda.onDone,ab("onStart",dda))end
if
(ab("autoDestroy",dda)~=nil)then if(ab("autoDestroy",dda))then aca=true end end;bca=ab("mode",dda)or bca
if(ab("play",dda)~=nil)then if
(ab("play",dda))then cda:play(_ca)end end;return cda end,getZIndex=function(cda)return
1 end,getName=function(cda)return cda.name end,setObject=function(cda,dda)cca=dda;return cda end,move=function(cda,dda,__b,a_b,b_b,c_b)cca=
c_b or cca
bda(dda,__b,a_b,b_b or 0,cca.getPosition,cca.setPosition,"position",cda)return cda end,offset=function(cda,dda,__b,a_b,b_b,c_b)cca=
c_b or cca
bda(dda,__b,a_b,b_b or 0,cca.getOffset,cca.setOffset,"offset",cda)return cda end,size=function(cda,dda,__b,a_b,b_b,c_b)cca=c_b or
cca
bda(dda,__b,a_b,b_b or 0,cca.getSize,cca.setSize,"size",cda)return cda end,changeText=function(cda,dda,__b,...)
local a_b={...}__b=__b or 0;cca=obj or cca;for n=1,#a_b do
ada(__b+n* (dda/#a_b),function()
cca.setText(cca,a_b[n])end)end;return cda end,changeBackground=function(cda,dda,__b,...)
local a_b={...}__b=__b or 0;cca=obj or cca;for n=1,#a_b do
ada(__b+n* (dda/#a_b),function()
cca.setBackground(cca,a_b[n])end)end;return cda end,changeTextColor=function(cda,dda,__b,...)
local a_b={...}__b=__b or 0;cca=obj or cca;for n=1,#a_b do
ada(__b+n* (dda/#a_b),function()
cca.setForeground(cca,a_b[n])end)end;return cda end,add=function(cda,dda,__b)
dba=dda
ada((__b or cba)+
(baa[#baa]~=nil and baa[#baa].t or 0),dda)return cda end,wait=function(cda,dda)cba=dda;return cda end,rep=function(cda,dda)
if(
dba~=nil)then for n=1,dda or 1 do
ada((wait or cba)+
(baa[#baa]~=nil and baa[#baa].t or 0),dba)end end;return cda end,onDone=function(cda,dda)
bba:registerEvent("animation_done",dda)return cda end,onStart=function(cda,dda)
bba:registerEvent("animation_start",dda)return cda end,setAutoDestroy=function(cda,dda)
aca=dda~=nil and dda or true;return cda end,animationDoneHandler=function(cda)
bba:sendEvent("animation_done",cda)cda.parent:removeEvent("other_event",cda)if(aca)then
cda.parent:removeObject(cda)cda=nil end end,animationStartHandler=function(cda)
bba:sendEvent("animation_start",cda)end,clear=function(cda)baa={}dba=nil;cba=0;_ba=1;caa=0;aba=false;return cda end,play=function(cda,dda)
cda:cancel()daa=true;aba=dda and true or false;_ba=1;caa=0
if(baa[_ba]~=nil)then
if(
baa[_ba].t>0)then aaa=os.startTimer(baa[_ba].t)else _da(cda)end else cda:animationDoneHandler()end;cda.parent:addEvent("other_event",cda)return cda end,cancel=function(cda)if(
aaa~=nil)then os.cancelTimer(aaa)aba=false end
daa=false;cda.parent:removeEvent("other_event",cda)return cda end,internalObjetCall=function(cda)
cda:play(_ca)end,eventHandler=function(cda,dda,__b)if(daa)then
if(dda=="timer")and(__b==aaa)then if(baa[_ba]~=nil)then
_da(cda)else cda:animationDoneHandler()end end end end}d_a.__index=d_a;return d_a end end
aa["objects"]["Graphic"]=function(...)local ab=da("Object")
local bb=da("geometricPoints")local cb=da("tHex")local db=da("utils").getValueFromXML
local _c,ac,bc,cc=string.sub,string.len,math.max,math.min
return
function(dc)local _d=ab(dc)local ad="Graphic"_d:setZIndex(2)local bd={}local cd={}local dd={}
local __a=false;local a_a,b_a=0,0;local c_a=false;local d_a,_aa;local aaa,baa=40,15;local caa=false;local daa={}for n=1,16 do daa[string.byte("0123456789abcdef",n,n)]=
2 ^ (n-1)end
local function _ba(aca)local bca={}for i=1,
#aca do bca[i]=aca:sub(i,i)end;return bca end
local function aba(aca,bca,cca,dca,_da)
if(bca>=1)and(bca<=dca)then
if(aca+ac(_da)>0)and(aca<=cca)then
local ada=cd[bca]local bda;local cda=aca+#_da-1
if(aca<1)then
_da=_c(_da,1 -aca+1,cca-aca+1)elseif(cda>cca)then _da=_c(_da,1,cca-aca+1)end
if(aca>1)then bda=_c(ada,1,aca-1).._da else bda=_da end;if cda<cca then bda=bda.._c(ada,cda+1,cca)end
cd[bca]=bda end end end
local function bba()local aca,bca=aaa,baa;if(__a)then aca=aca*2;bca=bca*3 end
for y=1,bca do
if(cd[y]~=nil)then if(aca>
cd[y]:len())then cd[y]=cd[y]..
(cb[_d.bgColor]):rep(aca-cd[y]:len())else
cd[y]=cd[y]:sub(1,aca)end else
cd[y]=(cb[_d.bgColor]):rep(aca)end end end;bba()
local function cba()
local function aca(d_b,_ab)local aab={}for x=1,_ab:len()do
aab[x]=daa[string.byte(_ab,x,x)]or 0 end;table.insert(d_b,aab)end
function parseImage(d_b)if type(d_b)~="string"then
error("bad argument #1 (expected string, got "..type(d_b)..")")end;local _ab={}for aab in
(d_b.."\n"):gmatch("(.-)\n")do aca(_ab,aab)end;return _ab end;local bca=""for y=1,#cd do
if(y==#cd)then bca=bca..cd[y]else bca=bca..cd[y].."\n"end end;local cca=parseImage(bca)
local dca={[0]={8,4,3,6,5},{4,14,8,7},{6,10,8,7},{9,11,8,0},{1,14,8,0},{13,12,8,0},{2,10,8,0},{15,8,10,11,12,14},{0,7,1,9,2,13},{3,11,8,7},{2,6,7,15},{9,3,7,15},{13,5,7,15},{5,12,8,7},{1,4,7,15},{7,10,11,12,14}}local _da,ada,bda={},{},{}for i=0,15 do ada[2 ^i]=i end
do local d_b="0123456789abcdef"
for i=1,16 do _da[d_b:sub(i,i)]=
i-1;_da[i-1]=d_b:sub(i,i)
bda[d_b:sub(i,i)]=2 ^ (i-1)bda[2 ^ (i-1)]=d_b:sub(i,i)local _ab=dca[i-1]for i=1,#_ab do
_ab[i]=2 ^_ab[i]end end end
local function cda(d_b)local _ab=dca[ada[d_b[#d_b][1]]]
for j=1,#_ab do local aab=_ab[j]for i=1,
#d_b-1 do if d_b[i][1]==aab then return i end end end;return 1 end
local function dda(d_b,_ab)
if not _ab then local bab={}_ab={}for i=1,6 do local cab=d_b[i]local dab=_ab[cab]
_ab[cab],bab[i]=dab and(dab+1)or 1,cab end;d_b=bab end;local aab={}for bab,cab in pairs(_ab)do aab[#aab+1]={bab,cab}end
if#
aab>1 then
while#aab>2 do
table.sort(aab,function(bbb,cbb)return bbb[2]>cbb[2]end)local cab,dab=cda(aab),#aab;local _bb,abb=aab[dab][1],aab[cab][1]for i=1,6 do
if d_b[i]==
_bb then d_b[i]=abb;aab[cab][2]=aab[cab][2]+1 end end;aab[dab]=nil end;local bab=128;for i=1,#d_b-1 do
if d_b[i]~=d_b[6]then bab=bab+2 ^ (i-1)end end;return string.char(bab),bda[aab[1][1]==d_b[6]and
aab[2][1]or aab[1][1]],
bda[d_b[6]]else
return"\128",bda[d_b[1]],bda[d_b[1]]end end
local __b,a_b,b_b,c_b={{},{},{}},0,#cca+#cca%3,_d.bgColor or colors.black
for i=1,#cca do if#cca[i]>a_b then a_b=#cca[i]end end
for y=0,b_b-1,3 do local d_b,_ab,aab,bab={},{},{},1
for x=0,a_b-1,2 do local cab,dab={},{}
for yy=1,3 do
for xx=1,2 do
cab[#cab+1]=
(cca[y+yy]and cca[y+yy][
x+xx])and(cca[y+yy][x+xx]==0 and c_b or cca[y+yy][
x+xx])or c_b;dab[cab[#cab]]=
dab[cab[#cab]]and(dab[cab[#cab]]+1)or 1 end end;d_b[bab],_ab[bab],aab[bab]=dda(cab,dab)bab=bab+1 end
__b[1][#__b[1]+1],__b[2][#__b[2]+1],__b[3][#__b[3]+1]=table.concat(d_b),table.concat(_ab),table.concat(aab)end;__b.width,__b.height=#__b[1][1],#__b[1]dd=__b end
local function dba()local aca,bca=aaa,baa;if(__a)then aca=aca*2;bca=bca*3 end;for cca,dca in pairs(bd)do
for _da,ada in
pairs(dca[1])do aba(ada.x,ada.y,aca,bca,dca[2])end end;if(__a)then cba()end end
local _ca={init=function(aca)aca.bgColor=aca.parent:getTheme("GraphicBG")end,getType=function(aca)return
ad end,setSize=function(aca,bca,cca,dca)_d.setSize(aca,bca,cca,dca)if not(caa)then aaa=bca
baa=cca;bba()end;dba()return aca end,setOffset=function(aca,bca,cca)a_a=
bca or a_a;b_a=cca or b_a;return aca end,setCanvasSize=function(aca,bca,cca)
aaa,baa=bca,cca;caa=true;bba()return aca end,clearCanvas=function(aca)bd={}cd={}bba()end,getOffset=function(aca)return
a_a,b_a end,setValuesByXMLData=function(aca,bca)_d.setValuesByXMLData(aca,bca)
if(
db("text",bca)~=nil)then aca:setText(db("text",bca))end;if(db("xOffset",bca)~=nil)then
aca:setOffset(db("xOffset",bca),b_a)end;if(db("yOffset",bca)~=nil)then
aca:setOffset(a_a,db("yOffset",bca))end;if(db("wCanvas",bca)~=nil)then
aaa=db("wCanvas",bca)end;if(db("hCanvas",bca)~=nil)then
baa=db("hCanvas",bca)end;if(db("shrink",bca)~=nil)then if(db("shrink",bca))then
aca:shrink()end end
if
(db("dragable",bca)~=nil)then if(db("dragable",bca))then c_a=true end end
if(bca["ellipse"]~=nil)then local cca=bca["ellipse"]if(cca.properties~=nil)then
cca={cca}end
for dca,_da in pairs(cca)do local ada=colors[db("color",_da)]
local bda=db("radius",_da)local cda=db("radius2",_da)local dda=db("x",_da)local __b=db("y",_da)
local a_b=db("filled",_da)aca:addEllipse(ada,bda,cda,dda,__b,a_b)end end
if(bca["circle"]~=nil)then local cca=bca["circle"]if(cca.properties~=nil)then
cca={cca}end
for dca,_da in pairs(cca)do local ada=colors[db("color",_da)]
local bda=tonumber(db("radius",_da))local cda=tonumber(db("x",_da))
local dda=tonumber(db("y",_da))local __b=db("filled",_da)
aca:addCircle(ada,bda,cda,dda,__b)end end
if(bca["line"]~=nil)then local cca=bca["line"]
if(cca.properties~=nil)then cca={cca}end
for dca,_da in pairs(cca)do local ada=colors[db("color",_da)]
local bda=tonumber(db("x",_da))local cda=tonumber(db("x2",_da))
local dda=tonumber(db("y",_da))local __b=tonumber(db("y2",_da))
aca:addLine(ada,bda,dda,cda,__b)end end
if(bca["rectangle"]~=nil)then local cca=bca["rectangle"]if
(cca.properties~=nil)then cca={cca}end
for dca,_da in pairs(cca)do
local ada=colors[db("color",_da)]local bda=tonumber(db("x",_da))
local cda=tonumber(db("x2",_da))local dda=tonumber(db("y",_da))
local __b=tonumber(db("y2",_da))
local a_b=db("filled",_da)=="true"and true or false;aca:addRectangle(ada,bda,dda,cda,__b,a_b)end end
if(bca["triangle"]~=nil)then local cca=bca["triangle"]if(cca.properties~=nil)then
cca={cca}end
for dca,_da in pairs(cca)do local ada=colors[db("color",_da)]
local bda=tonumber(db("x",_da))local cda=tonumber(db("x2",_da))
local dda=tonumber(db("x2",_da))local __b=tonumber(db("y",_da))
local a_b=tonumber(db("y2",_da))local b_b=tonumber(db("y3",_da))local c_b=db("filled",_da)
aca:addTriangle(ada,bda,__b,cda,a_b,dda,b_b,c_b)end end;return aca end,addCircle=function(aca,bca,cca,dca,_da,ada)
local bda=cb[bca]
table.insert(bd,{bb.circle(dca or 1,_da or 1,cca,ada),cb[bca]})dba()return aca end,addEllipse=function(aca,bca,cca,dca,_da,ada,bda)
table.insert(bd,{bb.ellipse(
_da or 1,ada or 1,cca,dca,bda),cb[bca]})dba()return aca end,addLine=function(aca,bca,cca,dca,_da,ada)
table.insert(bd,{bb.line(
cca or 1,dca or 1,_da or 1,ada or 1),cb[bca]})dba()return aca end,addTriangle=function(aca,bca,cca,dca,_da,ada,bda,cda,dda)
table.insert(bd,{bb.triangle(
cca or 1,dca or 1,_da or 1,ada or 1,bda or 1,cda or 1,dda),cb[bca]})dba()return aca end,addRectangle=function(aca,bca,cca,dca,_da,ada,bda)
table.insert(bd,{bb.rectangle(
cca or 1,dca or 1,_da or 1,ada or 1,bda),cb[bca]})dba()return aca end,shrink=function(aca)
__a=true;bba()cba()return aca end,setDragable=function(aca,bca)
c_a=bca==true and true or false;return aca end,mouseHandler=function(aca,bca,cca,dca,_da)
if(_d.mouseHandler(aca,bca,cca,dca,_da))then
if
(c_a)then if(bca=="mouse_click")then d_a,_aa=dca,_da end
if(bca=="mouse_drag")then
if
(d_a~=nil)and(_aa~=nil)then
a_a=bc(cc(a_a+d_a-dca,aaa-aca:getWidth()),0)d_a=dca
b_a=bc(cc(b_a+_aa-_da,baa-aca:getHeight()),0)_aa=_da end end end;return true end;return false end,draw=function(aca)
if
(_d.draw(aca))then
if(aca.parent~=nil)then local bca,cca=aca:getAnchorPosition()
local dca,_da=aca:getSize()if(aca.bgColor~=false)then
aca.parent:drawBackgroundBox(bca,cca,dca,_da,aca.bgColor)end
if(__a)then
local ada,bda,cda=dd[1],dd[2],dd[3]
for i=1,dd.height do local dda,__b=bca+a_a,cca+i-1 +b_a
if(__b>cca-1)and
(__b<=cca+_da-1)and(dda<=dca+bca)then local a_b=ada[i]
local b_b,c_b,d_b=bc(dda,bca),bc(
1 -dda+1,1),cc(dca- (dda-bca),dca)
if type(a_b)=="string"then
aca.parent:setText(b_b,__b,_c(a_b,c_b,d_b))
aca.parent:setFG(b_b,__b,_c(bda[i],c_b,d_b))
aca.parent:setBG(b_b,__b,_c(cda[i],c_b,d_b))elseif type(a_b)=="table"then
aca.parent:setText(b_b,__b,_c(a_b[2],c_b,d_b))
aca.parent:setFG(b_b,__b,_c(bda[i],c_b,d_b))
aca.parent:setBG(b_b,__b,_c(cda[i],c_b,d_b))end end end else
for i=1,#cd do local ada,bda=bca+a_a,cca+i-1 +b_a
if
(bda>cca-1)and(bda<=cca+_da-1)and(ada<=dca+bca)then local cda,dda,__b=bc(ada,bca),bc(1 -ada+1,1),cc(dca-
(ada-bca),dca)
aca.parent:setBG(cda,bda,_c(cd[i],dda,__b))end end end end;aca:setVisualChanged(false)end end}return setmetatable(_ca,_d)end end
aa["objects"]["Scrollbar"]=function(...)local ab=da("Object")
local bb=da("utils").getValueFromXML
return
function(cb)local db=ab(cb)local _c="Scrollbar"db.width=1;db.height=8;db:setValue(1)
db:setZIndex(2)local ac="vertical"local bc=" "local cc;local dc="\127"local _d=db.height;local ad=1;local bd=1
local function cd(__a,a_a,b_a,c_a)
local d_a,_aa=__a:getAbsolutePosition(__a:getAnchorPosition())local aaa,baa=__a:getSize()
if(ac=="horizontal")then
for _index=0,aaa do
if
(d_a+_index==b_a)and(_aa<=c_a)and(_aa+baa>c_a)then
ad=math.min(_index+1,aaa- (bd-1))__a:setValue(_d/aaa* (ad))__a:updateDraw()end end end
if(ac=="vertical")then
for _index=0,baa do
if
(_aa+_index==c_a)and(d_a<=b_a)and(d_a+aaa>b_a)then ad=math.min(_index+1,baa- (bd-1))
__a:setValue(_d/baa* (ad))__a:updateDraw()end end end end
local dd={getType=function(__a)return _c end,setSymbol=function(__a,a_a)bc=a_a:sub(1,1)__a:updateDraw()return __a end,setValuesByXMLData=function(__a,a_a)
db.setValuesByXMLData(__a,a_a)
if(bb("maxValue",a_a)~=nil)then _d=bb("maxValue",a_a)end;if(bb("backgroundSymbol",a_a)~=nil)then
dc=bb("backgroundSymbol",a_a):sub(1,1)end;if(bb("symbol",a_a)~=nil)then
bc=bb("symbol",a_a):sub(1,1)end;if(bb("barType",a_a)~=nil)then
ac=bb("barType",a_a):lower()end;if(bb("symbolSize",a_a)~=nil)then
__a:setSymbolSize(bb("symbolSize",a_a))end;if(bb("symbolColor",a_a)~=nil)then
cc=colors[bb("symbolColor",a_a)]end;if(bb("index",a_a)~=nil)then
__a:setIndex(bb("index",a_a))end end,setIndex=function(__a,a_a)
ad=a_a;if(ad<1)then ad=1 end;local b_a,c_a=__a:getSize()
ad=math.min(ad,(
ac=="vertical"and c_a or b_a)- (bd-1))
__a:setValue(_d/ (ac=="vertical"and c_a or b_a)*ad)__a:updateDraw()return __a end,getIndex=function(__a)return
ad end,setSymbolSize=function(__a,a_a)bd=tonumber(a_a)or 1
local b_a,c_a=__a:getSize()
if(ac=="vertical")then
__a:setValue(ad-1 * (_d/ (c_a- (bd-1)))- (_d/ (c_a-
(bd-1))))elseif(ac=="horizontal")then
__a:setValue(ad-1 * (_d/ (b_a- (bd-1)))- (_d/ (b_a- (
bd-1))))end;__a:updateDraw()return __a end,setMaxValue=function(__a,a_a)
_d=a_a;__a:updateDraw()return __a end,setBackgroundSymbol=function(__a,a_a)
dc=string.sub(a_a,1,1)__a:updateDraw()return __a end,setSymbolColor=function(__a,a_a)cc=a_a
__a:updateDraw()return __a end,setBarType=function(__a,a_a)ac=a_a:lower()
__a:updateDraw()return __a end,mouseHandler=function(__a,a_a,b_a,c_a)if(db.mouseHandler(__a,a_a,b_a,c_a))then
cd(__a,a_a,b_a,c_a)return true end;return false end,dragHandler=function(__a,a_a,b_a,c_a)if
(db.dragHandler(__a,a_a,b_a,c_a))then cd(__a,a_a,b_a,c_a)return true end
return false end,scrollHandler=function(__a,a_a,b_a,c_a)
if
(db.scrollHandler(__a,a_a,b_a,c_a))then local d_a,_aa=__a:getSize()ad=ad+a_a;if(ad<1)then ad=1 end
ad=math.min(ad,(
ac=="vertical"and _aa or d_a)- (bd-1))
__a:setValue(_d/ (ac=="vertical"and _aa or d_a)*ad)__a:updateDraw()end end,draw=function(__a)
if
(db.draw(__a))then
if(__a.parent~=nil)then local a_a,b_a=__a:getAnchorPosition()
local c_a,d_a=__a:getSize()
if(ac=="horizontal")then
__a.parent:writeText(a_a,b_a,dc:rep(ad-1),__a.bgColor,__a.fgColor)
__a.parent:writeText(a_a+ad-1,b_a,bc:rep(bd),cc,cc)
__a.parent:writeText(a_a+ad+bd-1,b_a,dc:rep(c_a- (ad+bd-1)),__a.bgColor,__a.fgColor)end
if(ac=="vertical")then
for n=0,d_a-1 do
if(ad==n+1)then
for curIndexOffset=0,math.min(bd-1,d_a)do __a.parent:writeText(a_a,b_a+n+
curIndexOffset,bc,cc,cc)end else if(n+1 <ad)or(n+1 >ad-1 +bd)then
__a.parent:writeText(a_a,b_a+n,dc,__a.bgColor,__a.fgColor)end end end end end end end,init=function(__a)
__a.bgColor=__a.parent:getTheme("ScrollbarBG")__a.fgColor=__a.parent:getTheme("ScrollbarText")
cc=__a.parent:getTheme("ScrollbarSymbolColor")__a.parent:addEvent("mouse_click",__a)
__a.parent:addEvent("mouse_drag",__a)__a.parent:addEvent("mouse_scroll",__a)end}return setmetatable(dd,db)end end
aa["objects"]["Checkbox"]=function(...)local ab=da("Object")local bb=da("utils")
local cb=bb.getValueFromXML
return
function(db)local _c=ab(db)local ac="Checkbox"_c:setZIndex(5)
_c:setValue(false)_c.width=1;_c.height=1;local bc="\42"
local cc={getType=function(dc)return ac end,setSymbol=function(dc,_d)bc=_d
dc:updateDraw()return dc end,mouseHandler=function(dc,_d,ad,bd)
if(_c.mouseHandler(dc,_d,ad,bd))then
if(_d==1)then
if(
dc:getValue()~=true)and(dc:getValue()~=false)then
dc:setValue(false)else dc:setValue(not dc:getValue())end;dc:updateDraw()return true end end;return false end,touchHandler=function(dc,_d,ad)return
dc:mouseHandler(1,_d,ad)end,setValuesByXMLData=function(dc,_d)
_c.setValuesByXMLData(dc,_d)
if(cb("checked",_d)~=nil)then if(cb("checked",_d))then dc:setValue(true)else
dc:setValue(false)end end;return dc end,draw=function(dc)
if
(_c.draw(dc))then
if(dc.parent~=nil)then local _d,ad=dc:getAnchorPosition()
local bd,cd=dc:getSize()local dd=bb.getTextVerticalAlign(cd,"center")if
(dc.bgColor~=false)then
dc.parent:drawBackgroundBox(_d,ad,bd,cd,dc.bgColor)end
for n=1,cd do
if(n==dd)then
if(dc:getValue()==true)then
dc.parent:writeText(_d,
ad+ (n-1),bb.getTextHorizontalAlign(bc,bd,"center"),dc.bgColor,dc.fgColor)else
dc.parent:writeText(_d,ad+ (n-1),bb.getTextHorizontalAlign(" ",bd,"center"),dc.bgColor,dc.fgColor)end end end end end end,init=function(dc)
_c.init(dc)dc.bgColor=dc.parent:getTheme("CheckboxBG")
dc.fgColor=dc.parent:getTheme("CheckboxText")dc.parent:addEvent("mouse_click",dc)end}return setmetatable(cc,_c)end end
aa["objects"]["List"]=function(...)local ab=da("Object")local bb=da("utils")
local cb=bb.getValueFromXML
return
function(db)local _c=ab(db)local ac="List"_c.width=16;_c.height=6;_c:setZIndex(5)local bc={}
local cc;local dc;local _d=true;local ad="left"local bd=0;local cd=true
local dd={getType=function(__a)return ac end,addItem=function(__a,a_a,b_a,c_a,...)
table.insert(bc,{text=a_a,bgCol=b_a or __a.bgColor,fgCol=
c_a or __a.fgColor,args={...}})if(#bc==1)then __a:setValue(bc[1])end
__a:updateDraw()return __a end,setOffset=function(__a,a_a)
bd=a_a;__a:updateDraw()return __a end,getOffset=function(__a)return bd end,removeItem=function(__a,a_a)
table.remove(bc,a_a)__a:updateDraw()return __a end,getItem=function(__a,a_a)
return bc[a_a]end,getAll=function(__a)return bc end,getItemIndex=function(__a)local a_a=__a:getValue()for b_a,c_a in pairs(bc)do if
(c_a==a_a)then return b_a end end end,clear=function(__a)
bc={}__a:setValue({})__a:updateDraw()return __a end,getItemCount=function(__a)return
#bc end,editItem=function(__a,a_a,b_a,c_a,d_a,...)table.remove(bc,a_a)
table.insert(bc,a_a,{text=b_a,bgCol=c_a or __a.bgColor,fgCol=
d_a or __a.fgColor,args={...}})__a:updateDraw()return __a end,selectItem=function(__a,a_a)__a:setValue(
bc[a_a]or{})__a:updateDraw()return __a end,setSelectedItem=function(__a,a_a,b_a,c_a)cc=
a_a or __a.bgColor;dc=b_a or __a.fgColor;_d=c_a~=nil and c_a or
true;__a:updateDraw()return __a end,setScrollable=function(__a,a_a)
cd=a_a;if(a_a==nil)then cd=true end;__a:updateDraw()return __a end,setValuesByXMLData=function(__a,a_a)
_c.setValuesByXMLData(__a,a_a)if(cb("selectionBG",a_a)~=nil)then
cc=colors[cb("selectionBG",a_a)]end;if(cb("selectionFG",a_a)~=nil)then
dc=colors[cb("selectionFG",a_a)]end;if(cb("scrollable",a_a)~=nil)then
if
(cb("scrollable",a_a))then __a:setScrollable(true)else __a:setScrollable(false)end end;if(
cb("offset",a_a)~=nil)then bd=cb("offset",a_a)end
if(a_a["item"]~=
nil)then local b_a=a_a["item"]
if(b_a.properties~=nil)then b_a={b_a}end;for c_a,d_a in pairs(b_a)do
__a:addItem(cb("text",d_a),colors[cb("bg",d_a)],colors[cb("fg",d_a)])end end;return __a end,scrollHandler=function(__a,a_a,b_a,c_a)
if
(_c.scrollHandler(__a,a_a,b_a,c_a))then
if(cd)then local d_a,_aa=__a:getSize()bd=bd+a_a;if(bd<0)then bd=0 end
if(a_a>=1)then if(#bc>_aa)then if(bd>
#bc-_aa)then bd=#bc-_aa end;if(bd>=#bc)then bd=#bc-1 end else bd=
bd-1 end end;__a:updateDraw()end;return true end;return false end,mouseHandler=function(__a,a_a,b_a,c_a)
if
(_c.mouseHandler(__a,a_a,b_a,c_a))then
local d_a,_aa=__a:getAbsolutePosition(__a:getAnchorPosition())local aaa,baa=__a:getSize()
if(#bc>0)then for n=1,baa do
if(bc[n+bd]~=nil)then if(d_a<=b_a)and
(d_a+aaa>b_a)and(_aa+n-1 ==c_a)then
__a:setValue(bc[n+bd])__a:updateDraw()end end end end;return true end;return false end,dragHandler=function(__a,a_a,b_a,c_a)return
__a:mouseHandler(a_a,b_a,c_a)end,touchHandler=function(__a,a_a,b_a)return
__a:mouseHandler(1,a_a,b_a)end,draw=function(__a)
if(_c.draw(__a))then
if
(__a.parent~=nil)then local a_a,b_a=__a:getAnchorPosition()local c_a,d_a=__a:getSize()if(
__a.bgColor~=false)then
__a.parent:drawBackgroundBox(a_a,b_a,c_a,d_a,__a.bgColor)end
for n=1,d_a do
if(bc[n+bd]~=nil)then
if(bc[n+bd]==
__a:getValue())then
if(_d)then
__a.parent:writeText(a_a,b_a+n-1,bb.getTextHorizontalAlign(bc[n+bd].text,c_a,ad),cc,dc)else
__a.parent:writeText(a_a,b_a+n-1,bb.getTextHorizontalAlign(bc[n+bd].text,c_a,ad),bc[
n+bd].bgCol,bc[n+bd].fgCol)end else
__a.parent:writeText(a_a,b_a+n-1,bb.getTextHorizontalAlign(bc[n+bd].text,c_a,ad),bc[
n+bd].bgCol,bc[n+bd].fgCol)end end end end end end,init=function(__a)
__a.bgColor=__a.parent:getTheme("ListBG")__a.fgColor=__a.parent:getTheme("ListText")
cc=__a.parent:getTheme("SelectionBG")dc=__a.parent:getTheme("SelectionText")
__a.parent:addEvent("mouse_click",__a)__a.parent:addEvent("mouse_drag",__a)
__a.parent:addEvent("mouse_scroll",__a)end}return setmetatable(dd,_c)end end
aa["objects"]["Switch"]=function(...)local ab=da("Object")
local bb=da("utils").getValueFromXML
return
function(cb)local db=ab(cb)local _c="Switch"db.width=2;db.height=1
db.bgColor=colors.lightGray;db.fgColor=colors.gray;db:setValue(false)db:setZIndex(5)
local ac=colors.black;local bc=colors.red;local cc=colors.green
local dc={getType=function(_d)return _c end,setSymbolColor=function(_d,ad)ac=ad
_d:updateDraw()return _d end,setActiveBackground=function(_d,ad)cc=ad;_d:updateDraw()return _d end,setInactiveBackground=function(_d,ad)
bc=ad;_d:updateDraw()return _d end,setValuesByXMLData=function(_d,ad)
db.setValuesByXMLData(_d,ad)if(bb("inactiveBG",ad)~=nil)then
bc=colors[bb("inactiveBG",ad)]end;if(bb("activeBG",ad)~=nil)then
cc=colors[bb("activeBG",ad)]end;if(bb("symbolColor",ad)~=nil)then
ac=colors[bb("symbolColor",ad)]end end,mouseHandler=function(_d,ad,bd,cd)
if
(db.mouseHandler(_d,ad,bd,cd))then
local dd,__a=_d:getAbsolutePosition(_d:getAnchorPosition())_d:setValue(not _d:getValue())
_d:updateDraw()return true end end,draw=function(_d)
if
(db.draw(_d))then
if(_d.parent~=nil)then local ad,bd=_d:getAnchorPosition()
local cd,dd=_d:getSize()
_d.parent:drawBackgroundBox(ad,bd,cd,dd,_d.bgColor)
if(_d:getValue())then
_d.parent:drawBackgroundBox(ad,bd,1,dd,cc)_d.parent:drawBackgroundBox(ad+1,bd,1,dd,ac)else
_d.parent:drawBackgroundBox(ad,bd,1,dd,ac)_d.parent:drawBackgroundBox(ad+1,bd,1,dd,bc)end end end end,init=function(_d)
_d.bgColor=_d.parent:getTheme("SwitchBG")_d.fgColor=_d.parent:getTheme("SwitchText")
ac=_d.parent:getTheme("SwitchBGSymbol")bc=_d.parent:getTheme("SwitchInactive")
cc=_d.parent:getTheme("SwitchActive")_d.parent:addEvent("mouse_click",_d)end}return setmetatable(dc,db)end end
aa["objects"]["Pane"]=function(...)local ab=da("Object")local bb=da("basaltLogs")
return
function(cb)
local db=ab(cb)local _c="Pane"
local ac={getType=function(bc)return _c end,setBackground=function(bc,cc,dc,_d)db.setBackground(bc,cc,dc,_d)
return bc end,init=function(bc)
if(db.init(bc))then
bc.bgColor=bc.parent:getTheme("PaneBG")bc.fgColor=bc.parent:getTheme("PaneBG")end end}return setmetatable(ac,db)end end
aa["objects"]["Button"]=function(...)local ab=da("Object")local bb=da("utils")
local cb=bb.getValueFromXML;local db=da("tHex")
return
function(_c)local ac=ab(_c)local bc="Button"local cc="center"local dc="center"
ac:setZIndex(5)ac:setValue("Button")ac.width=12;ac.height=3
local _d={init=function(ad)
ad.bgColor=ad.parent:getTheme("ButtonBG")ad.fgColor=ad.parent:getTheme("ButtonText")end,getType=function(ad)return
bc end,setHorizontalAlign=function(ad,bd)cc=bd;ad:updateDraw()return ad end,setVerticalAlign=function(ad,bd)
dc=bd;ad:updateDraw()return ad end,setText=function(ad,bd)
ac:setValue(bd)ad:updateDraw()return ad end,setValuesByXMLData=function(ad,bd)
ac.setValuesByXMLData(ad,bd)
if(cb("text",bd)~=nil)then ad:setText(cb("text",bd))end;if(cb("horizontalAlign",bd)~=nil)then
cc=cb("horizontalAlign",bd)end;if(cb("verticalAlign",bd)~=nil)then
dc=cb("verticalAlign",bd)end;return ad end,draw=function(ad)
if
(ac.draw(ad))then
if(ad.parent~=nil)then local bd,cd=ad:getAnchorPosition()
local dd,__a=ad:getSize()local a_a=bb.getTextVerticalAlign(__a,dc)
for n=1,__a do
if(n==a_a)then
ad.parent:setText(bd,cd+ (
n-1),bb.getTextHorizontalAlign(ad:getValue(),dd,cc))
ad.parent:setFG(bd,cd+ (n-1),bb.getTextHorizontalAlign(db[ad.fgColor]:rep(ad:getValue():len()),dd,cc))end end end end end}return setmetatable(_d,ac)end end
aa["objects"]["Program"]=function(...)local ab=da("Object")local bb=da("tHex")
local cb=da("process")local db=da("utils").getValueFromXML;local _c=string.sub
return
function(ac,bc)local cc=ab(ac)
local dc="Program"cc:setZIndex(5)local _d;local ad;local bd={}
local function cd(baa,caa,daa,_ba,aba)local bba,cba=1,1
local dba,_ca=colors.black,colors.white;local aca=false;local bca=false;local cca={}local dca={}local _da={}local ada={}local bda;local cda={}for i=0,15 do local abb=2 ^i
ada[abb]={bc:getBasaltInstance().getBaseTerm().getPaletteColour(abb)}end;local function dda()
bda=(" "):rep(daa)
for n=0,15 do local abb=2 ^n;local bbb=bb[abb]cda[abb]=bbb:rep(daa)end end
local function __b()dda()local abb=bda
local bbb=cda[colors.white]local cbb=cda[colors.black]
for n=1,_ba do
cca[n]=_c(cca[n]==nil and abb or cca[n]..abb:sub(1,
daa-cca[n]:len()),1,daa)
_da[n]=_c(_da[n]==nil and bbb or _da[n]..
bbb:sub(1,daa-_da[n]:len()),1,daa)
dca[n]=_c(dca[n]==nil and cbb or dca[n]..
cbb:sub(1,daa-dca[n]:len()),1,daa)end;cc.updateDraw(cc)end;__b()local function a_b()if
bba>=1 and cba>=1 and bba<=daa and cba<=_ba then else end end
local function b_b(abb,bbb,cbb)
local dbb=bba;local _cb=dbb+#abb-1
if cba>=1 and cba<=_ba then
if dbb<=daa and _cb>=1 then
if dbb==1 and _cb==
daa then cca[cba]=abb;_da[cba]=bbb;dca[cba]=cbb else local acb,bcb,ccb
if dbb<1 then local __c=
1 -dbb+1;local a_c=daa-dbb+1;acb=_c(abb,__c,a_c)
bcb=_c(bbb,__c,a_c)ccb=_c(cbb,__c,a_c)elseif _cb>daa then local __c=daa-dbb+1;acb=_c(abb,1,__c)
bcb=_c(bbb,1,__c)ccb=_c(cbb,1,__c)else acb=abb;bcb=bbb;ccb=cbb end;local dcb=cca[cba]local _db=_da[cba]local adb=dca[cba]local bdb,cdb,ddb
if dbb>1 then local __c=dbb-1;bdb=
_c(dcb,1,__c)..acb;cdb=_c(_db,1,__c)..bcb
ddb=_c(adb,1,__c)..ccb else bdb=acb;cdb=bcb;ddb=ccb end
if _cb<daa then local __c=_cb+1;bdb=bdb.._c(dcb,__c,daa)
cdb=cdb.._c(_db,__c,daa)ddb=ddb.._c(adb,__c,daa)end;cca[cba]=bdb;_da[cba]=cdb;dca[cba]=ddb end;_d:updateDraw()end;bba=_cb+1;if(bca)then a_b()end end end
local function c_b(abb,bbb,cbb)
if(cbb~=nil)then local dbb=cca[bbb]if(dbb~=nil)then
cca[bbb]=_c(dbb:sub(1,abb-1)..cbb..dbb:sub(abb+
(cbb:len()),daa),1,daa)end end;_d:updateDraw()end
local function d_b(abb,bbb,cbb)
if(cbb~=nil)then local dbb=dca[bbb]if(dbb~=nil)then
dca[bbb]=_c(dbb:sub(1,abb-1)..cbb..dbb:sub(abb+
(cbb:len()),daa),1,daa)end end;_d:updateDraw()end
local function _ab(abb,bbb,cbb)
if(cbb~=nil)then local dbb=_da[bbb]if(dbb~=nil)then
_da[bbb]=_c(dbb:sub(1,abb-1)..cbb..dbb:sub(abb+
(cbb:len()),daa),1,daa)end end;_d:updateDraw()end
local aab=function(abb)
if type(abb)~="number"then
error("bad argument #1 (expected number, got "..type(abb)..")",2)elseif bb[abb]==nil then
error("Invalid color (got "..abb..")",2)end;_ca=abb end
local bab=function(abb)
if type(abb)~="number"then
error("bad argument #1 (expected number, got "..type(abb)..")",2)elseif bb[abb]==nil then
error("Invalid color (got "..abb..")",2)end;dba=abb end
local cab=function(abb,bbb,cbb,dbb)if type(abb)~="number"then
error("bad argument #1 (expected number, got "..type(abb)..")",2)end
if bb[abb]==nil then error("Invalid color (got "..
abb..")",2)end;local _cb
if
type(bbb)=="number"and cbb==nil and dbb==nil then _cb={colours.rgb8(bbb)}ada[abb]=_cb else if
type(bbb)~="number"then
error("bad argument #2 (expected number, got "..type(bbb)..")",2)end;if type(cbb)~="number"then
error(
"bad argument #3 (expected number, got "..type(cbb)..")",2)end;if type(dbb)~="number"then
error(
"bad argument #4 (expected number, got "..type(dbb)..")",2)end;_cb=ada[abb]_cb[1]=bbb
_cb[2]=cbb;_cb[3]=dbb end end
local dab=function(abb)if type(abb)~="number"then
error("bad argument #1 (expected number, got "..type(abb)..")",2)end
if bb[abb]==nil then error("Invalid color (got "..
abb..")",2)end;local bbb=ada[abb]return bbb[1],bbb[2],bbb[3]end
local _bb={setCursorPos=function(abb,bbb)if type(abb)~="number"then
error("bad argument #1 (expected number, got "..type(abb)..")",2)end;if type(bbb)~="number"then
error(
"bad argument #2 (expected number, got "..type(bbb)..")",2)end;bba=math.floor(abb)
cba=math.floor(bbb)if(bca)then a_b()end end,getCursorPos=function()return
bba,cba end,setCursorBlink=function(abb)if type(abb)~="boolean"then
error("bad argument #1 (expected boolean, got "..
type(abb)..")",2)end;aca=abb end,getCursorBlink=function()return
aca end,getPaletteColor=dab,getPaletteColour=dab,setBackgroundColor=bab,setBackgroundColour=bab,setTextColor=aab,setTextColour=aab,setPaletteColor=cab,setPaletteColour=cab,getBackgroundColor=function()return dba end,getBackgroundColour=function()return dba end,getSize=function()
return daa,_ba end,getTextColor=function()return _ca end,getTextColour=function()return _ca end,basalt_resize=function(abb,bbb)daa,_ba=abb,bbb;__b()end,basalt_reposition=function(abb,bbb)
baa,caa=abb,bbb end,basalt_setVisible=function(abb)bca=abb end,drawBackgroundBox=function(abb,bbb,cbb,dbb,_cb)for n=1,dbb do
d_b(abb,bbb+ (n-1),bb[_cb]:rep(cbb))end end,drawForegroundBox=function(abb,bbb,cbb,dbb,_cb)
for n=1,dbb do _ab(abb,
bbb+ (n-1),bb[_cb]:rep(cbb))end end,drawTextBox=function(abb,bbb,cbb,dbb,_cb)for n=1,dbb do
c_b(abb,bbb+ (n-1),_cb:rep(cbb))end end,writeText=function(abb,bbb,cbb,dbb,_cb)
dbb=dbb or dba;_cb=_cb or _ca;c_b(baa,bbb,cbb)
d_b(abb,bbb,bb[dbb]:rep(cbb:len()))_ab(abb,bbb,bb[_cb]:rep(cbb:len()))end,basalt_update=function()
if(
bc~=nil)then for n=1,_ba do bc:setText(baa,caa+ (n-1),cca[n])bc:setBG(baa,caa+
(n-1),dca[n])
bc:setFG(baa,caa+ (n-1),_da[n])end end end,scroll=function(abb)if
type(abb)~="number"then
error("bad argument #1 (expected number, got "..type(abb)..")",2)end
if abb~=0 then local bbb=bda
local cbb=cda[_ca]local dbb=cda[dba]
for newY=1,_ba do local _cb=newY+abb
if _cb>=1 and _cb<=_ba then
cca[newY]=cca[_cb]dca[newY]=dca[_cb]_da[newY]=_da[_cb]else cca[newY]=bbb
_da[newY]=cbb;dca[newY]=dbb end end end;if(bca)then a_b()end end,isColor=function()return
bc:getBasaltInstance().getBaseTerm().isColor()end,isColour=function()return
bc:getBasaltInstance().getBaseTerm().isColor()end,write=function(abb)
abb=tostring(abb)if(bca)then
b_b(abb,bb[_ca]:rep(abb:len()),bb[dba]:rep(abb:len()))end end,clearLine=function()
if
(bca)then c_b(1,cba,(" "):rep(daa))
d_b(1,cba,bb[dba]:rep(daa))_ab(1,cba,bb[_ca]:rep(daa))end;if(bca)then a_b()end end,clear=function()
for n=1,_ba
do c_b(1,n,(" "):rep(daa))
d_b(1,n,bb[dba]:rep(daa))_ab(1,n,bb[_ca]:rep(daa))end;if(bca)then a_b()end end,blit=function(abb,bbb,cbb)if
type(abb)~="string"then
error("bad argument #1 (expected string, got "..type(abb)..")",2)end;if type(bbb)~="string"then
error(
"bad argument #2 (expected string, got "..type(bbb)..")",2)end;if type(cbb)~="string"then
error(
"bad argument #3 (expected string, got "..type(cbb)..")",2)end
if
#bbb~=#abb or#cbb~=#abb then error("Arguments must be the same length",2)end;if(bca)then b_b(abb,bbb,cbb)end end}return _bb end;cc.width=30;cc.height=12;local dd=cd(1,1,cc.width,cc.height)local __a
local a_a=false;local b_a={}
local function c_a(baa)local caa,daa=dd.getCursorPos()
local _ba,aba=baa:getAnchorPosition()local bba,cba=baa:getSize()
if(_ba+caa-1 >=1 and
_ba+caa-1 <=_ba+bba-1 and daa+aba-1 >=1 and
daa+aba-1 <=aba+cba-1)then
baa.parent:setCursor(
baa:isFocused()and dd.getCursorBlink(),_ba+caa-1,daa+aba-1,dd.getTextColor())end end
local function d_a(baa,caa,...)local daa,_ba=__a:resume(caa,...)
if(daa==false)and(_ba~=nil)and
(_ba~="Terminated")then
local aba=baa:sendEvent("program_error",_ba)
if(aba~=false)then error("Basalt Program - ".._ba)end end
if(__a:getStatus()=="dead")then baa:sendEvent("program_done")end end
local function _aa(baa,caa,daa,_ba,aba)if(__a==nil)then return false end
if not(__a:isDead())then if not(a_a)then
local bba,cba=baa:getAbsolutePosition(baa:getAnchorPosition(
nil,nil,true))d_a(baa,caa,daa,_ba-bba+1,aba-cba+1)
c_a(baa)end end end
local function aaa(baa,caa,daa,_ba)if(__a==nil)then return false end
if not(__a:isDead())then if not(a_a)then if(baa.draw)then
d_a(baa,caa,daa,_ba)c_a(baa)end end end end
_d={getType=function(baa)return dc end,show=function(baa)cc.show(baa)
dd.setBackgroundColor(baa.bgColor)dd.setTextColor(baa.fgColor)
dd.basalt_setVisible(true)return baa end,hide=function(baa)
cc.hide(baa)dd.basalt_setVisible(false)return baa end,setPosition=function(baa,caa,daa,_ba)
cc.setPosition(baa,caa,daa,_ba)
dd.basalt_reposition(baa:getAnchorPosition())return baa end,setValuesByXMLData=function(baa,caa)
cc.setValuesByXMLData(baa,caa)if(db("path",caa)~=nil)then ad=db("path",caa)end
if(
db("execute",caa)~=nil)then if(db("execute",caa))then
if(ad~=nil)then baa:execute(ad)end end end end,getBasaltWindow=function()return
dd end,getBasaltProcess=function()return __a end,setSize=function(baa,caa,daa,_ba)cc.setSize(baa,caa,daa,_ba)
dd.basalt_resize(baa:getWidth(),baa:getHeight())return baa end,getStatus=function(baa)if(__a~=nil)then return
__a:getStatus()end;return"inactive"end,setEnviroment=function(baa,caa)bd=
caa or{}return baa end,execute=function(baa,caa,...)ad=caa or ad
__a=cb:new(ad,dd,bd,...)dd.setBackgroundColor(colors.black)
dd.setTextColor(colors.white)dd.clear()dd.setCursorPos(1,1)
dd.setBackgroundColor(baa.bgColor)dd.setTextColor(baa.fgColor)
dd.basalt_setVisible(true)d_a(baa)a_a=false
if(baa.parent~=nil)then
baa.parent:addEvent("mouse_click",baa)baa.parent:addEvent("mouse_up",baa)
baa.parent:addEvent("mouse_drag",baa)baa.parent:addEvent("mouse_scroll",baa)
baa.parent:addEvent("key",baa)baa.parent:addEvent("key_up",baa)
baa.parent:addEvent("char",baa)baa.parent:addEvent("other_event",baa)end;return baa end,stop=function(baa)
if(
__a~=nil)then
if not(__a:isDead())then d_a(baa,"terminate")if(__a:isDead())then
if(
baa.parent~=nil)then baa.parent:setCursor(false)end end end end;baa.parent:removeEvents(baa)return baa end,pause=function(baa,caa)a_a=
caa or(not a_a)
if(__a~=nil)then if not(__a:isDead())then if not(a_a)then
baa:injectEvents(b_a)b_a={}end end end;return baa end,isPaused=function(baa)return
a_a end,injectEvent=function(baa,caa,daa,_ba,aba,bba,cba)
if(__a~=nil)then
if not(__a:isDead())then if(a_a==false)or(cba)then
d_a(baa,caa,daa,_ba,aba,bba)else
table.insert(b_a,{event=caa,args={daa,_ba,aba,bba}})end end end;return baa end,getQueuedEvents=function(baa)return
b_a end,updateQueuedEvents=function(baa,caa)b_a=caa or b_a;return baa end,injectEvents=function(baa,caa)if(__a~=nil)then
if not
(__a:isDead())then for daa,_ba in pairs(caa)do
d_a(baa,_ba.event,table.unpack(_ba.args))end end end;return baa end,mouseHandler=function(baa,caa,daa,_ba)
if
(cc.mouseHandler(baa,caa,daa,_ba))then _aa(baa,"mouse_click",caa,daa,_ba)return true end;return false end,mouseUpHandler=function(baa,caa,daa,_ba)
if
(cc.mouseUpHandler(baa,caa,daa,_ba))then _aa(baa,"mouse_up",caa,daa,_ba)return true end;return false end,scrollHandler=function(baa,caa,daa,_ba)
if
(cc.scrollHandler(baa,caa,daa,_ba))then _aa(baa,"mouse_scroll",caa,daa,_ba)return true end;return false end,dragHandler=function(baa,caa,daa,_ba)
if
(cc.dragHandler(baa,caa,daa,_ba))then _aa(baa,"mouse_drag",caa,daa,_ba)return true end;return false end,keyHandler=function(baa,caa,daa)if
(cc.keyHandler(baa,caa,daa))then aaa(baa,"key",caa,daa)return true end;return
false end,keyUpHandler=function(baa,caa)if
(cc.keyUpHandler(baa,caa))then aaa(baa,"key_up",caa)return true end
return false end,charHandler=function(baa,caa)if
(cc.charHandler(baa,caa))then aaa(baa,"char",caa)return true end
return false end,getFocusHandler=function(baa)
cc.getFocusHandler(baa)
if(__a~=nil)then
if not(__a:isDead())then
if not(a_a)then
if(baa.parent~=nil)then
local caa,daa=dd.getCursorPos()local _ba,aba=baa:getAnchorPosition()local bba,cba=baa:getSize()
if
(
_ba+caa-1 >=1 and _ba+caa-1 <=_ba+bba-1 and
daa+aba-1 >=1 and daa+aba-1 <=aba+cba-1)then
baa.parent:setCursor(dd.getCursorBlink(),_ba+caa-1,daa+aba-1,dd.getTextColor())end end end end end end,loseFocusHandler=function(baa)
cc.loseFocusHandler(baa)
if(__a~=nil)then if not(__a:isDead())then if(baa.parent~=nil)then
baa.parent:setCursor(false)end end end end,eventHandler=function(baa,caa,daa,_ba,aba,bba)
if
(cc.eventHandler(baa,caa,daa,_ba,aba,bba))then if(__a==nil)then return end
if(caa=="dynamicValueEvent")then local cba,dba=dd.getSize()
local _ca,aca=baa:getSize()
if(cba~=_ca)or(dba~=aca)then dd.basalt_resize(_ca,aca)if not
(__a:isDead())then d_a(baa,"term_resize")end end
dd.basalt_reposition(baa:getAnchorPosition())end
if not(__a:isDead())then
if not(a_a)then if(caa~="terminate")then
d_a(baa,caa,daa,_ba,aba,bba)end
if(baa:isFocused())then
local cba,dba=baa:getAnchorPosition()local _ca,aca=dd.getCursorPos()
if(baa.parent~=nil)then
local bca,cca=baa:getSize()
if
(cba+_ca-1 >=1 and cba+_ca-1 <=cba+bca-1 and
aca+dba-1 >=1 and aca+dba-1 <=dba+cca-1)then
baa.parent:setCursor(dd.getCursorBlink(),cba+_ca-1,aca+dba-1,dd.getTextColor())end end;if(caa=="terminate")then d_a(baa,caa)
baa.parent:setCursor(false)return true end end else
table.insert(b_a,{event=caa,args={daa,_ba,aba,bba}})end end;return false end end,draw=function(baa)
if
(cc.draw(baa))then
if(baa.parent~=nil)then local caa,daa=baa:getAnchorPosition()
local _ba,aba=dd.getCursorPos()local bba,cba=baa:getSize()dd.basalt_reposition(caa,daa)
dd.basalt_update()
if
(caa+_ba-1 >=1 and caa+_ba-1 <=caa+bba-1 and
aba+daa-1 >=1 and aba+daa-1 <=daa+cba-1)then
baa.parent:setCursor(baa:isFocused()and dd.getCursorBlink(),
caa+_ba-1,aba+daa-1,dd.getTextColor())end end end end,onError=function(baa,...)
for caa,daa in
pairs(table.pack(...))do if(type(daa)=="function")then
baa:registerEvent("program_error",daa)end end;if(baa.parent~=nil)then
baa.parent:addEvent("other_event",baa)end;return baa end,onDone=function(baa,...)
for caa,daa in
pairs(table.pack(...))do if(type(daa)=="function")then
baa:registerEvent("program_done",daa)end end;if(baa.parent~=nil)then
baa.parent:addEvent("other_event",baa)end;return baa end,init=function(baa)
baa.bgColor=baa.parent:getTheme("ProgramBG")end}return setmetatable(_d,cc)end end
aa["objects"]["Dropdown"]=function(...)local ab=da("Object")local bb=da("utils")
local cb=da("utils").getValueFromXML
return
function(db)local _c=ab(db)local ac="Dropdown"_c.width=12;_c.height=1;_c:setZIndex(6)
local bc={}local cc;local dc;local _d=true;local ad="left"local bd=0;local cd=16;local dd=6;local __a="\16"local a_a="\31"local b_a=false
local c_a={getType=function(d_a)return
ac end,setValuesByXMLData=function(d_a,_aa)_c.setValuesByXMLData(d_a,_aa)
if(
cb("selectionBG",_aa)~=nil)then cc=colors[cb("selectionBG",_aa)]end;if(cb("selectionFG",_aa)~=nil)then
dc=colors[cb("selectionFG",_aa)]end;if(cb("dropdownWidth",_aa)~=nil)then
cd=cb("dropdownWidth",_aa)end;if(cb("dropdownHeight",_aa)~=nil)then
dd=cb("dropdownHeight",_aa)end;if(cb("offset",_aa)~=nil)then
bd=cb("offset",_aa)end
if(_aa["item"]~=nil)then local aaa=_aa["item"]if(
aaa.properties~=nil)then aaa={aaa}end;for baa,caa in pairs(aaa)do
d_a:addItem(cb("text",caa),colors[cb("bg",caa)],colors[cb("fg",caa)])end end end,setOffset=function(d_a,_aa)
bd=_aa;d_a:updateDraw()return d_a end,getOffset=function(d_a)return bd end,addItem=function(d_a,_aa,aaa,baa,...)
table.insert(bc,{text=_aa,bgCol=
aaa or d_a.bgColor,fgCol=baa or d_a.fgColor,args={...}})d_a:updateDraw()return d_a end,getAll=function(d_a)return
bc end,removeItem=function(d_a,_aa)table.remove(bc,_aa)d_a:updateDraw()
return d_a end,getItem=function(d_a,_aa)return bc[_aa]end,getItemIndex=function(d_a)
local _aa=d_a:getValue()for aaa,baa in pairs(bc)do if(baa==_aa)then return aaa end end end,clear=function(d_a)
bc={}d_a:setValue({})d_a:updateDraw()return d_a end,getItemCount=function(d_a)return
#bc end,editItem=function(d_a,_aa,aaa,baa,caa,...)table.remove(bc,_aa)
table.insert(bc,_aa,{text=aaa,bgCol=baa or d_a.bgColor,fgCol=
caa or d_a.fgColor,args={...}})d_a:updateDraw()return d_a end,selectItem=function(d_a,_aa)d_a:setValue(
bc[_aa]or{})d_a:updateDraw()return d_a end,setSelectedItem=function(d_a,_aa,aaa,baa)cc=
_aa or d_a.bgColor;dc=aaa or d_a.fgColor;_d=baa
d_a:updateDraw()return d_a end,setDropdownSize=function(d_a,_aa,aaa)cd,dd=_aa,aaa
d_a:updateDraw()return d_a end,mouseHandler=function(d_a,_aa,aaa,baa)
if(b_a)then
local caa,daa=d_a:getAbsolutePosition(d_a:getAnchorPosition())
if(_aa==1)then
if(#bc>0)then
for n=1,dd do
if(bc[n+bd]~=nil)then
if(caa<=aaa)and(caa+cd>aaa)and
(daa+n==baa)then d_a:setValue(bc[n+bd])
d_a:updateDraw()
local _ba=d_a:getEventSystem():sendEvent("mouse_click",d_a,"mouse_click",dir,aaa,baa)if(_ba==false)then return _ba end;return true end end end end end end
if(_c.mouseHandler(d_a,_aa,aaa,baa))then b_a=(not b_a)d_a:updateDraw()
return true else if(b_a)then d_a:updateDraw()b_a=false end;return false end end,mouseUpHandler=function(d_a,_aa,aaa,baa)
if
(b_a)then
local caa,daa=d_a:getAbsolutePosition(d_a:getAnchorPosition())
if(_aa==1)then
if(#bc>0)then
for n=1,dd do
if(bc[n+bd]~=nil)then
if(caa<=aaa)and(caa+cd>aaa)and
(daa+n==baa)then b_a=false;d_a:updateDraw()
local _ba=d_a:getEventSystem():sendEvent("mouse_up",d_a,"mouse_up",dir,aaa,baa)if(_ba==false)then return _ba end;return true end end end end end end end,scrollHandler=function(d_a,_aa,aaa,baa)
if
(b_a)and(d_a:isFocused())then bd=bd+_aa;if(bd<0)then bd=0 end;if(_aa==1)then
if(#bc>dd)then if(bd>
#bc-dd)then bd=#bc-dd end else bd=math.min(#bc-1,0)end end
local caa=d_a:getEventSystem():sendEvent("mouse_scroll",d_a,"mouse_scroll",_aa,aaa,baa)if(caa==false)then return caa end;d_a:updateDraw()return true end end,draw=function(d_a)
if
(_c.draw(d_a))then local _aa,aaa=d_a:getAnchorPosition()local baa,caa=d_a:getSize()
if(
d_a.parent~=nil)then if(d_a.bgColor~=false)then
d_a.parent:drawBackgroundBox(_aa,aaa,baa,caa,d_a.bgColor)end;local daa=d_a:getValue()
local _ba=bb.getTextHorizontalAlign((
daa~=nil and daa.text or""),baa,ad):sub(1,
baa-1).. (b_a and a_a or __a)
d_a.parent:writeText(_aa,aaa,_ba,d_a.bgColor,d_a.fgColor)
if(b_a)then
for n=1,dd do
if(bc[n+bd]~=nil)then
if(bc[n+bd]==daa)then
if(_d)then
d_a.parent:writeText(_aa,aaa+n,bb.getTextHorizontalAlign(bc[
n+bd].text,cd,ad),cc,dc)else
d_a.parent:writeText(_aa,aaa+n,bb.getTextHorizontalAlign(bc[n+bd].text,cd,ad),bc[
n+bd].bgCol,bc[n+bd].fgCol)end else
d_a.parent:writeText(_aa,aaa+n,bb.getTextHorizontalAlign(bc[n+bd].text,cd,ad),bc[
n+bd].bgCol,bc[n+bd].fgCol)end end end end end end end,init=function(d_a)
d_a.bgColor=d_a.parent:getTheme("DropdownBG")d_a.fgColor=d_a.parent:getTheme("DropdownText")
cc=d_a.parent:getTheme("SelectionBG")dc=d_a.parent:getTheme("SelectionText")
if
(d_a.parent~=nil)then d_a.parent:addEvent("mouse_click",d_a)
d_a.parent:addEvent("mouse_up",d_a)d_a.parent:addEvent("mouse_scroll",d_a)end end}return setmetatable(c_a,_c)end end
aa["objects"]["Input"]=function(...)local ab=da("Object")local bb=da("utils")
local cb=da("basaltLogs")local db=bb.getValueFromXML
return
function(_c)local ac=ab(_c)local bc="Input"local cc="text"local dc=0
ac:setZIndex(5)ac:setValue("")ac.width=10;ac.height=1;local _d=1;local ad=1;local bd=""local cd;local dd
local __a=bd;local a_a=false
local b_a={getType=function(c_a)return bc end,setInputType=function(c_a,d_a)if(d_a=="password")or(d_a=="number")or(d_a==
"text")then cc=d_a end
c_a:updateDraw()return c_a end,setDefaultText=function(c_a,d_a,_aa,aaa)bd=d_a
cd=aaa or cd;dd=_aa or dd;if(c_a:isFocused())then __a=""else __a=bd end
c_a:updateDraw()return c_a end,getInputType=function(c_a)
return cc end,setValue=function(c_a,d_a)ac.setValue(c_a,tostring(d_a))
if not(a_a)then
if
(c_a:isFocused())then _d=tostring(d_a):len()+1;ad=math.max(1,_d-
c_a:getWidth()+1)
local _aa,aaa=c_a:getAnchorPosition()
c_a.parent:setCursor(true,_aa+_d-ad,aaa+
math.floor(c_a:getHeight()/2),c_a.fgColor)end end;c_a:updateDraw()return c_a end,getValue=function(c_a)
local d_a=ac.getValue(c_a)
return cc=="number"and tonumber(d_a)or d_a end,setInputLimit=function(c_a,d_a)
dc=tonumber(d_a)or dc;c_a:updateDraw()return c_a end,getInputLimit=function(c_a)return dc end,setValuesByXMLData=function(c_a,d_a)
ac.setValuesByXMLData(c_a,d_a)local _aa,aaa
if(db("defaultBG",d_a)~=nil)then _aa=db("defaultBG",d_a)end
if(db("defaultFG",d_a)~=nil)then aaa=db("defaultFG",d_a)end;if(db("default",d_a)~=nil)then
c_a:setDefaultText(db("default",d_a),aaa~=nil and colors[aaa],
_aa~=nil and colors[_aa])end
if(db("limit",d_a)~=
nil)then c_a:setInputLimit(db("limit",d_a))end;if(db("type",d_a)~=nil)then
c_a:setInputType(db("type",d_a))end;return c_a end,getFocusHandler=function(c_a)
ac.getFocusHandler(c_a)
if(c_a.parent~=nil)then local d_a,_aa=c_a:getAnchorPosition()__a=""if(bd~="")then
c_a:updateDraw()end
c_a.parent:setCursor(true,d_a+_d-ad,_aa+math.max(math.ceil(
c_a:getHeight()/2 -1,1)),c_a.fgColor)end end,loseFocusHandler=function(c_a)
ac.loseFocusHandler(c_a)if(c_a.parent~=nil)then __a=bd;if(bd~="")then c_a:updateDraw()end
c_a.parent:setCursor(false)end end,keyHandler=function(c_a,d_a)
if
(ac.keyHandler(c_a,d_a))then local _aa,aaa=c_a:getSize()a_a=true
if(d_a==keys.backspace)then
local bba=tostring(ac.getValue())if(_d>1)then
c_a:setValue(bba:sub(1,_d-2)..bba:sub(_d,bba:len()))if(_d>1)then _d=_d-1 end
if(ad>1)then if(_d<ad)then ad=ad-1 end end end end;if(d_a==keys.enter)then if(c_a.parent~=nil)then end end
if(
d_a==keys.right)then
local bba=tostring(ac.getValue()):len()_d=_d+1;if(_d>bba)then _d=bba+1 end;if(_d<1)then _d=1 end;if
(_d<ad)or(_d>=_aa+ad)then ad=_d-_aa+1 end;if(ad<1)then ad=1 end end
if(d_a==keys.left)then _d=_d-1;if(_d>=1)then
if(_d<ad)or(_d>=_aa+ad)then ad=_d end end;if(_d<1)then _d=1 end;if(ad<1)then ad=1 end end;local baa,caa=c_a:getAnchorPosition()
local daa=tostring(ac.getValue())
local _ba=(_d<=daa:len()and _d-1 or daa:len())- (ad-1)local aba=c_a:getX()
if(_ba>aba+_aa-1)then _ba=aba+_aa-1 end;if(c_a.parent~=nil)then
c_a.parent:setCursor(true,baa+_ba,caa+
math.max(math.ceil(aaa/2 -1,1)),c_a.fgColor)end
c_a:updateDraw()a_a=false;return true end;return false end,charHandler=function(c_a,d_a)
if
(ac.charHandler(c_a,d_a))then a_a=true;local _aa,aaa=c_a:getSize()local baa=ac.getValue()
if(
baa:len()<dc or dc<=0)then
if(cc=="number")then local cba=baa;if
(d_a==".")or(tonumber(d_a)~=nil)then
c_a:setValue(baa:sub(1,_d-1)..d_a..baa:sub(_d,baa:len()))_d=_d+1 end;if(
tonumber(ac.getValue())==nil)then c_a:setValue(cba)end else
c_a:setValue(baa:sub(1,
_d-1)..d_a..baa:sub(_d,baa:len()))_d=_d+1 end;if(_d>=_aa+ad)then ad=ad+1 end end;local caa,daa=c_a:getAnchorPosition()
local _ba=tostring(ac.getValue())
local aba=(_d<=_ba:len()and _d-1 or _ba:len())- (ad-1)local bba=c_a:getX()
if(aba>bba+_aa-1)then aba=bba+_aa-1 end;if(c_a.parent~=nil)then
c_a.parent:setCursor(true,caa+aba,daa+
math.max(math.ceil(aaa/2 -1,1)),c_a.fgColor)end;a_a=false
c_a:updateDraw()return true end;return false end,mouseHandler=function(c_a,d_a,_aa,aaa)
if
(ac.mouseHandler(c_a,d_a,_aa,aaa))then local baa,caa=c_a:getAnchorPosition()
local daa,_ba=c_a:getAbsolutePosition(baa,caa)local aba,bba=c_a:getSize()_d=_aa-daa+ad;local cba=ac.getValue()if(_d>
cba:len())then _d=cba:len()+1 end;if(_d<ad)then ad=_d-1
if(ad<1)then ad=1 end end
c_a.parent:setCursor(true,baa+_d-ad,caa+
math.max(math.ceil(bba/2 -1,1)),c_a.fgColor)return true end end,dragHandler=function(c_a,d_a,_aa,aaa,baa,caa)
if
(c_a:isFocused())then if(c_a:isCoordsInObject(_aa,aaa))then
if(ac.dragHandler(c_a,d_a,_aa,aaa,baa,caa))then return true end end
c_a.parent:removeFocusedObject()end end,eventHandler=function(c_a,d_a,_aa,aaa,baa,caa)
if
(ac.eventHandler(c_a,d_a,_aa,aaa,baa,caa))then
if(d_a=="paste")then
if(c_a:isFocused())then local daa=ac.getValue()
local _ba,aba=c_a:getSize()a_a=true
if(cc=="number")then local bca=daa
if(_aa==".")or(tonumber(_aa)~=nil)then
c_a:setValue(daa:sub(1,
_d-1).._aa..daa:sub(_d,daa:len()))_d=_d+_aa:len()end
if(tonumber(ac.getValue())==nil)then c_a:setValue(bca)end else
c_a:setValue(daa:sub(1,_d-1).._aa..daa:sub(_d,daa:len()))_d=_d+_aa:len()end;if(_d>=_ba+ad)then ad=(_d+1)-_ba end
local bba,cba=c_a:getAnchorPosition()local dba=tostring(ac.getValue())
local _ca=(
_d<=dba:len()and _d-1 or dba:len())- (ad-1)local aca=c_a:getX()
if(_ca>aca+_ba-1)then _ca=aca+_ba-1 end;if(c_a.parent~=nil)then
c_a.parent:setCursor(true,bba+_ca,cba+
math.max(math.ceil(aba/2 -1,1)),c_a.fgColor)end
c_a:updateDraw()a_a=false end end end end,draw=function(c_a)
if
(ac.draw(c_a))then
if(c_a.parent~=nil)then local d_a,_aa=c_a:getAnchorPosition()
local aaa,baa=c_a:getSize()local caa=bb.getTextVerticalAlign(baa,"center")if
(c_a.bgColor~=false)then
c_a.parent:drawBackgroundBox(d_a,_aa,aaa,baa,c_a.bgColor)end
for n=1,baa do
if(n==caa)then
local daa=tostring(ac.getValue())local _ba=c_a.bgColor;local aba=c_a.fgColor;local bba;if(daa:len()<=0)then bba=__a
_ba=cd or _ba;aba=dd or aba end;bba=__a
if(daa~="")then bba=daa end;bba=bba:sub(ad,aaa+ad-1)local cba=aaa-bba:len()if(cba<0)then
cba=0 end;if(cc=="password")and(daa~="")then
bba=string.rep("*",bba:len())end
bba=bba..string.rep(c_a.bgSymbol,cba)
c_a.parent:writeText(d_a,_aa+ (n-1),bba,_ba,aba)end end;if(c_a:isFocused())then
c_a.parent:setCursor(true,d_a+_d-ad,_aa+
math.floor(c_a:getHeight()/2),c_a.fgColor)end end end end,init=function(c_a)
c_a.bgColor=c_a.parent:getTheme("InputBG")c_a.fgColor=c_a.parent:getTheme("InputText")
if
(c_a.parent~=nil)then c_a.parent:addEvent("mouse_click",c_a)
c_a.parent:addEvent("key",c_a)c_a.parent:addEvent("char",c_a)
c_a.parent:addEvent("other_event",c_a)c_a.parent:addEvent("mouse_drag",c_a)end end}return setmetatable(b_a,ac)end end
aa["objects"]["Label"]=function(...)local ab=da("Object")local bb=da("utils")
local cb=bb.getValueFromXML;local db=bb.createText;local _c=da("tHex")local ac=da("bigfont")
return
function(bc)local cc=ab(bc)
local dc="Label"cc:setZIndex(3)local _d=true;cc:setValue("Label")cc.width=5
local ad="left"local bd="top"local cd=0;local dd,__a=false,false
local a_a={getType=function(b_a)return dc end,setText=function(b_a,c_a)c_a=tostring(c_a)
cc:setValue(c_a)if(_d)then b_a.width=c_a:len()end;b_a:updateDraw()return b_a end,setBackground=function(b_a,c_a)
cc.setBackground(b_a,c_a)__a=true;b_a:updateDraw()return b_a end,setForeground=function(b_a,c_a)
cc.setForeground(b_a,c_a)dd=true;b_a:updateDraw()return b_a end,setTextAlign=function(b_a,c_a,d_a)ad=
c_a or ad;bd=d_a or bd;b_a:updateDraw()return b_a end,setFontSize=function(b_a,c_a)if(
c_a>0)and(c_a<=4)then cd=c_a-1 or 0 end
b_a:updateDraw()return b_a end,getFontSize=function(b_a)return cd+1 end,setValuesByXMLData=function(b_a,c_a)
cc.setValuesByXMLData(b_a,c_a)
if(cb("text",c_a)~=nil)then b_a:setText(cb("text",c_a))end
if(cb("verticalAlign",c_a)~=nil)then bd=cb("verticalAlign",c_a)end;if(cb("horizontalAlign",c_a)~=nil)then
ad=cb("horizontalAlign",c_a)end;if(cb("font",c_a)~=nil)then
b_a:setFontSize(cb("font",c_a))end;return b_a end,setSize=function(b_a,c_a,d_a,_aa)
cc.setSize(b_a,c_a,d_a,_aa)_d=false;b_a:updateDraw()return b_a end,draw=function(b_a)
if
(cc.draw(b_a))then
if(b_a.parent~=nil)then local c_a,d_a=b_a:getAnchorPosition()
local _aa,aaa=b_a:getSize()local baa=bb.getTextVerticalAlign(aaa,bd)
if(cd==0)then
if not(_d)then
local caa=db(b_a:getValue(),b_a:getWidth())for daa,_ba in pairs(caa)do
b_a.parent:writeText(c_a,d_a+daa-1,_ba,b_a.bgColor,b_a.fgColor)end else
b_a.parent:writeText(c_a,d_a,b_a:getValue(),b_a.bgColor,b_a.fgColor)end else
local caa=ac(cd,b_a:getValue(),b_a.fgColor,b_a.bgColor or colors.lightGray)
if(_d)then b_a:setSize(#caa[1][1],#caa[1]-1)end;local daa,_ba=b_a.parent:getSize()
local aba,bba=#caa[1][1],#caa[1]
c_a=c_a or math.floor((daa-aba)/2)+1
d_a=d_a or math.floor((_ba-bba)/2)+1
for i=1,bba do
b_a.parent:setFG(c_a,d_a+i-2,caa[2][i])b_a.parent:setBG(c_a,d_a+i-2,caa[3][i])b_a.parent:setText(c_a,
d_a+i-2,caa[1][i])end end end end end,init=function(b_a)
if
(cc.init(b_a))then b_a.bgColor=b_a.parent:getTheme("LabelBG")
b_a.fgColor=b_a.parent:getTheme("LabelText")
if
(b_a.parent.bgColor==colors.black)and(b_a.fgColor==colors.black)then b_a.fgColor=colors.lightGray end end end}return setmetatable(a_a,cc)end end
aa["objects"]["Progressbar"]=function(...)local ab=da("Object")
local bb=da("utils").getValueFromXML
return
function(cb)local db=ab(cb)local _c="Progressbar"local ac=0;db:setZIndex(5)
db:setValue(false)db.width=25;db.height=1;local bc;local cc=""local dc=colors.white;local _d=""local ad=0
local bd={init=function(cd)
cd.bgColor=cd.parent:getTheme("ProgressbarBG")cd.fgColor=cd.parent:getTheme("ProgressbarText")
bc=cd.parent:getTheme("ProgressbarActiveBG")end,getType=function(cd)return
_c end,setValuesByXMLData=function(cd,dd)db.setValuesByXMLData(cd,dd)if(bb("direction",dd)~=
nil)then ad=bb("direction",dd)end
if(
bb("progressColor",dd)~=nil)then bc=colors[bb("progressColor",dd)]end
if(bb("progressSymbol",dd)~=nil)then cc=bb("progressSymbol",dd)end;if(bb("backgroundSymbol",dd)~=nil)then
_d=bb("backgroundSymbol",dd)end
if
(bb("progressSymbolColor",dd)~=nil)then dc=colors[bb("progressSymbolColor",dd)]end;if(bb("onDone",dd)~=nil)then
cd:generateXMLEventFunction(cd.onProgressDone,bb("onDone",dd))end;return cd end,setDirection=function(cd,dd)
ad=dd;cd:updateDraw()return cd end,setProgressBar=function(cd,dd,__a,a_a)bc=dd or bc
cc=__a or cc;dc=a_a or dc;cd:updateDraw()return cd end,setBackgroundSymbol=function(cd,dd)
_d=dd:sub(1,1)cd:updateDraw()return cd end,setProgress=function(cd,dd)if
(dd>=0)and(dd<=100)and(ac~=dd)then ac=dd;cd:setValue(ac)if(ac==100)then
cd:progressDoneHandler()end end
cd:updateDraw()return cd end,getProgress=function(cd)return
ac end,onProgressDone=function(cd,dd)cd:registerEvent("progress_done",dd)
return cd end,progressDoneHandler=function(cd)
cd:sendEvent("progress_done",cd)end,draw=function(cd)
if(db.draw(cd))then
if(cd.parent~=nil)then
local dd,__a=cd:getAnchorPosition()local a_a,b_a=cd:getSize()if(cd.bgColor~=false)then
cd.parent:drawBackgroundBox(dd,__a,a_a,b_a,cd.bgColor)end;if(_d~="")then
cd.parent:drawTextBox(dd,__a,a_a,b_a,_d)end;if(cd.fgColor~=false)then
cd.parent:drawForegroundBox(dd,__a,a_a,b_a,cd.fgColor)end
if(ad==1)then cd.parent:drawBackgroundBox(dd,__a,a_a,
b_a/100 *ac,bc)cd.parent:drawForegroundBox(dd,__a,a_a,
b_a/100 *ac,dc)cd.parent:drawTextBox(dd,__a,a_a,
b_a/100 *ac,cc)elseif(ad==2)then
cd.parent:drawBackgroundBox(dd,
__a+math.ceil(b_a-b_a/100 *ac),a_a,b_a/100 *ac,bc)
cd.parent:drawForegroundBox(dd,__a+math.ceil(b_a-b_a/100 *ac),a_a,
b_a/100 *ac,dc)
cd.parent:drawTextBox(dd,__a+math.ceil(b_a-b_a/100 *ac),a_a,
b_a/100 *ac,cc)elseif(ad==3)then
cd.parent:drawBackgroundBox(dd+math.ceil(a_a-a_a/100 *ac),__a,
a_a/100 *ac,b_a,bc)
cd.parent:drawForegroundBox(dd+math.ceil(a_a-a_a/100 *ac),__a,
a_a/100 *ac,b_a,dc)
cd.parent:drawTextBox(dd+math.ceil(a_a-a_a/100 *ac),__a,
a_a/100 *ac,b_a,cc)else
cd.parent:drawBackgroundBox(dd,__a,a_a/100 *ac,b_a,bc)
cd.parent:drawForegroundBox(dd,__a,a_a/100 *ac,b_a,dc)
cd.parent:drawTextBox(dd,__a,a_a/100 *ac,b_a,cc)end end end end}return setmetatable(bd,db)end end
aa["objects"]["Thread"]=function(...)local ab=da("utils").getValueFromXML
return
function(bb)local cb
local db="Thread"local _c;local ac;local bc=false
local cc=function(dc,_d)
if(_d:sub(1,1)=="#")then
local ad=dc:getBaseFrame():getDeepObject(_d:sub(2,_d:len()))
if(ad~=nil)and(ad.internalObjetCall~=nil)then return(function()
ad:internalObjetCall()end)end else return dc:getBaseFrame():getVariable(_d)end;return dc end
cb={name=bb,getType=function(dc)return db end,getZIndex=function(dc)return 1 end,getName=function(dc)return dc.name end,getBaseFrame=function(dc)if
(dc.parent~=nil)then return dc.parent:getBaseFrame()end
return dc end,setValuesByXMLData=function(dc,_d)local ad;if(ab("thread",_d)~=nil)then
ad=cc(dc,ab("thread",_d))end
if(ab("start",_d)~=nil)then if
(ab("start",_d))and(ad~=nil)then dc:start(ad)end end;return dc end,start=function(dc,_d)
if(
_d==nil)then error("Function provided to thread is nil")end;_c=_d;ac=coroutine.create(_c)bc=true
local ad,bd=coroutine.resume(ac)if not(ad)then if(bd~="Terminated")then
error("Thread Error Occurred - "..bd)end end
dc.parent:addEvent("other_event",dc)return dc end,getStatus=function(dc,_d)if(
ac~=nil)then return coroutine.status(ac)end;return nil end,stop=function(dc,_d)
bc=false;dc.parent:removeEvent("other_event",dc)return dc end,eventHandler=function(dc,_d,ad,bd,cd)
if
(bc)then
if(coroutine.status(ac)~="dead")then
local dd,__a=coroutine.resume(ac,_d,ad,bd,cd)
if not(dd)then if(__a~="Terminated")then
error("Thread Error Occurred - "..__a)end end else bc=false end end end}cb.__index=cb;return cb end end
aa["objects"]["Textfield"]=function(...)local ab=da("Object")local bb=da("tHex")
local cb=da("basaltLogs")local db=da("utils").getValueFromXML;local _c=string.rep
return
function(ac)local bc=ab(ac)
local cc="Textfield"local dc,_d,ad,bd=1,1,1,1;local cd={""}local dd={""}local __a={""}local a_a={}local b_a={}bc.width=30
bc.height=12;bc:setZIndex(5)
local function c_a(baa,caa)local daa={}
if(baa:len()>0)then
for _ba in string.gmatch(baa,caa)do
local aba,bba=string.find(baa,_ba)
if(aba~=nil)and(bba~=nil)then table.insert(daa,aba)
table.insert(daa,bba)local cba=string.sub(baa,1,(aba-1))
local dba=string.sub(baa,bba+1,baa:len())
baa=cba.. (":"):rep(_ba:len())..dba end end end;return daa end
local function d_a(baa,caa)caa=caa or bd
local daa=bb[baa.fgColor]:rep(__a[caa]:len())
local _ba=bb[baa.bgColor]:rep(dd[caa]:len())
for aba,bba in pairs(b_a)do local cba=c_a(cd[caa],bba[1])
if(#cba>0)then
for x=1,#cba/2 do local dba=x*2 -1;if(
bba[2]~=nil)then
daa=daa:sub(1,cba[dba]-1)..bb[bba[2]]:rep(cba[dba+1]-
(cba[dba]-1))..
daa:sub(cba[dba+1]+1,daa:len())end;if
(bba[3]~=nil)then
_ba=_ba:sub(1,cba[dba]-1)..

bb[bba[3]]:rep(cba[dba+1]- (cba[dba]-1)).._ba:sub(cba[dba+1]+1,_ba:len())end end end end
for aba,bba in pairs(a_a)do
for cba,dba in pairs(bba)do local _ca=c_a(cd[caa],dba)
if(#_ca>0)then for x=1,#_ca/2 do
local aca=x*2 -1
daa=daa:sub(1,_ca[aca]-1)..

bb[aba]:rep(_ca[aca+1]- (_ca[aca]-1))..daa:sub(_ca[aca+1]+1,daa:len())end end end end;__a[caa]=daa;dd[caa]=_ba;baa:updateDraw()end;local function _aa(baa)for n=1,#cd do d_a(baa,n)end end
local aaa={getType=function(baa)return cc end,setBackground=function(baa,caa)
bc.setBackground(baa,caa)_aa(baa)return baa end,setForeground=function(baa,caa)
bc.setForeground(baa,caa)_aa(baa)return baa end,setValuesByXMLData=function(baa,caa)
bc.setValuesByXMLData(baa,caa)
if(caa["lines"]~=nil)then local daa=caa["lines"]["line"]if
(daa.properties~=nil)then daa={daa}end;for _ba,aba in pairs(daa)do
baa:addLine(aba:value())end end
if(caa["keywords"]~=nil)then
for daa,_ba in pairs(caa["keywords"])do
if(colors[daa]~=nil)then
local aba=_ba;if(aba.properties~=nil)then aba={aba}end;local bba={}
for cba,dba in pairs(aba)do
local _ca=dba["keyword"]if(dba["keyword"].properties~=nil)then
_ca={dba["keyword"]}end;for aca,bca in pairs(_ca)do
table.insert(bba,bca:value())end end;baa:addKeywords(colors[daa],bba)end end end
if(caa["rules"]~=nil)then
if(caa["rules"]["rule"]~=nil)then
local daa=caa["rules"]["rule"]if(caa["rules"]["rule"].properties~=nil)then
daa={caa["rules"]["rule"]}end
for _ba,aba in pairs(daa)do if(db("pattern",aba)~=nil)then
baa:addRule(db("pattern",aba),colors[db("fg",aba)],colors[db("bg",aba)])end end end end end,getLines=function(baa)return
cd end,getLine=function(baa,caa)return cd[caa]end,editLine=function(baa,caa,daa)
cd[caa]=daa or cd[caa]baa:updateDraw()return baa end,clear=function(baa)
cd={""}dd={""}__a={""}dc,_d,ad,bd=1,1,1,1;baa:updateDraw()return baa end,addLine=function(baa,caa,daa)
if(
caa~=nil)then if(#cd==1)and(cd[1]=="")then cd[1]=caa
dd[1]=bb[baa.bgColor]:rep(caa:len())__a[1]=bb[baa.fgColor]:rep(caa:len())
return baa end
if(daa~=nil)then
table.insert(cd,daa,caa)
table.insert(dd,daa,bb[baa.bgColor]:rep(caa:len()))
table.insert(__a,bb[baa.fgColor]:rep(caa:len()))else table.insert(cd,caa)
table.insert(dd,bb[baa.bgColor]:rep(caa:len()))
table.insert(__a,bb[baa.fgColor]:rep(caa:len()))end end;baa:updateDraw()return baa end,addKeywords=function(baa,caa,daa)if(
a_a[caa]==nil)then a_a[caa]={}end;for _ba,aba in pairs(daa)do
table.insert(a_a[caa],aba)end;baa:updateDraw()return baa end,addRule=function(baa,caa,daa,_ba)
table.insert(b_a,{caa,daa,_ba})baa:updateDraw()return baa end,editRule=function(baa,caa,daa,_ba)for aba,bba in
pairs(b_a)do
if(bba[1]==caa)then b_a[aba][2]=daa;b_a[aba][3]=_ba end end;baa:updateDraw()return baa end,removeRule=function(baa,caa)
for daa,_ba in
pairs(b_a)do if(_ba[1]==caa)then table.remove(b_a,daa)end end;baa:updateDraw()return baa end,setKeywords=function(baa,caa,daa)
a_a[caa]=daa;baa:updateDraw()return baa end,removeLine=function(baa,caa)table.remove(cd,caa or#
cd)
if(#cd<=0)then table.insert(cd,"")end;baa:updateDraw()return baa end,getTextCursor=function(baa)return
ad,bd end,getFocusHandler=function(baa)bc.getFocusHandler(baa)
if(baa.parent~=nil)then
local caa,daa=baa:getAnchorPosition()if(baa.parent~=nil)then
baa.parent:setCursor(true,caa+ad-_d,daa+bd-dc,baa.fgColor)end end end,loseFocusHandler=function(baa)
bc.loseFocusHandler(baa)
if(baa.parent~=nil)then baa.parent:setCursor(false)end end,keyHandler=function(baa,caa)
if
(bc.keyHandler(baa,event,caa))then local daa,_ba=baa:getAnchorPosition()local aba,bba=baa:getSize()
if(caa==
keys.backspace)then
if(cd[bd]=="")then
if(bd>1)then table.remove(cd,bd)
table.remove(__a,bd)table.remove(dd,bd)ad=cd[bd-1]:len()+1;_d=
ad-aba+1;if(_d<1)then _d=1 end;bd=bd-1 end elseif(ad<=1)then
if(bd>1)then ad=cd[bd-1]:len()+1;_d=ad-aba+1
if(_d<1)then _d=1 end;cd[bd-1]=cd[bd-1]..cd[bd]
__a[bd-1]=__a[bd-1]..__a[bd]dd[bd-1]=dd[bd-1]..dd[bd]table.remove(cd,bd)
table.remove(__a,bd)table.remove(dd,bd)bd=bd-1 end else
cd[bd]=cd[bd]:sub(1,ad-2)..cd[bd]:sub(ad,cd[bd]:len())__a[bd]=__a[bd]:sub(1,ad-2)..
__a[bd]:sub(ad,__a[bd]:len())
dd[bd]=
dd[bd]:sub(1,ad-2)..dd[bd]:sub(ad,dd[bd]:len())if(ad>1)then ad=ad-1 end
if(_d>1)then if(ad<_d)then _d=_d-1 end end end;if(bd<dc)then dc=dc-1 end;d_a(baa)baa:setValue("")end
if(caa==keys.delete)then
if(ad>cd[bd]:len())then
if(cd[bd+1]~=nil)then cd[bd]=cd[bd]..
cd[bd+1]table.remove(cd,bd+1)
table.remove(dd,bd+1)table.remove(__a,bd+1)end else
cd[bd]=cd[bd]:sub(1,ad-1)..cd[bd]:sub(ad+1,cd[bd]:len())__a[bd]=__a[bd]:sub(1,ad-1)..
__a[bd]:sub(ad+1,__a[bd]:len())
dd[bd]=
dd[bd]:sub(1,ad-1)..dd[bd]:sub(ad+1,dd[bd]:len())end;d_a(baa)end
if(caa==keys.enter)then
table.insert(cd,bd+1,cd[bd]:sub(ad,cd[bd]:len()))
table.insert(__a,bd+1,__a[bd]:sub(ad,__a[bd]:len()))
table.insert(dd,bd+1,dd[bd]:sub(ad,dd[bd]:len()))cd[bd]=cd[bd]:sub(1,ad-1)
__a[bd]=__a[bd]:sub(1,ad-1)dd[bd]=dd[bd]:sub(1,ad-1)bd=bd+1;ad=1;_d=1;if(bd-dc>=bba)then
dc=dc+1 end;baa:setValue("")end
if(caa==keys.up)then
if(bd>1)then bd=bd-1;if(ad>cd[bd]:len()+1)then ad=
cd[bd]:len()+1 end;if(_d>1)then if(ad<_d)then _d=ad-aba+1;if(_d<1)then
_d=1 end end end;if(dc>1)then if(
bd<dc)then dc=dc-1 end end end end
if(caa==keys.down)then
if(bd<#cd)then bd=bd+1;if(ad>cd[bd]:len()+1)then ad=
cd[bd]:len()+1 end;if(_d>1)then if(ad<_d)then _d=ad-aba+1;if(_d<1)then
_d=1 end end end;if(bd>=
dc+bba)then dc=dc+1 end end end
if(caa==keys.right)then ad=ad+1;if(bd<#cd)then if(ad>cd[bd]:len()+1)then ad=1
bd=bd+1 end elseif(ad>cd[bd]:len())then
ad=cd[bd]:len()+1 end;if(ad<1)then ad=1 end;if
(ad<_d)or(ad>=aba+_d)then _d=ad-aba+1 end
if(_d<1)then _d=1 end end
if(caa==keys.left)then ad=ad-1;if(ad>=1)then
if(ad<_d)or(ad>=aba+_d)then _d=ad end end
if(bd>1)then if(ad<1)then bd=bd-1
ad=cd[bd]:len()+1;_d=ad-aba+1 end end;if(ad<1)then ad=1 end;if(_d<1)then _d=1 end end;local cba=
(ad<=cd[bd]:len()and ad-1 or cd[bd]:len())- (_d-1)if(cba>
baa.x+aba-1)then cba=baa.x+aba-1 end;local dba=(
bd-dc<bba and bd-dc or bd-dc-1)if(cba<1)then cba=0 end;baa.parent:setCursor(true,
daa+cba,_ba+dba,baa.fgColor)
baa:updateDraw()return true end end,charHandler=function(baa,caa)
if
(bc.charHandler(baa,caa))then local daa,_ba=baa:getAnchorPosition()local aba,bba=baa:getSize()
cd[bd]=cd[bd]:sub(1,
ad-1)..caa..cd[bd]:sub(ad,cd[bd]:len())
__a[bd]=__a[bd]:sub(1,ad-1)..bb[baa.fgColor]..
__a[bd]:sub(ad,__a[bd]:len())
dd[bd]=dd[bd]:sub(1,ad-1)..bb[baa.bgColor]..
dd[bd]:sub(ad,dd[bd]:len())ad=ad+1;if(ad>=aba+_d)then _d=_d+1 end;d_a(baa)
baa:setValue("")local cba=
(ad<=cd[bd]:len()and ad-1 or cd[bd]:len())- (_d-1)if(cba>
baa.x+aba-1)then cba=baa.x+aba-1 end;local dba=(
bd-dc<bba and bd-dc or bd-dc-1)if(cba<1)then cba=0 end;baa.parent:setCursor(true,
daa+cba,_ba+dba,baa.fgColor)
baa:updateDraw()return true end end,dragHandler=function(baa,caa,daa,_ba)
if
(bc.dragHandler(baa,caa,daa,_ba))then
local aba,bba=baa:getAbsolutePosition(baa:getAnchorPosition())local cba,dba=baa:getAnchorPosition()local _ca,aca=baa:getSize()
if(cd[
_ba-bba+dc]~=nil)then
if
(cba+_ca>cba+daa- (aba+1)+_d)and(cba<cba+daa-aba+_d)then
ad=daa-aba+_d;bd=_ba-bba+dc;if(ad>cd[bd]:len())then
ad=cd[bd]:len()+1 end
if(ad<_d)then _d=ad-1;if(_d<1)then _d=1 end end;if(baa.parent~=nil)then
baa.parent:setCursor(true,cba+ad-_d,dba+bd-dc,baa.fgColor)end;baa:updateDraw()end end;return true end end,scrollHandler=function(baa,caa,daa,_ba)
if
(bc.scrollHandler(baa,caa,daa,_ba))then
local aba,bba=baa:getAbsolutePosition(baa:getAnchorPosition())local cba,dba=baa:getAnchorPosition()local _ca,aca=baa:getSize()
dc=dc+caa;if(dc>#cd- (aca-1))then dc=#cd- (aca-1)end
if(dc<1)then dc=1 end
if(baa.parent~=nil)then
if

(aba+ad-_d>=aba and aba+ad-_d<aba+_ca)and(bba+bd-dc>=bba and bba+bd-dc<bba+aca)then
baa.parent:setCursor(true,cba+ad-_d,dba+bd-dc,baa.fgColor)else baa.parent:setCursor(false)end end;baa:updateDraw()return true end end,mouseHandler=function(baa,caa,daa,_ba)
if
(bc.mouseHandler(baa,caa,daa,_ba))then
local aba,bba=baa:getAbsolutePosition(baa:getAnchorPosition())local cba,dba=baa:getAnchorPosition()
if(cd[_ba-bba+dc]~=nil)then ad=
daa-aba+_d;bd=_ba-bba+dc;if(ad>cd[bd]:len())then ad=
cd[bd]:len()+1 end
if(ad<_d)then _d=ad-1;if(_d<1)then _d=1 end end end;if(baa.parent~=nil)then
baa.parent:setCursor(true,cba+ad-_d,dba+bd-dc,baa.fgColor)end;return true end end,eventHandler=function(baa,caa,daa,_ba,aba,bba)
if
(bc.eventHandler(baa,caa,daa,_ba,aba,bba))then
if(caa=="paste")then
if(baa:isFocused())then local cba,dba=baa:getSize()
cd[bd]=
cd[bd]:sub(1,ad-1)..daa..cd[bd]:sub(ad,cd[bd]:len())
__a[bd]=__a[bd]:sub(1,ad-1)..

bb[baa.fgColor]:rep(daa:len())..__a[bd]:sub(ad,__a[bd]:len())
dd[bd]=dd[bd]:sub(1,ad-1)..
bb[baa.bgColor]:rep(daa:len())..dd[bd]:sub(ad,dd[bd]:len())ad=ad+daa:len()if(ad>=cba+_d)then _d=(ad+1)-cba end
local _ca,aca=baa:getAnchorPosition()
baa.parent:setCursor(true,_ca+ad-_d,aca+bd-dc,baa.fgColor)d_a(baa)baa:updateDraw()end end end end,draw=function(baa)
if
(bc.draw(baa))then
if(baa.parent~=nil)then local caa,daa=baa:getAnchorPosition()
local _ba,aba=baa:getSize()
for n=1,aba do local bba=""local cba=""local dba=""if(cd[n+dc-1]~=nil)then bba=cd[n+dc-1]
dba=__a[n+dc-1]cba=dd[n+dc-1]end
bba=bba:sub(_d,_ba+_d-1)cba=cba:sub(_d,_ba+_d-1)
dba=dba:sub(_d,_ba+_d-1)local _ca=_ba-bba:len()if(_ca<0)then _ca=0 end
bba=bba.._c(baa.bgSymbol,_ca)cba=cba.._c(bb[baa.bgColor],_ca)dba=dba..
_c(bb[baa.fgColor],_ca)
baa.parent:setText(caa,daa+n-1,bba)baa.parent:setBG(caa,daa+n-1,cba)baa.parent:setFG(caa,
daa+n-1,dba)end;if(baa:isFocused())then local bba,cba=baa:getAnchorPosition()
baa.parent:setCursor(true,
bba+ad-_d,cba+bd-dc,baa.fgColor)end end end end,init=function(baa)
baa.bgColor=baa.parent:getTheme("TextfieldBG")baa.fgColor=baa.parent:getTheme("TextfieldText")
baa.parent:addEvent("mouse_click",baa)baa.parent:addEvent("mouse_scroll",baa)
baa.parent:addEvent("mouse_drag",baa)baa.parent:addEvent("key",baa)
baa.parent:addEvent("char",baa)baa.parent:addEvent("other_event",baa)end}return setmetatable(aaa,bc)end end
aa["objects"]["Timer"]=function(...)local ab=da("basaltEvent")
local bb=da("utils").getValueFromXML
return
function(cb)local db="Timer"local _c=0;local ac=0;local bc=0;local cc;local dc=ab()local _d=false
local ad=function(cd,dd,__a)
local a_a=function(b_a)
if(b_a:sub(1,1)=="#")then
local c_a=cd:getBaseFrame():getDeepObject(b_a:sub(2,b_a:len()))
if(c_a~=nil)and(c_a.internalObjetCall~=nil)then dd(cd,function()
c_a:internalObjetCall()end)end else
dd(cd,cd:getBaseFrame():getVariable(b_a))end end;if(type(__a)=="string")then a_a(__a)elseif(type(__a)=="table")then
for b_a,c_a in pairs(__a)do a_a(c_a)end end;return cd end
local bd={name=cb,getType=function(cd)return db end,setValuesByXMLData=function(cd,dd)
if(bb("time",dd)~=nil)then _c=bb("time",dd)end;if(bb("repeat",dd)~=nil)then ac=bb("repeat",dd)end
if(
bb("start",dd)~=nil)then if(bb("start",dd))then cd:start()end end;if(bb("onCall",dd)~=nil)then
ad(cd,cd.onCall,bb("onCall",dd))end;return cd end,getBaseFrame=function(cd)
if(
cd.parent~=nil)then return cd.parent:getBaseFrame()end;return cd end,getZIndex=function(cd)return 1 end,getName=function(cd)
return cd.name end,setTime=function(cd,dd,__a)_c=dd or 0;ac=__a or 1;return cd end,start=function(cd)if(_d)then
os.cancelTimer(cc)end;bc=ac;cc=os.startTimer(_c)_d=true
cd.parent:addEvent("other_event",cd)return cd end,isActive=function(cd)return _d end,cancel=function(cd)if(
cc~=nil)then os.cancelTimer(cc)end;_d=false
cd.parent:removeEvent("other_event",cd)return cd end,onCall=function(cd,dd)
dc:registerEvent("timed_event",dd)return cd end,eventHandler=function(cd,dd,__a)
if
dd=="timer"and __a==cc and _d then dc:sendEvent("timed_event",cd)
if(bc>=1)then bc=bc-1;if(bc>=1)then
cc=os.startTimer(_c)end elseif(bc==-1)then cc=os.startTimer(_c)end end end}bd.__index=bd;return bd end end
aa["objects"]["Image"]=function(...)local ab=da("Object")
local bb=da("utils").getValueFromXML;local cb=da("images")local db=table.unpack
return
function(_c)local ac=ab(_c)local bc="Image"
ac:setZIndex(2)local cc;local dc="nfp"
local _d={init=function(ad)ad.bgColor=ad.parent:getTheme("ImageBG")end,getType=function(ad)return
bc end,loadImage=function(ad,bd,cd)cc,_format=cb.loadImage(bd,cd)if(_format~=nil)then
dc=_format end;ad:updateDraw()return ad end,setImage=function(ad,bd,cd)
iamge=bd;dc=cd end,getImageData=function(ad)return cc end,setValuesByXMLData=function(ad,bd)
ac.setValuesByXMLData(ad,bd)
if(bb("path",bd)~=nil)then ad:loadImage(bb("path",bd))end;return ad end,draw=function(ad)
if
(ac.draw(ad))then
if(cc~=nil)then local bd,cd=ad:getAnchorPosition()local dd,__a=ad:getSize()
if
(dc=="nfp")then elseif(dc=="bimg")then
for a_a,b_a in ipairs(cc[1])do local c_a,d_a,_aa=db(b_a)c_a=c_a:sub(1,dd)
d_a=d_a:sub(1,dd)_aa=_aa:sub(1,dd)
ad.parent:blit(bd,cd+a_a-1,c_a,d_a,_aa)if(a_a==__a)then break end end end end end end}return setmetatable(_d,ac)end end
aa["objects"]["Slider"]=function(...)local ab=da("Object")
local bb=da("basaltLogs")local cb=da("utils").getValueFromXML
return
function(db)local _c=ab(db)local ac="Slider"
_c.width=8;_c.height=1;_c:setValue(1)local bc="horizontal"local cc=" "local dc;local _d="\140"
local ad=_c.width;local bd=1;local cd=1
local function dd(a_a,b_a,c_a,d_a)
local _aa,aaa=a_a:getAbsolutePosition(a_a:getAnchorPosition())local baa,caa=a_a:getSize()
if(bc=="horizontal")then
for _index=0,baa do
if
(_aa+_index==c_a)and(aaa<=d_a)and(aaa+caa>d_a)then
bd=math.min(_index+1,baa- (cd-1))a_a:setValue(ad/baa* (bd))a_a:updateDraw()end end end
if(bc=="vertical")then
for _index=0,caa do
if
(aaa+_index==d_a)and(_aa<=c_a)and(_aa+baa>c_a)then bd=math.min(_index+1,caa- (cd-1))
a_a:setValue(ad/caa* (bd))a_a:updateDraw()end end end end
local __a={getType=function(a_a)return ac end,setSymbol=function(a_a,b_a)cc=b_a:sub(1,1)a_a:updateDraw()return a_a end,setValuesByXMLData=function(a_a,b_a)
_c.setValuesByXMLData(a_a,b_a)
if(cb("maxValue",b_a)~=nil)then ad=cb("maxValue",b_a)end;if(cb("backgroundSymbol",b_a)~=nil)then
_d=cb("backgroundSymbol",b_a):sub(1,1)end;if(cb("barType",b_a)~=nil)then
bc=cb("barType",b_a):lower()end;if(cb("symbol",b_a)~=nil)then
cc=cb("symbol",b_a):sub(1,1)end;if(cb("symbolSize",b_a)~=nil)then
a_a:setSymbolSize(cb("symbolSize",b_a))end;if(cb("symbolColor",b_a)~=nil)then
dc=colors[cb("symbolColor",b_a)]end;if(cb("index",b_a)~=nil)then
a_a:setIndex(cb("index",b_a))end end,setIndex=function(a_a,b_a)
bd=b_a;if(bd<1)then bd=1 end;local c_a,d_a=a_a:getSize()
bd=math.min(bd,(
bc=="vertical"and d_a or c_a)- (cd-1))
a_a:setValue(ad/ (bc=="vertical"and d_a or c_a)*bd)a_a:updateDraw()return a_a end,getIndex=function(a_a)return
bd end,setSymbolSize=function(a_a,b_a)cd=tonumber(b_a)or 1
if(bc=="vertical")then
a_a:setValue(bd-1 * (ad/ (h- (cd-
1)))- (ad/ (h- (cd-1))))elseif(bc=="horizontal")then
a_a:setValue(bd-1 * (ad/ (w- (cd-1)))- (ad/
(w- (cd-1))))end;a_a:updateDraw()return a_a end,setMaxValue=function(a_a,b_a)
ad=b_a;return a_a end,setBackgroundSymbol=function(a_a,b_a)_d=string.sub(b_a,1,1)
a_a:updateDraw()return a_a end,setSymbolColor=function(a_a,b_a)dc=b_a;a_a:updateDraw()
return a_a end,setBarType=function(a_a,b_a)bc=b_a:lower()a_a:updateDraw()
return a_a end,mouseHandler=function(a_a,b_a,c_a,d_a)if(_c.mouseHandler(a_a,b_a,c_a,d_a))then
dd(a_a,b_a,c_a,d_a)return true end;return false end,dragHandler=function(a_a,b_a,c_a,d_a)if
(_c.dragHandler(a_a,b_a,c_a,d_a))then dd(a_a,b_a,c_a,d_a)return true end
return false end,scrollHandler=function(a_a,b_a,c_a,d_a)
if
(_c.scrollHandler(a_a,b_a,c_a,d_a))then local _aa,aaa=a_a:getSize()bd=bd+b_a;if(bd<1)then bd=1 end
bd=math.min(bd,(
bc=="vertical"and aaa or _aa)- (cd-1))
a_a:setValue(ad/ (bc=="vertical"and aaa or _aa)*bd)a_a:updateDraw()return true end;return false end,draw=function(a_a)
if
(_c.draw(a_a))then
if(a_a.parent~=nil)then local b_a,c_a=a_a:getAnchorPosition()
local d_a,_aa=a_a:getSize()
if(bc=="horizontal")then
a_a.parent:writeText(b_a,c_a,_d:rep(bd-1),a_a.bgColor,a_a.fgColor)
a_a.parent:writeText(b_a+bd-1,c_a,cc:rep(cd),dc,dc)
a_a.parent:writeText(b_a+bd+cd-1,c_a,_d:rep(d_a- (bd+cd-1)),a_a.bgColor,a_a.fgColor)end
if(bc=="vertical")then
for n=0,_aa-1 do
if(bd==n+1)then
for curIndexOffset=0,math.min(cd-1,_aa)do a_a.parent:writeText(b_a,c_a+n+
curIndexOffset,cc,dc,dc)end else if(n+1 <bd)or(n+1 >bd-1 +cd)then
a_a.parent:writeText(b_a,c_a+n,_d,a_a.bgColor,a_a.fgColor)end end end end end end end,init=function(a_a)
a_a.bgColor=a_a.parent:getTheme("SliderBG")a_a.fgColor=a_a.parent:getTheme("SliderText")
dc=a_a.parent:getTheme("SliderSymbolColor")a_a.parent:addEvent("mouse_click",a_a)
a_a.parent:addEvent("mouse_drag",a_a)a_a.parent:addEvent("mouse_scroll",a_a)end}return setmetatable(__a,_c)end end;aa["libraries"]={}
aa["libraries"]["basaltDraw"]=function(...)
local ab=da("tHex")local bb,cb=string.sub,string.rep
return
function(db)local _c=db or term.current()
local ac;local bc,cc=_c.getSize()local dc={}local _d={}local ad={}local bd={}local cd={}local dd={}local __a;local a_a={}local function b_a()
__a=cb(" ",bc)
for n=0,15 do local daa=2 ^n;local _ba=ab[daa]a_a[daa]=cb(_ba,bc)end end;b_a()
local function c_a()b_a()local daa=__a
local _ba=a_a[colors.white]local aba=a_a[colors.black]
for currentY=1,cc do
dc[currentY]=bb(
dc[currentY]==nil and daa or
dc[currentY]..daa:sub(1,bc-dc[currentY]:len()),1,bc)
ad[currentY]=bb(ad[currentY]==nil and _ba or ad[currentY].._ba:sub(1,bc-
ad[currentY]:len()),1,bc)
_d[currentY]=bb(_d[currentY]==nil and aba or _d[currentY]..aba:sub(1,bc-
_d[currentY]:len()),1,bc)end end;c_a()
local function d_a(daa,_ba,aba)
if(_ba>=1)and(_ba<=cc)then
if
(daa+aba:len()>0)and(daa<=bc)then local bba=dc[_ba]local cba;local dba=daa+#aba-1
if(daa<1)then local _ca=1 -daa+1
local aca=bc-daa+1;aba=bb(aba,_ca,aca)elseif(dba>bc)then local _ca=bc-daa+1;aba=bb(aba,1,_ca)end
if(daa>1)then local _ca=daa-1;cba=bb(bba,1,_ca)..aba else cba=aba end;if dba<bc then cba=cba..bb(bba,dba+1,bc)end
dc[_ba]=cba end end end
local function _aa(daa,_ba,aba)
if(_ba>=1)and(_ba<=cc)then
if(daa+aba:len()>0)and(daa<=bc)then
local bba=_d[_ba]local cba;local dba=daa+#aba-1
if(daa<1)then
aba=bb(aba,1 -daa+1,bc-daa+1)elseif(dba>bc)then aba=bb(aba,1,bc-daa+1)end
if(daa>1)then cba=bb(bba,1,daa-1)..aba else cba=aba end;if dba<bc then cba=cba..bb(bba,dba+1,bc)end
_d[_ba]=cba end end end
local function aaa(daa,_ba,aba)
if(_ba>=1)and(_ba<=cc)then
if(daa+aba:len()>0)and(daa<=bc)then
local bba=ad[_ba]local cba;local dba=daa+#aba-1
if(daa<1)then local _ca=1 -daa+1;local aca=bc-daa+1
aba=bb(aba,_ca,aca)elseif(dba>bc)then local _ca=bc-daa+1;aba=bb(aba,1,_ca)end
if(daa>1)then local _ca=daa-1;cba=bb(bba,1,_ca)..aba else cba=aba end;if dba<bc then cba=cba..bb(bba,dba+1,bc)end
ad[_ba]=cba end end end
local function baa(daa,_ba,aba,bba,cba)
if(#aba==#bba)or(#aba==#cba)then
if(_ba>=1)and(_ba<=cc)then
if(
daa+aba:len()>0)and(daa<=bc)then local dba=dc[_ba]local _ca=ad[_ba]local aca=_d[_ba]
local bca,cca,dca;local _da=daa+#aba-1
if(daa<1)then local ada=1 -daa+1;local bda=bc-daa+1
aba=bb(aba,ada,bda)bba=bb(bba,ada,bda)cba=bb(cba,ada,bda)elseif(_da>bc)then local ada=bc-daa+1
aba=bb(aba,1,ada)bba=bb(bba,1,ada)cba=bb(cba,1,ada)end
if(daa>1)then local ada=daa-1;bca=bb(dba,1,ada)..aba
cca=bb(_ca,1,ada)..bba;dca=bb(aca,1,ada)..cba else bca=aba;cca=bba;dca=cba end
if _da<bc then bca=bca..bb(dba,_da+1,bc)
cca=cca..bb(_ca,_da+1,bc)dca=dca..bb(aca,_da+1,bc)end;dc[_ba]=bca;ad[_ba]=cca;_d[_ba]=dca end end end end
local caa={setSize=function(daa,_ba)bc,cc=daa,_ba;c_a()end,setMirror=function(daa)ac=daa end,setBG=function(daa,_ba,aba)
_aa(daa,_ba,aba)end,setText=function(daa,_ba,aba)d_a(daa,_ba,aba)end,setFG=function(daa,_ba,aba)
aaa(daa,_ba,aba)end,blit=function(daa,_ba,aba,bba,cba)baa(daa,_ba,aba,bba,cba)end,drawBackgroundBox=function(daa,_ba,aba,bba,cba)
for n=1,bba
do _aa(daa,_ba+ (n-1),cb(ab[cba],aba))end end,drawForegroundBox=function(daa,_ba,aba,bba,cba)for n=1,bba do
aaa(daa,_ba+ (n-1),cb(ab[cba],aba))end end,drawTextBox=function(daa,_ba,aba,bba,cba)
for n=1,bba do d_a(daa,
_ba+ (n-1),cb(cba,aba))end end,writeText=function(daa,_ba,aba,bba,cba)
if(aba~=nil)then d_a(daa,_ba,aba)if
(bba~=nil)and(bba~=false)then
_aa(daa,_ba,cb(ab[bba],aba:len()))end;if(cba~=nil)and(cba~=false)then
aaa(daa,_ba,cb(ab[cba],aba:len()))end end end,update=function()
local daa,_ba=_c.getCursorPos()local aba=false
if(_c.getCursorBlink~=nil)then aba=_c.getCursorBlink()end;_c.setCursorBlink(false)if(ac~=nil)then
ac.setCursorBlink(false)end
for n=1,cc do _c.setCursorPos(1,n)
_c.blit(dc[n],ad[n],_d[n])if(ac~=nil)then ac.setCursorPos(1,n)
ac.blit(dc[n],ad[n],_d[n])end end;_c.setBackgroundColor(colors.black)
_c.setCursorBlink(aba)_c.setCursorPos(daa,_ba)
if(ac~=nil)then
ac.setBackgroundColor(colors.black)ac.setCursorBlink(aba)ac.setCursorPos(daa,_ba)end end,setTerm=function(daa)
_c=daa end}return caa end end
aa["libraries"]["images"]=function(...)local function ab(db)
return paintutils.loadImage(db),"nfp"end
local function bb(db)local _c=fs.open(db,"rb")local ac=load("return "..
_c.readAll())()
_c.close()if(ac~=nil)then return ac,"bimg"end end
local function cb(db,_c)
if(_c==nil)then if(db:find(".bimg"))then return bb(db)elseif(db:find(".bbf"))then return loadBBF(db)else return
ab(db)end end end;return{loadNFP=ab,loadBIMG=bb,loadImage=cb}end
aa["libraries"]["layout"]=function(...)
local function ab(cb)local db={}db.___value=nil;db.___name=cb
db.___children={}db.___props={}function db:value()return self.___value end;function db:setValue(_c)
self.___value=_c end;function db:name()return self.___name end;function db:setName(_c)
self.___name=_c end;function db:children()return self.___children end;function db:numChildren()return
#self.___children end
function db:addChild(_c)
if
self[_c:name()]~=nil then if
type(self[_c:name()].name)=="function"then local ac={}table.insert(ac,self[_c:name()])
self[_c:name()]=ac end
table.insert(self[_c:name()],_c)else self[_c:name()]=_c end;table.insert(self.___children,_c)end;function db:properties()return self.___props end;function db:numProperties()
return#self.___props end
function db:addProperty(_c,ac)local bc="@".._c
if self[bc]~=nil then if
type(self[bc])=="string"then local cc={}table.insert(cc,self[bc])
self[bc]=cc end
table.insert(self[bc],ac)else self[bc]=ac end
table.insert(self.___props,{name=_c,value=self[_c]})end;return db end;local bb={}
function bb:ToXmlString(cb)cb=string.gsub(cb,"&","&amp;")
cb=string.gsub(cb,"<","&lt;")cb=string.gsub(cb,">","&gt;")
cb=string.gsub(cb,"\"","&quot;")
cb=string.gsub(cb,"([^%w%&%;%p%\t% ])",function(db)
return string.format("&#x%X;",string.byte(db))end)return cb end
function bb:FromXmlString(cb)
cb=string.gsub(cb,"&#x([%x]+)%;",function(db)
return string.char(tonumber(db,16))end)
cb=string.gsub(cb,"&#([0-9]+)%;",function(db)return string.char(tonumber(db,10))end)cb=string.gsub(cb,"&quot;","\"")
cb=string.gsub(cb,"&apos;","'")cb=string.gsub(cb,"&gt;",">")
cb=string.gsub(cb,"&lt;","<")cb=string.gsub(cb,"&amp;","&")return cb end;function bb:ParseArgs(cb,db)
string.gsub(db,"(%w+)=([\"'])(.-)%2",function(_c,ac,bc)
cb:addProperty(_c,self:FromXmlString(bc))end)end
function bb:ParseXmlText(cb)
local db={}local _c=ab()table.insert(db,_c)local ac,bc,cc,dc,_d;local ad,bd=1,1
while true do
ac,bd,bc,cc,dc,_d=string.find(cb,"<(%/?)([%w_:]+)(.-)(%/?)>",ad)if not ac then break end;local dd=string.sub(cb,ad,ac-1)
if not
string.find(dd,"^%s*$")then
local __a=(_c:value()or"")..self:FromXmlString(dd)db[#db]:setValue(__a)end
if _d=="/"then local __a=ab(cc)self:ParseArgs(__a,dc)
_c:addChild(__a)elseif bc==""then local __a=ab(cc)self:ParseArgs(__a,dc)
table.insert(db,__a)_c=__a else local __a=table.remove(db)_c=db[#db]
if#db<1 then error("XmlParser: nothing to close with "..
cc)end;if __a:name()~=cc then
error("XmlParser: trying to close "..__a.name.." with "..cc)end;_c:addChild(__a)end;ad=bd+1 end;local cd=string.sub(cb,ad)if#db>1 then
error("XmlParser: unclosed "..db[#db]:name())end;return _c end
function bb:loadFile(cb,db)if not db then db=system.ResourceDirectory end
local _c=system.pathForFile(cb,db)local ac,bc=io.open(_c,"r")
if ac and not bc then local cc=ac:read("*a")
io.close(ac)return self:ParseXmlText(cc),nil else print(bc)return nil end end;return bb end
aa["libraries"]["process"]=function(...)local ab={}local bb={}local cb=0
local db=dofile("rom/modules/main/cc/require.lua").make
function bb:new(_c,ac,bc,...)local cc={...}
local dc=setmetatable({path=_c},{__index=self})dc.window=ac;ac.current=term.current;ac.redirect=term.redirect
dc.processId=cb
if(type(_c)=="string")then
dc.coroutine=coroutine.create(function()
local _d=shell.resolveProgram(_c)local ad=setmetatable(bc,{__index=_ENV})ad.shell=shell
ad.basaltProgram=true;ad.arg={[0]=_c,table.unpack(cc)}
ad.require,ad.package=db(ad,fs.getDir(_d))
if(fs.exists(_d))then local bd=fs.open(_d,"r")local cd=bd.readAll()
bd.close()local dd=load(cd,_c,"bt",ad)if(dd~=nil)then return dd()end end end)elseif(type(_c)=="function")then
dc.coroutine=coroutine.create(function()
_c(table.unpack(cc))end)else return end;ab[cb]=dc;cb=cb+1;return dc end
function bb:resume(_c,...)local ac=term.current()term.redirect(self.window)
if(
self.filter~=nil)then if(_c~=self.filter)then return end;self.filter=nil end;local bc,cc=coroutine.resume(self.coroutine,_c,...)if bc then
self.filter=cc else printError(cc)end;term.redirect(ac)
return bc,cc end
function bb:isDead()
if(self.coroutine~=nil)then
if
(coroutine.status(self.coroutine)=="dead")then table.remove(ab,self.processId)return true end else return true end;return false end
function bb:getStatus()if(self.coroutine~=nil)then
return coroutine.status(self.coroutine)end;return nil end
function bb:start()coroutine.resume(self.coroutine)end;return bb end
aa["libraries"]["basaltEvent"]=function(...)
return
function()local ab={}local bb={}
local cb={registerEvent=function(db,_c,ac)if(ab[_c]==nil)then ab[_c]={}
bb[_c]=1 end;ab[_c][bb[_c]]=ac;bb[_c]=bb[_c]+1;return
bb[_c]-1 end,removeEvent=function(db,_c,ac)ab[_c][ac[_c]]=
nil end,sendEvent=function(db,_c,...)local ac
if(ab[_c]~=nil)then for bc,cc in pairs(ab[_c])do
local dc=cc(...)if(dc==false)then ac=dc end end end;return ac end}cb.__index=cb;return cb end end
aa["libraries"]["utils"]=function(...)
local ab=function(bb,cb)if cb==nil then cb="%s"end;local db={}
for _c in string.gmatch(bb,"([^"..
cb.."]+)")do table.insert(db,_c)end;return db end
return
{getTextHorizontalAlign=function(bb,cb,db,_c)bb=string.sub(bb,1,cb)local ac=cb-string.len(bb)
if
(db=="right")then bb=string.rep(_c or" ",ac)..bb elseif(db=="center")then
bb=string.rep(
_c or" ",math.floor(ac/2))..bb..
string.rep(_c or" ",math.floor(ac/2))
bb=bb.. (string.len(bb)<cb and(_c or" ")or"")else bb=bb..string.rep(_c or" ",ac)end;return bb end,getTextVerticalAlign=function(bb,cb)
local db=0
if(cb=="center")then db=math.ceil(bb/2)if(db<1)then db=1 end end;if(cb=="bottom")then db=bb end;if(db<1)then db=1 end;return db end,rpairs=function(bb)return function(cb,db)db=
db-1;if db~=0 then return db,cb[db]end end,bb,
#bb+1 end,tableCount=function(bb)
local cb=0;if(bb~=nil)then for db,_c in pairs(bb)do cb=cb+1 end end;return cb end,splitString=ab,createText=function(bb,cb)
local db=ab(bb,"\n")local _c={}
for ac,bc in pairs(db)do local cc=""local dc=ab(bc," ")
for _d,ad in pairs(dc)do
if(#cc+#ad<=cb)then cc=
cc==""and ad or cc.." "..ad;if(_d==#dc)then
table.insert(_c,cc)end else table.insert(_c,cc)cc=ad:sub(1,cb)if
(_d==#dc)then table.insert(_c,cc)end end end end;return _c end,getValueFromXML=function(bb,cb)
local db;if(type(cb)~="table")then return end;if(cb[bb]~=nil)then
if
(type(cb[bb])=="table")then if(cb[bb].value~=nil)then db=cb[bb]:value()end end end;if(db==nil)then
db=cb["@"..bb]end;if(db=="true")then db=true elseif(db=="false")then db=false elseif(tonumber(db)~=nil)then
db=tonumber(db)end;return db end,numberFromString=function(bb)return load(
"return "..bb)()end,uuid=function()
local bb=math.random
local function cb()local db='xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'return
string.gsub(db,'[xy]',function(_c)local ac=
(_c=='x')and bb(0,0xf)or bb(8,0xb)
return string.format('%x',ac)end)end;return cb()end}end
aa["libraries"]["tHex"]=function(...)
return
{[colors.white]="0",[colors.orange]="1",[colors.magenta]="2",[colors.lightBlue]="3",[colors.yellow]="4",[colors.lime]="5",[colors.pink]="6",[colors.gray]="7",[colors.lightGray]="8",[colors.cyan]="9",[colors.purple]="a",[colors.blue]="b",[colors.brown]="c",[colors.green]="d",[colors.red]="e",[colors.black]="f"}end
aa["libraries"]["basaltLogs"]=function(...)local ab=""local bb="basaltLog.txt"local cb="Debug"
local db={__call=function(_c,ac,bc)if
(ac==nil)then return end
local cc=ab~=""and ab.."/"..bb or bb
local dc=fs.open(cc,fs.exists(cc)and"a"or"w")
dc.writeLine("[Basalt][".. (bc and bc or cb).."]: "..tostring(ac))dc.close()end}return setmetatable({},db)end
aa["libraries"]["geometricPoints"]=function(...)
local function ab(_c,ac,bc,cc)local dc={}if _c==bc and ac==cc then
return{x=_c,y=bc}end;local _d=math.min(_c,bc)local ad,bd,cd;if _d==_c then
bd,ad,cd=ac,bc,cc else bd,ad,cd=cc,_c,ac end;local dd,__a=ad-_d,cd-bd
if dd>
math.abs(__a)then local a_a=bd;local b_a=__a/dd;for x=_d,ad do
table.insert(dc,{x=x,y=math.floor(a_a+0.5)})a_a=a_a+b_a end else local a_a,b_a=_d,dd/__a
if cd>=bd then for y=bd,cd
do
table.insert(dc,{x=math.floor(a_a+0.5),y=y})a_a=a_a+b_a end else for y=bd,cd,-1 do
table.insert(dc,{x=math.floor(a_a+0.5),y=y})a_a=a_a-b_a end end end;return dc end
local function bb(_c,ac,bc)local cc={}for x=-bc,bc+1 do
local dc=math.floor(math.sqrt(bc*bc-x*x))
for y=-dc,dc+1 do table.insert(cc,{x=_c+x,y=ac+y})end end;return cc end
local function cb(_c,ac,bc,cc,dc)local _d,ad=math.ceil(math.floor(bc-0.5)/2),math.ceil(
math.floor(cc-0.5)/2)local bd,cd=0,ad
local dd=( (
ad*ad)- (_d*_d*ad)+ (0.25 *_d*_d))local __a=2 *ad^2 *bd;local a_a=2 *_d^2 *cd;local b_a={}
while __a<a_a do table.insert(b_a,{x=bd+_c,y=
cd+ac})
table.insert(b_a,{x=-bd+_c,y=cd+ac})table.insert(b_a,{x=bd+_c,y=-cd+ac})table.insert(b_a,{x=
-bd+_c,y=-cd+ac})
if dc then for y=-cd+ac+1,cd+
ac-1 do table.insert(b_a,{x=bd+_c,y=y})
table.insert(b_a,{x=-bd+_c,y=y})end end;if dd<0 then bd=bd+1;__a=__a+2 *ad^2;dd=dd+__a+ad^2 else bd,cd=bd+1,cd-1;__a=
__a+2 *ad^2;a_a=a_a-2 *_d^2
dd=dd+__a-a_a+ad^2 end end
local c_a=( ( (ad*ad)* ( (bd+0.5)* (bd+0.5)))+
( (_d*_d)* ( (cd-1)* (cd-1)))- (_d*_d*ad*ad))
while cd>=0 do table.insert(b_a,{x=bd+_c,y=cd+ac})table.insert(b_a,{x=
-bd+_c,y=cd+ac})table.insert(b_a,{x=bd+_c,y=
-cd+ac})
table.insert(b_a,{x=-bd+_c,y=-cd+ac})if dc then
for y=-cd+ac,cd+ac do table.insert(b_a,{x=bd+_c,y=y})table.insert(b_a,{x=-
bd+_c,y=y})end end
if c_a>0 then cd=cd-1
a_a=a_a-2 *_d^2;c_a=c_a+_d^2 -a_a else cd=cd-1;bd=bd+1;a_a=a_a-2 *_d^2;__a=__a+
2 *ad^2;c_a=c_a+__a-a_a+_d^2 end end;return b_a end;local function db(_c,ac,bc,cc)return cb(_c,ac,bc,bc,cc)end
return
{circle=function(_c,ac,bc,cc)
return db(_c,ac,bc,cc)end,rectangle=function(_c,ac,bc,cc,dc)local _d={}
if(dc)then for y=ac,cc do for x=_c,bc do
table.insert(_d,{x=x,y=y})end end else for y=ac,cc do
for x=_c,bc do if
(x==_c)or(x==bc)or(y==ac)or(y==cc)then
table.insert(_d,{x=x,y=y})end end end end;return _d end,triangle=function(_c,ac,bc,cc,dc,_d,ad)
local
function bd(__a,a_a,b_a,c_a,d_a,_aa,aaa)local baa=(_aa-a_a)/ (aaa-b_a)
local caa=(_aa-c_a)/ (aaa-d_a)local daa=math.ceil(b_a-0.5)
local _ba=math.ceil(aaa-0.5)-1
for y=daa,_ba do local aba=baa* (y+0.5 -b_a)+a_a;local bba=caa* (y+0.5 -d_a)+
c_a;local cba=math.ceil(aba-0.5)
local dba=math.ceil(bba-0.5)for x=cba,dba do table.insert(__a,{x=x,y=y})end end end
local function cd(__a,a_a,b_a,c_a,d_a,_aa,aaa)local baa=(c_a-a_a)/ (d_a-b_a)
local caa=(_aa-a_a)/ (aaa-b_a)local daa=math.ceil(b_a-0.5)
local _ba=math.ceil(aaa-0.5)-1
for y=daa,_ba do local aba=baa* (y+0.5 -b_a)+a_a;local bba=caa* (y+0.5 -b_a)+
a_a;local cba=math.ceil(aba-0.5)
local dba=math.ceil(bba-0.5)for x=cba,dba do table.insert(__a,{x=x,y=y})end end end;local dd={}
if(ad)then if cc<ac then _c,ac,bc,cc=bc,cc,_c,ac end;if _d<cc then
bc,cc,dc,_d=dc,_d,bc,cc end;if cc<cc then _c,ac,bc,cc=bc,cc,_c,ac end
if ac==cc then if bc<_c then
_c,ac,bc,cc=bc,cc,_c,ac end;bd(dd,_c,ac,bc,cc,dc,_d)elseif cc==_d then if dc<bc then
dc,_d,bc,cc=bc,cc,dc,_d end;cd(dd,_c,ac,bc,cc,dc,_d)else
local __a=(cc-ac)/ (_d-ac)local a_a=_c+ ( (dc-_c)*__a)
local b_a=ac+ ( (_d-ac)*__a)
if bc<a_a then cd(dd,_c,ac,bc,cc,a_a,b_a)
bd(dd,bc,cc,a_a,b_a,dc,_d)else cd(dd,_c,ac,a_a,b_a,_c,ac)bd(dd,a_a,b_a,bc,cc,dc,_d)end end else dd=ab(_c,ac,bc,cc)for __a,a_a in pairs(ab(bc,cc,dc,_d))do
table.insert(dd,a_a)end;for __a,a_a in pairs(ab(dc,_d,_c,ac))do
table.insert(dd,a_a)end end;return dd end,line=ab,ellipse=function(_c,ac,bc,cc,dc)return
cb(_c,ac,bc,cc,dc)end}end
aa["libraries"]["bigfont"]=function(...)local ab=da("tHex")
local bb={{"\32\32\32\137\156\148\158\159\148\135\135\144\159\139\32\136\157\32\159\139\32\32\143\32\32\143\32\32\32\32\32\32\32\32\147\148\150\131\148\32\32\32\151\140\148\151\140\147","\32\32\32\149\132\149\136\156\149\144\32\133\139\159\129\143\159\133\143\159\133\138\32\133\138\32\133\32\32\32\32\32\32\150\150\129\137\156\129\32\32\32\133\131\129\133\131\132","\32\32\32\130\131\32\130\131\32\32\129\32\32\32\32\130\131\32\130\131\32\32\32\32\143\143\143\32\32\32\32\32\32\130\129\32\130\135\32\32\32\32\131\32\32\131\32\131","\139\144\32\32\143\148\135\130\144\149\32\149\150\151\149\158\140\129\32\32\32\135\130\144\135\130\144\32\149\32\32\139\32\159\148\32\32\32\32\159\32\144\32\148\32\147\131\132","\159\135\129\131\143\149\143\138\144\138\32\133\130\149\149\137\155\149\159\143\144\147\130\132\32\149\32\147\130\132\131\159\129\139\151\129\148\32\32\139\131\135\133\32\144\130\151\32","\32\32\32\32\32\32\130\135\32\130\32\129\32\129\129\131\131\32\130\131\129\140\141\132\32\129\32\32\129\32\32\32\32\32\32\32\131\131\129\32\32\32\32\32\32\32\32\32","\32\32\32\32\149\32\159\154\133\133\133\144\152\141\132\133\151\129\136\153\32\32\154\32\159\134\129\130\137\144\159\32\144\32\148\32\32\32\32\32\32\32\32\32\32\32\151\129","\32\32\32\32\133\32\32\32\32\145\145\132\141\140\132\151\129\144\150\146\129\32\32\32\138\144\32\32\159\133\136\131\132\131\151\129\32\144\32\131\131\129\32\144\32\151\129\32","\32\32\32\32\129\32\32\32\32\130\130\32\32\129\32\129\32\129\130\129\129\32\32\32\32\130\129\130\129\32\32\32\32\32\32\32\32\133\32\32\32\32\32\129\32\129\32\32","\150\156\148\136\149\32\134\131\148\134\131\148\159\134\149\136\140\129\152\131\32\135\131\149\150\131\148\150\131\148\32\148\32\32\148\32\32\152\129\143\143\144\130\155\32\134\131\148","\157\129\149\32\149\32\152\131\144\144\131\148\141\140\149\144\32\149\151\131\148\32\150\32\150\131\148\130\156\133\32\144\32\32\144\32\130\155\32\143\143\144\32\152\129\32\134\32","\130\131\32\131\131\129\131\131\129\130\131\32\32\32\129\130\131\32\130\131\32\32\129\32\130\131\32\130\129\32\32\129\32\32\133\32\32\32\129\32\32\32\130\32\32\32\129\32","\150\140\150\137\140\148\136\140\132\150\131\132\151\131\148\136\147\129\136\147\129\150\156\145\138\143\149\130\151\32\32\32\149\138\152\129\149\32\32\157\152\149\157\144\149\150\131\148","\149\143\142\149\32\149\149\32\149\149\32\144\149\32\149\149\32\32\149\32\32\149\32\149\149\32\149\32\149\32\144\32\149\149\130\148\149\32\32\149\32\149\149\130\149\149\32\149","\130\131\129\129\32\129\131\131\32\130\131\32\131\131\32\131\131\129\129\32\32\130\131\32\129\32\129\130\131\32\130\131\32\129\32\129\131\131\129\129\32\129\129\32\129\130\131\32","\136\140\132\150\131\148\136\140\132\153\140\129\131\151\129\149\32\149\149\32\149\149\32\149\137\152\129\137\152\129\131\156\133\149\131\32\150\32\32\130\148\32\152\137\144\32\32\32","\149\32\32\149\159\133\149\32\149\144\32\149\32\149\32\149\32\149\150\151\129\138\155\149\150\130\148\32\149\32\152\129\32\149\32\32\32\150\32\32\149\32\32\32\32\32\32\32","\129\32\32\130\129\129\129\32\129\130\131\32\32\129\32\130\131\32\32\129\32\129\32\129\129\32\129\32\129\32\131\131\129\130\131\32\32\32\129\130\131\32\32\32\32\140\140\132","\32\154\32\159\143\32\149\143\32\159\143\32\159\144\149\159\143\32\159\137\145\159\143\144\149\143\32\32\145\32\32\32\145\149\32\144\32\149\32\143\159\32\143\143\32\159\143\32","\32\32\32\152\140\149\151\32\149\149\32\145\149\130\149\157\140\133\32\149\32\154\143\149\151\32\149\32\149\32\144\32\149\149\153\32\32\149\32\149\133\149\149\32\149\149\32\149","\32\32\32\130\131\129\131\131\32\130\131\32\130\131\129\130\131\129\32\129\32\140\140\129\129\32\129\32\129\32\137\140\129\130\32\129\32\130\32\129\32\129\129\32\129\130\131\32","\144\143\32\159\144\144\144\143\32\159\143\144\159\138\32\144\32\144\144\32\144\144\32\144\144\32\144\144\32\144\143\143\144\32\150\129\32\149\32\130\150\32\134\137\134\134\131\148","\136\143\133\154\141\149\151\32\129\137\140\144\32\149\32\149\32\149\154\159\133\149\148\149\157\153\32\154\143\149\159\134\32\130\148\32\32\149\32\32\151\129\32\32\32\32\134\32","\133\32\32\32\32\133\129\32\32\131\131\32\32\130\32\130\131\129\32\129\32\130\131\129\129\32\129\140\140\129\131\131\129\32\130\129\32\129\32\130\129\32\32\32\32\32\129\32","\32\32\32\32\149\32\32\149\32\32\32\32\32\32\32\32\149\32\32\149\32\32\32\32\32\32\32\32\149\32\32\149\32\32\32\32\32\32\32\32\149\32\32\149\32\32\32\32","\32\32\32\32\32\32\32\32\32\32\32\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\32\32\32\32\32\32\32\32\32\32\32","\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32","\32\32\32\32\149\32\32\149\32\32\32\32\32\32\32\32\149\32\32\149\32\32\32\32\32\32\32\32\149\32\32\149\32\32\32\32\32\32\32\32\149\32\32\149\32\32\32\32","\32\32\32\32\32\32\32\32\32\32\32\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\32\32\32\32\32\32\32\32\32\32\32","\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32","\32\32\32\32\145\32\159\139\32\151\131\132\155\143\132\134\135\145\32\149\32\158\140\129\130\130\32\152\147\155\157\134\32\32\144\144\32\32\32\32\32\32\152\131\155\131\131\129","\32\32\32\32\149\32\149\32\145\148\131\32\149\32\149\140\157\132\32\148\32\137\155\149\32\32\32\149\154\149\137\142\32\153\153\32\131\131\149\131\131\129\149\135\145\32\32\32","\32\32\32\32\129\32\130\135\32\131\131\129\134\131\132\32\129\32\32\129\32\131\131\32\32\32\32\130\131\129\32\32\32\32\129\129\32\32\32\32\32\32\130\131\129\32\32\32","\150\150\32\32\148\32\134\32\32\132\32\32\134\32\32\144\32\144\150\151\149\32\32\32\32\32\32\145\32\32\152\140\144\144\144\32\133\151\129\133\151\129\132\151\129\32\145\32","\130\129\32\131\151\129\141\32\32\142\32\32\32\32\32\149\32\149\130\149\149\32\143\32\32\32\32\142\132\32\154\143\133\157\153\132\151\150\148\151\158\132\151\150\148\144\130\148","\32\32\32\140\140\132\32\32\32\32\32\32\32\32\32\151\131\32\32\129\129\32\32\32\32\134\32\32\32\32\32\32\32\129\129\32\129\32\129\129\130\129\129\32\129\130\131\32","\156\143\32\159\141\129\153\140\132\153\137\32\157\141\32\159\142\32\150\151\129\150\131\132\140\143\144\143\141\145\137\140\148\141\141\144\157\142\32\159\140\32\151\134\32\157\141\32","\157\140\149\157\140\149\157\140\149\157\140\149\157\140\149\157\140\149\151\151\32\154\143\132\157\140\32\157\140\32\157\140\32\157\140\32\32\149\32\32\149\32\32\149\32\32\149\32","\129\32\129\129\32\129\129\32\129\129\32\129\129\32\129\129\32\129\129\131\129\32\134\32\131\131\129\131\131\129\131\131\129\131\131\129\130\131\32\130\131\32\130\131\32\130\131\32","\151\131\148\152\137\145\155\140\144\152\142\145\153\140\132\153\137\32\154\142\144\155\159\132\150\156\148\147\32\144\144\130\145\136\137\32\146\130\144\144\130\145\130\136\32\151\140\132","\151\32\149\151\155\149\149\32\149\149\32\149\149\32\149\149\32\149\149\32\149\152\137\144\157\129\149\149\32\149\149\32\149\149\32\149\149\32\149\130\150\32\32\157\129\149\32\149","\131\131\32\129\32\129\130\131\32\130\131\32\130\131\32\130\131\32\130\131\32\32\32\32\130\131\32\130\131\32\130\131\32\130\131\32\130\131\32\32\129\32\130\131\32\133\131\32","\156\143\32\159\141\129\153\140\132\153\137\32\157\141\32\159\142\32\159\159\144\152\140\144\156\143\32\159\141\129\153\140\132\157\141\32\130\145\32\32\147\32\136\153\32\130\146\32","\152\140\149\152\140\149\152\140\149\152\140\149\152\140\149\152\140\149\149\157\134\154\143\132\157\140\133\157\140\133\157\140\133\157\140\133\32\149\32\32\149\32\32\149\32\32\149\32","\130\131\129\130\131\129\130\131\129\130\131\129\130\131\129\130\131\129\130\130\131\32\134\32\130\131\129\130\131\129\130\131\129\130\131\129\32\129\32\32\129\32\32\129\32\32\129\32","\159\134\144\137\137\32\156\143\32\159\141\129\153\140\132\153\137\32\157\141\32\32\132\32\159\143\32\147\32\144\144\130\145\136\137\32\146\130\144\144\130\145\130\138\32\146\130\144","\149\32\149\149\32\149\149\32\149\149\32\149\149\32\149\149\32\149\149\32\149\131\147\129\138\134\149\149\32\149\149\32\149\149\32\149\149\32\149\154\143\149\32\157\129\154\143\149","\130\131\32\129\32\129\130\131\32\130\131\32\130\131\32\130\131\32\130\131\32\32\32\32\130\131\32\130\131\129\130\131\129\130\131\129\130\131\129\140\140\129\130\131\32\140\140\129"},{"000110000110110000110010101000000010000000100101","000000110110000000000010101000000010000000100101","000000000000000000000000000000000000000000000000","100010110100000010000110110000010100000100000110","000000110000000010110110000110000000000000110000","000000000000000000000000000000000000000000000000","000000110110000010000000100000100000000000000010","000000000110110100010000000010000000000000000100","000000000000000000000000000000000000000000000000","010000000000100110000000000000000000000110010000","000000000000000000000000000010000000010110000000","000000000000000000000000000000000000000000000000","011110110000000100100010110000000100000000000000","000000000000000000000000000000000000000000000000","000000000000000000000000000000000000000000000000","110000110110000000000000000000010100100010000000","000010000000000000110110000000000100010010000000","000000000000000000000000000000000000000000000000","010110010110100110110110010000000100000110110110","000000000000000000000110000000000110000000000000","000000000000000000000000000000000000000000000000","010100010110110000000000000000110000000010000000","110110000000000000110000110110100000000010000000","000000000000000000000000000000000000000000000000","000100011111000100011111000100011111000100011111","000000000000100100100100011011011011111111111111","000000000000000000000000000000000000000000000000","000100011111000100011111000100011111000100011111","000000000000100100100100011011011011111111111111","100100100100100100100100100100100100100100100100","000000110100110110000010000011110000000000011000","000000000100000000000010000011000110000000001000","000000000000000000000000000000000000000000000000","010000100100000000000000000100000000010010110000","000000000000000000000000000000110110110110110000","000000000000000000000000000000000000000000000000","110110110110110110000000110110110110110110110110","000000000000000000000110000000000000000000000000","000000000000000000000000000000000000000000000000","000000000000110110000110010000000000000000010010","000010000000000000000000000000000000000000000000","000000000000000000000000000000000000000000000000","110110110110110110110000110110110110000000000000","000000000000000000000110000000000000000000000000","000000000000000000000000000000000000000000000000","110110110110110110110000110000000000000000010000","000000000000000000000000100000000000000110000110","000000000000000000000000000000000000000000000000"}}local cb={}local db={}
do local bc=0;local cc=#bb[1]local dc=#bb[1][1]
for i=1,cc,3 do
for j=1,dc,3 do
local _d=string.char(bc)local ad={}ad[1]=bb[1][i]:sub(j,j+2)
ad[2]=bb[1][i+1]:sub(j,j+2)ad[3]=bb[1][i+2]:sub(j,j+2)local bd={}bd[1]=bb[2][i]:sub(j,
j+2)bd[2]=bb[2][i+1]:sub(j,j+2)bd[3]=bb[2][
i+2]:sub(j,j+2)db[_d]={ad,bd}bc=bc+1 end end;cb[1]=db end
local function _c(bc,cc)local dc={["0"]="1",["1"]="0"}if bc<=#cb then return true end
for f=#cb+1,bc do local _d={}local ad=cb[
f-1]
for char=0,255 do local bd=string.char(char)local cd={}local dd={}
local __a=ad[bd][1]local a_a=ad[bd][2]
for i=1,#__a do local b_a,c_a,d_a,_aa,aaa,baa={},{},{},{},{},{}
for j=1,#__a[1]do
local caa=db[__a[i]:sub(j,j)][1]table.insert(b_a,caa[1])
table.insert(c_a,caa[2])table.insert(d_a,caa[3])
local daa=db[__a[i]:sub(j,j)][2]
if a_a[i]:sub(j,j)=="1"then
table.insert(_aa,(daa[1]:gsub("[01]",dc)))
table.insert(aaa,(daa[2]:gsub("[01]",dc)))
table.insert(baa,(daa[3]:gsub("[01]",dc)))else table.insert(_aa,daa[1])
table.insert(aaa,daa[2])table.insert(baa,daa[3])end end;table.insert(cd,table.concat(b_a))
table.insert(cd,table.concat(c_a))table.insert(cd,table.concat(d_a))
table.insert(dd,table.concat(_aa))table.insert(dd,table.concat(aaa))
table.insert(dd,table.concat(baa))end;_d[bd]={cd,dd}if cc then cc="Font"..f.."Yeld"..char
os.queueEvent(cc)os.pullEvent(cc)end end;cb[f]=_d end;return true end
local function ac(bc,cc,dc,_d,ad)
if not type(cc)=="string"then error("Not a String",3)end
local bd=type(dc)=="string"and dc:sub(1,1)or ab[dc]or
error("Wrong Front Color",3)
local cd=type(_d)=="string"and _d:sub(1,1)or ab[_d]or
error("Wrong Back Color",3)if(cb[bc]==nil)then _c(3,false)end;local dd=cb[bc]or
error("Wrong font size selected",3)if cc==""then
return{{""},{""},{""}}end;local __a={}
for baa in cc:gmatch('.')do table.insert(__a,baa)end;local a_a={}local b_a=#dd[__a[1]][1]
for nLine=1,b_a do local baa={}
for i=1,#__a do baa[i]=dd[__a[i]]and
dd[__a[i]][1][nLine]or""end;a_a[nLine]=table.concat(baa)end;local c_a={}local d_a={}local _aa={["0"]=bd,["1"]=cd}local aaa={["0"]=cd,["1"]=bd}
for nLine=1,b_a do
local baa={}local caa={}
for i=1,#__a do
local daa=dd[__a[i]]and dd[__a[i]][2][nLine]or""
baa[i]=daa:gsub("[01]",
ad and{["0"]=dc:sub(i,i),["1"]=_d:sub(i,i)}or _aa)
caa[i]=daa:gsub("[01]",
ad and{["0"]=_d:sub(i,i),["1"]=dc:sub(i,i)}or aaa)end;c_a[nLine]=table.concat(baa)
d_a[nLine]=table.concat(caa)end;return{a_a,c_a,d_a}end;return ac end
aa["libraries"]["basaltMon"]=function(...)
local ab={[colors.white]="0",[colors.orange]="1",[colors.magenta]="2",[colors.lightBlue]="3",[colors.yellow]="4",[colors.lime]="5",[colors.pink]="6",[colors.gray]="7",[colors.lightGray]="8",[colors.cyan]="9",[colors.purple]="a",[colors.blue]="b",[colors.brown]="c",[colors.green]="d",[colors.red]="e",[colors.black]="f"}local bb,cb,db,_c=type,string.len,string.rep,string.sub
return
function(ac)local bc={}
for _ba,aba in pairs(ac)do
bc[_ba]={}
for bba,cba in pairs(aba)do local dba=peripheral.wrap(cba)if(dba==nil)then
error("Unable to find monitor "..cba)end;bc[_ba][bba]=dba
bc[_ba][bba].name=cba end end;local cc,dc,_d,ad,bd,cd,dd,__a=1,1,1,1,0,0,0,0;local a_a,b_a=false,1
local c_a,d_a=colors.white,colors.black
local function _aa()local _ba,aba=0,0
for bba,cba in pairs(bc)do local dba,_ca=0,0
for aca,bca in pairs(cba)do local cca,dca=bca.getSize()
dba=dba+cca;_ca=dca>_ca and dca or _ca end;_ba=_ba>dba and _ba or dba;aba=aba+_ca end;dd,__a=_ba,aba end;_aa()
local function aaa()local _ba=0;local aba,bba=0,0
for cba,dba in pairs(bc)do local _ca=0;local aca=0
for bca,cca in pairs(dba)do
local dca,_da=cca.getSize()if(cc-_ca>=1)and(cc-_ca<=dca)then aba=bca end;cca.setCursorPos(
cc-_ca,dc-_ba)_ca=_ca+dca
if(aca<_da)then aca=_da end end;if(dc-_ba>=1)and(dc-_ba<=aca)then bba=cba end
_ba=_ba+aca end;_d,ad=aba,bba end;aaa()
local function baa(_ba,...)local aba={...}return
function()for bba,cba in pairs(bc)do for dba,_ca in pairs(cba)do
_ca[_ba](table.unpack(aba))end end end end
local function caa()baa("setCursorBlink",false)()
if not(a_a)then return end;if(bc[ad]==nil)then return end;local _ba=bc[ad][_d]
if(_ba==nil)then return end;_ba.setCursorBlink(a_a)end
local function daa(_ba,aba,bba)if(bc[ad]==nil)then return end;local cba=bc[ad][_d]
if(cba==nil)then return end;cba.blit(_ba,aba,bba)local dba,_ca=cba.getSize()
if
(cb(_ba)+cc>dba)then local aca=bc[ad][_d+1]if(aca~=nil)then aca.blit(_ba,aba,bba)_d=_d+1;cc=cc+
cb(_ba)end end;aaa()end
return
{clear=baa("clear"),setCursorBlink=function(_ba)a_a=_ba;caa()end,getCursorBlink=function()return a_a end,getCursorPos=function()return cc,dc end,setCursorPos=function(_ba,aba)
cc,dc=_ba,aba;aaa()caa()end,setTextScale=function(_ba)
baa("setTextScale",_ba)()_aa()aaa()b_a=_ba end,getTextScale=function()return b_a end,blit=function(_ba,aba,bba)
daa(_ba,aba,bba)end,write=function(_ba)_ba=tostring(_ba)local aba=cb(_ba)
daa(_ba,db(ab[c_a],aba),db(ab[d_a],aba))end,getSize=function()return dd,__a end,setBackgroundColor=function(_ba)
baa("setBackgroundColor",_ba)()d_a=_ba end,setTextColor=function(_ba)
baa("setTextColor",_ba)()c_a=_ba end,calculateClick=function(_ba,aba,bba)local cba=0
for dba,_ca in pairs(bc)do local aca=0;local bca=0
for cca,dca in pairs(_ca)do
local _da,ada=dca.getSize()if(dca.name==_ba)then return aba+aca,bba+cba end
aca=aca+_da;if(ada>bca)then bca=ada end end;cba=cba+bca end;return aba,bba end}end end;return aa["main"]()