------- configuration --------------------------------

local terminal = term.current()
local w,h = terminal.getSize()
local ws,hs = w/212,h/75
local bs = math.max((w*h)/(212*75),0.7)

--fireworks
local firework_particles = {100,200}
local colors_range = {2,5}
local multicolor_firework_chance = 5

local fancy_fireworks = true
local fancy_firework_particles = {100,500}
local fancy_firework_chance = 20
local multicolor_fancy_firework_chance = 2

local max_fireworks = 2
local firework_chance = 10*bs

local min_turn_height =  h-h/3
local turn_chance = math.max(5*hs,2)
local max_turn = {45,-45}
local max_turns = 2

local rocket_explode_range = {h/3,h-h/3}
local explode_chance = 10*bs
local max_height = 4*bs

local firework_ranges = {0.5*bs,bs,bs,2*bs,2*bs,3*bs}
local firework_sizes = {0.5*bs,bs,bs,bs,2*bs,3*bs}

local rocket_acceleration_range = {200*hs,500*hs}

local firework_colors = {
    colors.blue,
    colors.cyan,
    colors.green,
    colors.lightBlue,
    colors.lime,
    colors.magenta,
    colors.orange,
    colors.pink,
    colors.purple
}
------------------------------------------------------

--stars
local star_types  = "x+*."

local star_state_change_range = {800,2000}
local star_chance = 30*bs

local star_colors = {
    colors.gray,
    colors.lightGray
}
------------------------------------------------------

--particles
local particle_sizes = {"#","X","O","\4","+","*","-",":",",","."}

local acceleration_range = {200*(bs*2),500*(bs*2)}
local deceleration_range = {5*(bs*2),10*(bs*2)}
local gravity_range = {8,30}

local particle_life_range = {5*bs,20*bs}
local round_expanding = true
------------------------------------------------------

local win = window.create(terminal,1,1,w,h)
local stars = {}
local fireworks = {}
local particles = {}

