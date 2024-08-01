-- player script

-- key mapping (usando baton)
local batonplayer = Baton.new {
  controls = {
    left = {'key:left', 'button:dpleft', 'axis:leftx-'},
    right = {'key:right', 'button:dpright', 'axis:leftx+'},
    up = {'key:up', 'button:dpup', 'axis:lefty-'},
    down = {'key:down', 'button:dpdown', 'axis:lefty+'},
    
    jump = {'key:t', 'key:space', 'button:b'},
    cancel = {'key:q', 'key:escape', 'button:start'},
  },
  pairs = {
      move = {"left", "right", "up", "down"}
  },
  joystick = love.joystick.getJoysticks()[1],
}

-- some variables
local acc = {x=0, y=0, initial=-1.38, ry=0, max=6, fx=15, maxX=1.5}
local pl = {x=8, y=176, w=7.6, h=7.6}
local gravedad = 4

local onground = false
local touchingceiling = false
local choque = false

Player = {}

local bumpplayer = {pl.x, pl.y, pl.w, pl.h, isPlayer=true}
World:add(bumpplayer, pl.x, pl.y, pl.w, pl.h)

-- filtros
local collidablefilter = function(_, other)
  if other.type == "spike" then
    return "cross"
  elseif other.type == "ending" then
    return "slide"
  elseif other.type == "coin" then
    return "cross"
  else
    return "slide"
  end
end


function Player:load()
  
end

function Player:update(dt)
  batonplayer:update(dt)
  local goalX, goalY = pl.x, pl.y
  
  -- 
  -- code for X movement
  if batonplayer:down 'left' then
    acc.x = acc.x - acc.fx*dt
  elseif batonplayer:down 'right' then
    acc.x = acc.x + acc.fx*dt
  elseif acc.x < 0.2 and acc.x > -0.2 then
  acc.x = 0
  end
  
  if acc.x > 0 then
    acc.x = acc.x - acc.fx*dt*0.5
  elseif acc.x < 0 then
    acc.x = acc.x + acc.fx*dt*0.5
  end
  
  if acc.x > acc.maxX then
    acc.x = acc.maxX
  elseif acc.x < -acc.maxX then
    acc.x = -acc.maxX
  end
  
  goalX = pl.x + acc.x
  
  -- code for gravity
  acc.y = gravedad * dt + acc.y

  if batonplayer:down 'jump' and onground == true then
    acc.y = acc.initial 
  end
  
  -- definir el gol y como la posición y + aceleración y
  goalY = pl.y + acc.y*100*dt

  -- max gravity
  if acc.y > acc.max then acc.y = acc.max end
  
  
  -- tratar de moverse
  pl.x, pl.y, col, LenP = World:move(bumpplayer, goalX, goalY, collidablefilter)
  
  PLmGY = goalY - pl.y
  PLmGX = goalX - pl.x
  -- detección de "en el piso"
  if PLmGY > 0 then
    onground = true
    print('onground true')
    acc.y = 0
  else
    onground = false
    -- print('onground false')
  end

  -- detección de "toqué el techo"
  if PLmGY < 0 then
    touchingceiling = true
    print('touchingceiling true')
    acc.y = 0
  else
    touchingceiling = false
    -- print('touchingceiling false')
  end
  
  -- choque (horizontal)
  if PLmGX ~= 0 then
    choque = true
    print('choque')
    acc.x = 0
  else
    choque = false
  end

  Axel = acc.y
  -- debug
  -- print("player pos:" .. math.floor(pl.x) .. "  " .. math.floor(pl.y))

end

function Player:draw()
  love.graphics.push("all")
  love.graphics.setColor(1,0,1,0.25)
  love.graphics.rectangle("fill", pl.x, pl.y, pl.w-(pl.w*0.1), pl.h-(pl.h*0.1))
  love.graphics.setColor(1,0,1)
  love.graphics.rectangle("line", pl.x, pl.y, pl.w, pl.h)
  love.graphics.pop()
end
