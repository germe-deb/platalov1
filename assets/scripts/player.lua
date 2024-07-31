-- player script

-- key mapping (usando baton)
local batonplayer = Baton.new {
  controls = {
    left = {'key:left', 'button:dpleft', 'axis:leftx-'},
    right = {'key:right', 'button:dpright', 'axis:leftx+'},
    up = {'key:up', 'button:dpup', 'axis:lefty-'},
    down = {'key:down', 'button:dpdown', 'axis:lefty+'},
    
    action = {'key:t', 'key:space', 'button:b'},
  },
  pairs = {
      move = {"left", "right", "up", "down"}
  },
  joystick = love.joystick.getJoysticks()[1],
}

-- some variables
local acc = {x=0, y=0, initial=-1.38, ry=0, max=6}
local pl = {x=8, y=108, w=8, h=8}
local gravedad = 4
local onground = false
local touchingceiling = false

local bumpplayer = {pl.x, pl.y, pl.w, pl.h}
World:add(bumpplayer, pl.x, pl.y, pl.w, pl.h)
-- local bumpfeet = {pl.x, pl.y+3.6, pl.w*0.8, pl.h*0.2}
-- World:add(bumpfeet, pl.x, pl.y+3.6, pl.w*0.8, pl.h*0.2)

Player = {}

function Player:load()

end

function Player:update(dt)
  batonplayer:update(dt)
  local goalX, goalY = pl.x, pl.y

  -- code for X movement
  if batonplayer:down 'left' then
    goalX = pl.x - 80*dt
    --pl.x = pl.x - 4*8*dt
  end
  if batonplayer:down 'right' then
    goalX = pl.x + 80*dt
    --pl.x = pl.x + 4*8*dt
  end
  
  -- code for gravity
  acc.y = gravedad * dt + acc.y
  
  -- agregar la aceleración a goalY
  
  if batonplayer:down 'action' and onground == true then
    acc.y = acc.initial 
  end
  
  -- definir el gol x como la posición y + aceleración y
  goalY = pl.y + acc.y*100*dt

  -- max gravity
  if acc.y > acc.max then acc.y = acc.max end
  
  
  -- try to apply goal to the actual player coords
  -- _, _, _, LenF = World:move(bumpfeet, goalX, goalY)
  pl.x, pl.y, _, LenP = World:move(bumpplayer, goalX, goalY)
  
  PlayercminusGoalY = goalY - pl.y
  
  -- detección de "en el piso"
  if PlayercminusGoalY > 0 then
    onground = true
    print('onground true')
    acc.y = 0
  else
    onground = false
    -- print('onground false')
  end

  -- detección de "toqué el techo"
  if PlayercminusGoalY < 0 then
    touchingceiling = true
    print('touchingceiling true')
    acc.y = 0
  else
    touchingceiling = false
    -- print('touchingceiling false')
  end
  Axel = acc.y
  -- debug
  print("player pos:" .. math.floor(pl.x) .. "  " .. math.floor(pl.y))

end

function Player:draw()
  love.graphics.push("all")
  love.graphics.setColor(1,0,1,0.25)
  love.graphics.rectangle("fill", pl.x, pl.y, pl.w, pl.h)
  love.graphics.setColor(1,0,1)
  love.graphics.rectangle("line", pl.x, pl.y, pl.w, pl.h)
  love.graphics.pop()
end