local function get_rand_color()
    local copy = {}
    local out = {}
    for k,v in pairs(firework_colors) do
        copy[#copy+1] = v
    end
    for i=1,math.random(colors_range[1],colors_range[2]) do
        local val = table.remove(copy,math.random(1,#copy))
        if not val then break end
        out[#out+1] = val
    end
    return out
end

local function is_offscreen(x,y)
    return x < 0
        or x > w
end

local function star(x,y)
    local tp = math.random(1,#star_types)
    stars[#stars+1] = {
        pos = {x=x,y=y},
        change_rate = math.random(
            star_state_change_range[1],
            star_state_change_range[2]
        ),
        type=star_types:sub(tp,tp),
        lit=math.random(1,2),
        changed=os.epoch("utc")
    }
end

local function particle(x,y,color,range_mult,size_mult)
    particles[#particles+1] = {
        pos={x=x,y=y},
        color = color,
        life = math.random(particle_life_range[1], particle_life_range[2]) * size_mult,
        duration = 1,
        acceleration = (math.random(acceleration_range[1],acceleration_range[2])/1000) * size_mult * range_mult,
        direction = math.random()*2*math.pi,
        gravity = (math.random(gravity_range[1],gravity_range[2])/100) * size_mult * range_mult,
        energy_loss = (math.random(deceleration_range[1],deceleration_range[2])/1000) * size_mult * range_mult
    }
end

local function firework(x,y)
    fireworks[#fireworks+1] = {
        pos={x=x,y=y},
        direction=0,
        acceleration = math.random(rocket_acceleration_range[1],rocket_acceleration_range[2])/100,
        char = "|",
        turns = 0,
        life = math.random(rocket_explode_range[1],rocket_explode_range[2]),
        duration = 0
    }
end

local function draw_stars()
    local tCurrent = os.epoch("utc")
    for k,v in pairs(stars) do
        win.setTextColor(star_colors[v.lit])
        win.setCursorPos(v.pos.x,v.pos.y)
        win.write(v.type)
        if tCurrent >= v.changed+v.change_rate then
            v.lit = (v.lit == 1) and 2 or 1
            v.changed = tCurrent
        end
    end
end

local function update_fireworks()
    local exploded = {}
    for k,v in pairs(fireworks) do
        v.pos.x = -v.acceleration*math.cos(math.rad(v.direction) + math.pi/2) + v.pos.x
        v.pos.y = -v.acceleration*math.sin(math.rad(v.direction) + math.pi/2) + v.pos.y
        if v.direction > 10 then v.char = "/"
        elseif v.direction < -10 then v.char = "\\"
        else v.char = "|" end
        if v.pos.y <= min_turn_height and math.random(1,turn_chance) == 1 and v.turns < max_turns then
            local tp = math.random(1,2)
            v.direction = v.direction + max_turn[tp] - math.random()*max_turn[tp]
            v.turns = v.turns + 1
        end
        v.duration = v.duration + math.max(rocket_acceleration_range[1],rocket_acceleration_range[2])/100
        if (v.duration >= v.life and math.random(1,explode_chance) == 1) or v.pos.y <= max_height then
            local rocket = table.remove(fireworks,k)
            if rocket then
                local c  = get_rand_color()
                local c2 = get_rand_color()
                local cSingle = firework_colors[math.random(1,#firework_colors)]
                local c2Single = firework_colors[math.random(1,#firework_colors)]
                local multicolor = math.random(1,multicolor_firework_chance) == 1
                local range = firework_ranges[math.random(1,#firework_ranges)]
                local size =  firework_sizes [math.random(1,#firework_sizes) ]
                for i=1,math.random(firework_particles[1],firework_particles[2]) do
                    if multicolor then
                        particle(rocket.pos.x,rocket.pos.y,c[math.random(1,#c)],range,size)
                    else
                        particle(rocket.pos.x,rocket.pos.y,cSingle,range,size)
                    end
                end
                if fancy_fireworks and math.random(1,fancy_firework_chance) == 1  then
                    local multicolor = math.random(1,multicolor_fancy_firework_chance) == 1
                    for i=1,math.random(fancy_firework_particles[1],fancy_firework_particles[2]) do
                        if not multicolor then
                            particle(rocket.pos.x,rocket.pos.y,c2Single,range,size*2)
                        else
                            particle(rocket.pos.x,rocket.pos.y,c2[math.random(1,#c2)],range,size*2)
                        end
                    end
                end
            end
        end
    end
    for i=1,max_fireworks-#fireworks do
        if #fireworks < max_fireworks and math.random(1,firework_chance) == 1 then
            firework(math.random(1,w),h)
        end
    end
end

local function draw_fireworks()
    win.setTextColor(colors.white)
    for k,v in pairs(fireworks) do
        win.setCursorPos(v.pos.x,v.pos.y)
        win.write(v.char)
    end
end

local function update_particles()
    for k,v in pairs(particles) do
        v.pos.y = v.pos.y + v.gravity
        v.duration = v.duration + 1

        if round_expanding then
            v.pos = {
                x = v.acceleration*3*math.cos(v.direction)/3 + v.pos.x,
                y = v.acceleration*2*math.sin(v.direction)/3 + v.pos.y
            }
        else
            v.pos = {
                x = v.acceleration*math.cos(v.direction) + v.pos.x,
                y = v.acceleration*math.sin(v.direction) + v.pos.y
            }
        end

        v.acceleration = math.max(v.acceleration - v.energy_loss,0)

        if v.duration > v.life or is_offscreen(v.pos.x,v.pos.y) then
            v.duration = v.duration - 1
            table.remove(particles,k)
        end
    end
end

local function draw_particles()
    local buffer = {}
    for k,v in pairs(particles) do
        local char_index = math.ceil((math.min(v.duration/v.life,1))*#particle_sizes)
        if not buffer[v.pos.y] then buffer[v.pos.y] = {} end
        if not buffer[v.pos.y][v.pos.x] then buffer[v.pos.y][v.pos.x] = {char=char_index,obj=v}
        elseif buffer[v.pos.y][v.pos.x].char > char_index then
            buffer[v.pos.y][v.pos.x] = {char=char_index,obj=v}
        end
    end
    for y,x_list in pairs(buffer) do
        for x,v in pairs(x_list) do
            win.setCursorPos(x,y)
            win.setTextColor(v.obj.color)
            win.write(particle_sizes[v.char])
        end
    end
end

local function init()
    for x=1,w do
        for y=1,h do
            if math.random(1,star_chance) == 1 then
                star(x,y)
            end
        end
    end
end

local function main()
    init()
    local tId = os.startTimer(0.05)
    while true do
        local ev,tid,x,y = os.pullEvent()
        if ev == "timer" and tid == tId then
            tId = os.startTimer(0.05)
            win.setVisible(false)
            win.clear()
            draw_stars()
            update_fireworks()
            draw_fireworks()
            update_particles()
            draw_particles()
            win.setVisible(true)
        elseif ev == "mouse_click" or ev == "mouse_drag" or ev == "monitor_touch" then
            firework(x,y)
        end
    end
end

xpcall(main,function(e)
    term.setCursorPos(1,1)
    printError(e)
end)